import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../mock/video.dart';

typedef LoadMoreVideo = Future<List<VPVideoController>> Function(
  int index,
  List<VPVideoController> list,
);

/// VideoPlayVideoListController是一系列视频的控制器，内部管理了视频控制器数组
/// 提供了预加载/释放/加载更多功能
class VideoPlayVideoListController extends ChangeNotifier {
  VideoPlayVideoListController({
    this.loadMoreCount = 1,
    this.preloadCount = 2,

    /// TODO: VideoPlayer有bug(安卓)，当前只能设置为0
    /// 设置为0后，任何不在画面内的视频都会被释放
    /// 若不设置为0，安卓将会无法加载第三个开始的视频
    this.disposeCount = 0,
  });

  /// 到第几个触发预加载，例如：1:最后一个，2:倒数第二个
  final int loadMoreCount;

  /// 预加载多少个视频
  final int preloadCount;

  /// 超出多少个，就释放视频
  final int disposeCount;

  /// 提供视频的builder
  LoadMoreVideo? _videoProvider;

  loadIndex(int target, {bool reload = false}) {
    if (!reload) {
      if (index.value == target) return;
    }
    // 播放当前的，暂停其他的
    var oldIndex = index.value;
    var newIndex = target;

    // 暂停之前的视频
    if (!(oldIndex == 0 && newIndex == 0)) {
      playerOfIndex(oldIndex)?.controller.seekTo(Duration.zero);
      // playerOfIndex(oldIndex)?.controller.addListener(_didUpdateValue);
      // playerOfIndex(oldIndex)?.showPauseIcon.addListener(_didUpdateValue);
      playerOfIndex(oldIndex)?.pause();
      debugPrint('暂停$oldIndex');
    }
    // 开始播放当前的视频
    playerOfIndex(newIndex)?.controller.addListener(_didUpdateValue);
    playerOfIndex(newIndex)?.showPauseIcon.addListener(_didUpdateValue);
    playerOfIndex(newIndex)?.play();
    debugPrint('播放$newIndex');
    // 处理预加载/释放内存
    for (var i = 0; i < playerList.length; i++) {
      /// 需要释放[disposeCount]之前的视频
      /// i < newIndex - disposeCount 向下滑动时释放视频
      /// i > newIndex + disposeCount 向上滑动，同时避免disposeCount设置为0时失去视频预加载功能
      if (i < newIndex - disposeCount || i > newIndex + max(disposeCount, 2)) {
        debugPrint('释放$i');
        playerOfIndex(i)?.controller.removeListener(_didUpdateValue);
        playerOfIndex(i)?.showPauseIcon.removeListener(_didUpdateValue);
        playerOfIndex(i)?.dispose();
        continue;
      }
      // 需要预加载
      if (i > newIndex && i < newIndex + preloadCount) {
        debugPrint('预加载$i');
        playerOfIndex(i)?.init();
        continue;
      }
    }
    // 快到最底部，添加更多视频
    if (playerList.length - newIndex <= loadMoreCount + 1) {
      debugPrint('++++++++++++ +++++++++++  加载更多 11111 ');
      _videoProvider?.call(newIndex, playerList).then((list) async {
        playerList.addAll(list);
        notifyListeners();
      },
      );
    }

    // 完成
    index.value = target;
  }

  _didUpdateValue() {
    notifyListeners();
  }

  /// 获取指定index的player
  VPVideoController? playerOfIndex(int index) {
    if (index < 0 || index > playerList.length - 1) {
      return null;
    }
    return playerList[index];
  }

  /// 视频总数目
  int get videoCount => playerList.length;

  /// 初始化
  init({
    required PageController pageController,
    required List<VPVideoController> initialList,
    required LoadMoreVideo videoProvider,
  }) async {
    playerList.addAll(initialList);
    _videoProvider = videoProvider;
    pageController.addListener(() {
      var p = pageController.page!;
      // debugPrint('++++++---------******  p = $p   p % 1 = ${p % 1}   p ~/ 1 = ${p ~/ 1}');
      if (p % 1 == 0) {
        loadIndex(p ~/ 1);
      }
    });
    loadIndex(0, reload: true);
    notifyListeners();
  }

  /// 目前的视频序号
  ValueNotifier<int> index = ValueNotifier<int>(0);

  /// 视频列表
  List<VPVideoController> playerList = [];

  ///
  VPVideoController get currentPlayer => playerList[index.value];

  /// 销毁全部
  @override
  void dispose() {
    // 销毁全部
    for (var player in playerList) {
      player.showPauseIcon.dispose();
      player.dispose();
    }
    playerList = [];
    super.dispose();
  }
}

