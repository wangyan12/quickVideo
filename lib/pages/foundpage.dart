
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh_strong/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../net/repository_auth.dart';
import '../net/string.dart';

class FoundPageView extends StatefulWidget {
  const FoundPageView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FoundPageViewState();
  }
}
class FoundPageViewState extends State<FoundPageView> with SingleTickerProviderStateMixin {
  List<String> tabTextList = ["关注", "推荐"];
  List<Tab> tabWidgetList = [];
  TabController? tabController;
  ///推荐模拟数据
  List <VideoModel> videoList =[];
  ///关注模拟数据
  List <VideoModel> videoList2 =[];
  EasyRefreshController? _easyRefreshController; // 下拉刷新控制器
  bool dropDownRefresh = false;   // 下拉刷新
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    for (var value in tabTextList) {
      tabWidgetList.add(
        Tab(text: value),
      );
    }
    tabController = TabController(length: tabTextList.length, vsync: this);
    tabController!.addListener(() {
      tabIndex = tabController!.index;
    });

    for (int i = 0; i < 10; i++) {
      VideoModel videoModel = VideoModel();
      videoModel.videoName = "推荐测试数据$i";
      videoModel.pariseCount = i * 22;
      if (i % 3 == 0) {
        videoModel.isAttention = true;
        videoModel.isLike = true;
      } else {
        videoModel.isAttention = false;
        videoModel.isLike = false;
      }
      videoModel.videoImag ="";
      videoModel.videoUrl ="assets/mp4/bee.mp4";
      videoList.add(videoModel);
    }