typedef ControllerSetter<T> = Future<void> Function(T controller);
typedef ControllerBuilder<T> = T Function();

/// 抽象类，作为视频控制器必须实现这些方法
abstract class VideoPlayVideoController<T> {
  /// 获取当前的控制器实例
  T? get controller;

  /// 是否显示暂停按钮
  ValueNotifier<bool> get showPauseIcon;

  /// 加载视频，在init后，应当开始下载视频内容
  Future<void> init({ControllerSetter<T>? afterInit});

  /// 视频销毁，在dispose后，应当释放任何内存资源
  Future<void> dispose();

  /// 播放
  Future<void> play();

  /// 暂停
  Future<void> pause({bool showPauseIcon = false});
}

/// 异步方法并发锁
Completer<void>? _syncLock;

class VPVideoController extends VideoPlayVideoController<VideoPlayerController> {
  VideoPlayerController? _controller;
  final ValueNotifier<bool> _showPauseIcon = ValueNotifier<bool>(false);

  final UserVideo? videoInfo;

  final ControllerBuilder<VideoPlayerController> _builder;
  final ControllerSetter<VideoPlayerController>? _afterInit;
  VPVideoController({
    this.videoInfo,
    required ControllerBuilder<VideoPlayerController> builder,
    ControllerSetter<VideoPlayerController>? afterInit,
  })  : _builder = builder,
        _afterInit = afterInit;

  @override
  VideoPlayerController get controller {
    _controller ??= _builder.call();
    return _controller!;
  }

  bool get isDispose => _disposeLock != null;
  bool get prepared => _prepared;
  bool _prepared = false;

  Completer<void>? _disposeLock;

  /// 防止异步方法并发
  Future<void> _syncCall(Future Function()? fn) async {
    // 设置同步等待
    // debugPrint('============ _syncCall = 1111');
    var lastCompleter = _syncLock;
    // debugPrint('============ _syncCall = 2222, lastCompleter = $lastCompleter');
    var completer = Completer<void>();
    // debugPrint('============ _syncCall = 3333, lastCompleter = $lastCompleter');
    _syncLock = completer;
    // debugPrint('============ _syncCall = 4444, lastCompleter = $lastCompleter');
    // 等待其他同步任务完成
    await lastCompleter?.future;
    // debugPrint('============ _syncCall = 5555, lastCompleter = $lastCompleter');
    // 主任务
    await fn?.call();
    // debugPrint('============ _syncCall = 6666, lastCompleter = $lastCompleter');
    // 结束
    completer.complete();
    // debugPrint('============ _syncCall = 7777, lastCompleter = $lastCompleter');
  }

  @override
  Future<void> dispose() async {
    // debugPrint(' =======---VPVideoController---========  dispose  prepared = $prepared');
    if (!prepared) return;
    _prepared = false;
    await _syncCall(() async {
      debugPrint('+++dispose $hashCode');
      await controller.dispose();
      _controller = null;
      debugPrint('+++==dispose $hashCode');
      _disposeLock = Completer<void>();
    });
  }

  @override
  Future<void> init({
    ControllerSetter<VideoPlayerController>? afterInit,
  }) async {
    if (prepared) return;
    await _syncCall(() async {
      debugPrint('+++initialize00 $hashCode, $controller');
      await controller.initialize().then((value) {
        debugPrint('===============----------   value = ');
      }).catchError((error) {
        debugPrint('===============----------   error = $error');
      });
      // debugPrint('+++initialize11 $hashCode');
      await controller.setLooping(true);
      // debugPrint('+++initialize22 $hashCode');
      afterInit ??= _afterInit;
      // debugPrint('+++initialize33 $hashCode');
      await afterInit?.call(controller);
      debugPrint('+++==initialize $hashCode');
      _prepared = true;
    });
    if (_disposeLock != null) {
      _disposeLock?.complete();
      _disposeLock = null;
    }
  }

  @override
  Future<void> pause({bool showPauseIcon = false}) async {
    await init();
    if (!prepared) return;
    if (_disposeLock != null) {
      await _disposeLock?.future;
    }
    await controller.pause();
    _showPauseIcon.value = true;
  }

  @override
  Future<void> play() async {
    await init();
    if (!prepared) return;
    if (_disposeLock != null) {
      await _disposeLock?.future;
    }
    await controller.play();
    _showPauseIcon.value = false;
  }

  @override
  ValueNotifier<bool> get showPauseIcon => _showPauseIcon;
}