    for (int i = 0; i < 3; i++) {
      VideoModel videoModel = VideoModel();
      videoModel.videoName = "关注测试数据$i";
      videoModel.pariseCount = i * 22;
      videoModel.isAttention = true;
      if (i % 3 == 0) {
        videoModel.isLike = true;
      } else {
        videoModel.isLike = false;
      }
      videoModel.videoImag ="";
      videoModel.videoUrl ="assets/mp4/bee.mp4";
      videoList2.add(videoModel);
    }
  }
  @override
  void dispose() {
    super.dispose();
    _easyRefreshController?.dispose();
  }
  Future<void> request() async {
    await RepositoryAuth.commend(data: await mapString(data: {}), context: context).then((value) {
      debugPrint('********======= commend  value = $value');
      _easyRefreshController!.finishLoad(success: true, noMore: true);
      setState(() { });
    }).catchError((error) {
      _easyRefreshController!.finishLoad(success: true, noMore: false);
      debugPrint('********======= commend 111111  error = $error');
    });
  }
  @override
  Widget build(BuildContext context) {
    return buildRootBody();
  }
  Widget buildRootBody() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              color: Colors.black,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: buildTableViewWidget(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 30,
            child: buildTabBarWidget(),
          ),
        ],
      ),
    );
  }
  ///构建 TabBarView
  buildTableViewWidget() {
    return TabBarView(
      controller: tabController,
      children: tabTextList.map((value) => buildTableViewItemWidget(value)).toList(),
    );
  }

  /// 用来创建上下滑动的页面
  Widget buildTableViewItemWidget(String value) {
    List<VideoModel> list =[];
    if (value == "推荐") {
      list= videoList;
    } else {
      list = videoList2;
    }
    return NotificationListener(
      onNotification: (Notification state) {
        if (state is OverscrollNotification) {
          if (state.overscroll < 0) {
            dropDownRefresh = true;
          }
        } else if (state is ScrollEndNotification) {
          if (dropDownRefresh) {
            debugPrint('+++++++++************ 下拉刷新  tabIndex = $tabIndex');
            setState(() {
              dropDownRefresh = false;
            });
          }
        }
        return true;
      },
      child: PageView.builder(
        itemCount:list.length , /// pageView中 子条目的个数
        scrollDirection: Axis.vertical, /// 上下滑动
        // allowImplicitScrolling: true,
        itemBuilder: (BuildContext context,int index) {
          VideoModel videoModel = list[index];
          return buildPageViewItemWidget(value,videoModel);
        },
        onPageChanged: (index) {
          debugPrint('===========----------- onPageChanged  index = $index  tabIndex = $tabIndex');
          if (tabIndex == 0) {
            if (videoList2.length == index + 1) {
              debugPrint('+++++------ 关注  加载更多');
            }
          } else {
            if (videoList.length == index + 1) {
              debugPrint('+++++------ 推荐  加载更多');
            }
          }
        },
      ),
    );

  }
  buildPageViewItemWidget(String value, VideoModel videoModel) {
    return FindVideoItemPage(value, videoModel, key: ValueKey(videoModel.videoName),);
  }

  ///构建顶部标签部分
  buildTabBarWidget() {
    return Container(
      ///对齐在顶部中间
      alignment: Alignment.topCenter,
      child: TabBar(
        controller: tabController,
        tabs: tabWidgetList,
        ///指示器的颜色
        indicatorColor: Colors.white,
        ///指示器的高度
        indicatorWeight: 2.0,
        isScrollable: true,
        ///指示器的宽度与文字对齐
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}

///播放视频的页面
class FindVideoItemPage extends StatefulWidget {
  const FindVideoItemPage(this.tabValue, this.videoModel, {Key? key}) : super(key: key);
  final String tabValue;
  final VideoModel videoModel;

  @override
  State<StatefulWidget> createState() {
    return FindVideoItemPageState();
  }
}

class FindVideoItemPageState extends State<FindVideoItemPage> {
  ///创建视频播放控制 器
  VideoPlayerController? videoPlayerController;
  ///控制更新视频加载初始化完成状态更新
  Future? videoPlayFuture;
  // ChewieController? chewieController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.asset(widget.videoModel.videoUrl);
    videoPlayFuture = videoPlayerController!.initialize().then((_) {
      debugPrint('++++++++++*********** 视频初始完成后  调用播放');
      ///视频初始完成后 ///调用播放
      videoPlayerController!.play();
      setState(() {});
    });
    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController!,
    //   aspectRatio: videoPlayerController!.value.aspectRatio,
    //   autoPlay: true,
    //   looping: true,
    // );
  }
  @override
  void didUpdateWidget(FindVideoItemPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('+++++-----*****  1111');
  }
  @override
  void reassemble() {
    super.reassemble();
    debugPrint('+++++-----*****  2222');
  }
  @override
  void deactivate() {
    super.deactivate();
    debugPrint('+++++-----*****  3333');
  }
  @override
  void activate() {
    super.activate();
    debugPrint('+++++-----*****  4444');
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('+++++-----*****  5555');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ///播放视频
        buildVideoWidget(),
        // Chewie(controller: chewieController!),

        Center(
          child: Text(
            widget.videoModel.videoName,
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 20.sp,
              // fontWeight: 20.sp,
            ),
          ),
        ),

        // ///控制播放视频按钮
        // buildControllWidget(),

        // ///底部区域的视频介绍
        // buildBottmFlagWidget(),

        // ///右侧的用户信息按钮区域
        // buildRightUserWidget(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('++++++++++++ dispose  事件');
    videoPlayerController!.dispose();
    // chewieController!.dispose();
  }

  ///播放视频
  buildVideoWidget() {
    return FutureBuilder(
      key: ValueKey(widget.videoModel.videoName),
      future: videoPlayFuture,
      builder: (BuildContext ctx, value) {
        if (value.connectionState == ConnectionState.done) {
          ///点击事件
          return InkWell(
            onTap: () {
              if (videoPlayerController!.value.isInitialized) {
                /// 视频已初始化
                debugPrint('=======---------======  videoPlayerController!.value.isPlaying = ${videoPlayerController!.value.isPlaying}');
                if (videoPlayerController!.value.isPlaying) {
                  /// 正播放 --- 暂停
                  videoPlayerController!.pause();
                } else {
                  ///暂停 ----播放
                  videoPlayerController!.play();
                }
                setState(() {});
              } else {
                ///未初始化
                videoPlayerController!.initialize().then((_) {
                  videoPlayerController!.play();
                  setState(() {});
                });
              }
            },
            ///居中
            child: Center(
              /// AspectRatio 组件用来设定子组件宽高比
              child: AspectRatio(
                ///设置视频的大小 宽高比。长宽比表示为宽高比。例如，16:9宽高比的值为16.0/9.0
                aspectRatio: videoPlayerController!.value.aspectRatio,
                ///播放视频的组件
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(videoPlayerController!),
                    VideoProgressIndicator(videoPlayerController!, allowScrubbing: true),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            ///圆形加载进度
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }

}

class VideoModel {
  ///视频名称
  String videoName ='';
  ///视频链接
  String videoUrl ='';
  ///视频截图
  String videoImag ='';
  ///是否关注
  bool isAttention =false;
  ///关注的个数
  num attentCount =0;
  ///是否喜欢
  bool isLike = false;
  ///点赞的个数
  num pariseCount = 0;
  ///分享的次数
  num shareCount=0;
}