import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safemap/safemap.dart';
import 'package:shipin/event_bus.dart';
import 'package:shipin/mock/video.dart';
import 'package:shipin/net/repository_auth.dart';
import 'package:shipin/net/string.dart';
import 'package:shipin/styles.dart';
import 'package:shipin/views/tikTokVideo.dart';
import 'package:shipin/views/tikTokVideoButtonColumn.dart';
import 'package:shipin/widgets/refresh.dart';
import 'package:video_player/video_player.dart';
import '../controller/tikTokVideoListController.dart';
import '../style/physics.dart';
import '../views/tikTokCommentBottomSheet.dart';
import '../views/tikTokHeader.dart';
import '../views/tikTokScaffold.dart';
import '../views/tiktokTabBar.dart';
import 'channel_page.dart';
import 'found_page.dart';
import 'foundpage.dart';
import 'game_page.dart';
import 'my_page.dart';
import 'video_playback/video_playback_page.dart';

/// 单独修改了bottomSheet组件的高度
import 'package:shipin/other/bottomSheet.dart' as CustomBottomSheet;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}
class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  TikTokPageTag tabBarType = TikTokPageTag.home;

  TikTokScaffoldController tkController = TikTokScaffoldController();
  PageController pageController = PageController();
  TikTokVideoListController videoListController = TikTokVideoListController();

  /// 记录点赞
  Map<int, bool> favoriteMap = {};
  /// 记录收藏
  Map<int, bool> collectMap = {};
  List<UserVideo> videoDataList = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) {
      videoListController.currentPlayer.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    videoListController.currentPlayer.pause();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    videoDataList = UserVideo.fetchVideo();
    WidgetsBinding.instance.addObserver(this);
    videoListController.init(
      pageController: pageController,
      initialList: videoDataList.map((e) => VPVideoController(
          videoInfo: e,
          builder: () => VideoPlayerController.network(e.url),
        ),
      ).toList(),
      videoProvider: (int index, List<VPVideoController> list) async {
        return videoDataList.map((e) => VPVideoController(
            videoInfo: e,
            builder: () => VideoPlayerController.network(e.url),
          ),
        ).toList();
      },
    );
    videoListController.addListener(() {
      setState(() {});
    });
    tkController.addListener(() {
        if (tkController.value == TikTokPagePositon.middle) {
          videoListController.currentPlayer.play();
        } else {
          videoListController.currentPlayer.pause();
        }
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    Widget? currentPage;

    switch (tabBarType) {
      case TikTokPageTag.home:
        break;
      case TikTokPageTag.follow:
        currentPage = const GamePage();
        break;
      case TikTokPageTag.msg:
        currentPage = const ChannelPage();
        break;
      case TikTokPageTag.me:
        currentPage = const MyPage();
        break;
    }
    double a = MediaQuery.of(context).size.aspectRatio;
    bool hasBottomPadding = a < 0.55;

    bool hasBackground = hasBottomPadding;
    hasBackground = tabBarType != TikTokPageTag.home;
    if (hasBottomPadding) {
      hasBackground = true;
    }
    Widget tikTokTabBar = TikTokTabBar(
      hasBackground: hasBackground,
      current: tabBarType,
      onTabSwitch: (type) async {
        setState(() {
          tabBarType = type;
          if (type == TikTokPageTag.home) {
            videoListController.currentPlayer.play();
          } else {
            videoListController.currentPlayer.pause();
          }
        });
      },
      onAddButton: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const FoundPageView(),
          ),
        );
      },
    );

    // var userPage = UserPage(
    //   isSelfPage: false,
    //   canPop: true,
    //   onPop: () {
    //     tkController.animateToMiddle();
    //   },
    // );
    // var searchPage = SearchPage(
    //   onPop: tkController.animateToMiddle,
    // );

    var header = tabBarType == TikTokPageTag.home ? TikTokHeader(
      onSearch: () {
        debugPrint('=====-----=------- 搜索点击事件！！！');
        tkController.animateToLeft();
      },
      onItemEvent: (int index) {
        debugPrint('=====-----=-------item点击事件 index = $index');
      },
    ) : Container();

    // 组合
    return TikTokScaffold(
      controller: tkController,
      hasBottomPadding: hasBackground,
      tabBar: tikTokTabBar,
      header: header,
      // leftPage: searchPage,
      // rightPage: userPage,
      enableGesture: tabBarType == TikTokPageTag.home,
      // onPullDownRefresh: _fetchData,
      page: Stack(
        // index: currentPage == null ? 0 : 1,
        children: <Widget>[
          Column(
            children: [
              Container(
                height: ScreenUtil().statusBarHeight,
                color: Colors.white,
              ),
              Expanded(
                child: PageView.builder(
                  key: const Key('home'),
                  physics: const QuickerScrollPhysics(),
                  controller: pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: videoListController.videoCount,
                  itemBuilder: (context, i) {
                    // 拼一个视频组件出来
                    bool isF = SafeMap(favoriteMap)[i].boolean;
                    bool isC = SafeMap(collectMap)[i].boolean;
                    var player = videoListController.playerOfIndex(i)!;
                    var data = player.videoInfo!;
                    // 右侧按钮列
                    Widget buttons = TikTokButtonColumn(
                      isFavorite: isF,
                      isCollect: isC,
                      onAvatar: () {
                        tkController.animateToPage(TikTokPagePositon.right);
                      },
                      onFavorite: () {
                        setState(() {
                          favoriteMap[i] = !isF;
                        });
                        // showAboutDialog(context: context);
                      },
                      onComment: () {
                        CustomBottomSheet.showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) => const TikTokCommentBottomSheet(),
                        );
                      },
                      onCollect: () {
                        debugPrint(' ===----==== ---====  收藏点击事件 ===== ');
                        setState(() {
                          collectMap[i] = !isC;
                        });
                      },
                      onShare: () {
                        showBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(25.w)),
                          ), //圆角
                          context: context,
                          builder: (ctx) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 22.5.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 15.w, right: 8.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '分享至',
                                        style: TextStyle(
                                          color: const Color(0xff3d3d3d),
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(ctx);
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: Container(
                                          width: 27.w,
                                          height: 27.w,
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            'assets/images/icon_close.png',
                                            width: 13.w,
                                            height: 13.w,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 11.5.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              debugPrint('微信 分享 点击事件');
                                            },
                                            behavior: HitTestBehavior.opaque,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/icon_wx.png',
                                                  width: 42.w,
                                                  height: 42.w,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(height: 8.5.h),
                                                Text(
                                                  '微信',
                                                  style: TextStyle(
                                                    color: const Color(0xff3c3c3c),
                                                    fontSize: 13.sp,
                                                    height: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              debugPrint('朋友圈 分享 点击事件');
                                            },
                                            behavior: HitTestBehavior.opaque,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/icon_pyq.png',
                                                  width: 42.w,
                                                  height: 42.w,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(height: 8.5.h),
                                                Text(
                                                  '朋友圈',
                                                  style: TextStyle(
                                                    color: const Color(0xff3c3c3c),
                                                    fontSize: 13.sp,
                                                    height: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              debugPrint('QQ空间 分享 点击事件');
                                            },
                                            behavior: HitTestBehavior.opaque,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/icon_qqkj.png',
                                                  width: 42.w,
                                                  height: 42.w,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(height: 8.5.h),
                                                Text(
                                                  'QQ空间',
                                                  style: TextStyle(
                                                    color: const Color(0xff3c3c3c),
                                                    fontSize: 13.sp,
                                                    height: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              debugPrint('QQ 分享 点击事件');
                                            },
                                            behavior: HitTestBehavior.opaque,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/icon_qq.png',
                                                  width: 42.w,
                                                  height: 42.w,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(height: 8.5.h),
                                                Text(
                                                  'QQ',
                                                  style: TextStyle(
                                                    color: const Color(0xff3c3c3c),
                                                    fontSize: 13.sp,
                                                    height: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 22.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              debugPrint('保存 按钮 点击事件');
                                            },
                                            behavior: HitTestBehavior.opaque,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/icon_preservation.png',
                                                  width: 42.w,
                                                  height: 42.w,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(height: 8.5.h),
                                                Text(
                                                  '保存',
                                                  style: TextStyle(
                                                    color: const Color(0xff3c3c3c),
                                                    fontSize: 13.sp,
                                                    height: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 52.h + ScreenUtil().bottomBarHeight),
                              ],
                            );
                          },
                        );
                      },
                    );
                    // video
                    Widget currentVideo = Center(
                      child: AspectRatio(
                        aspectRatio: player.controller.value.aspectRatio,
                        child: VideoPlayer(player.controller),
                      ),
                    );

                    currentVideo = TikTokVideoPage(
                      // 手势播放与自然播放都会产生暂停按钮状态变化，待处理
                      hidePauseIcon: !player.showPauseIcon.value,
                      aspectRatio: 9 / 16.0,
                      key: Key('${data.url}$i'),
                      tag: data.url,
                      bottomPadding: hasBottomPadding ? 16.0 : 16.0,
                      userInfoWidget: VideoUserInfo(
                        desc: data.desc,
                        bottomPadding: hasBottomPadding ? 16.0 : 50.0,
                      ),
                      onSingleTap: () async {
                        if (player.controller.value.isPlaying) {
                          await player.pause();
                        } else {
                          await player.play();
                        }
                        setState(() {});
                      },
                      onAddFavorite: () {
                        setState(() {
                          favoriteMap[i] = true;
                        });
                      },
                      rightButtonColumn: buttons,
                      video: currentVideo,
                    );
                    return currentVideo;
                  },
                ),
              ),
            ],
          ),
          currentPage ?? Container(),
        ],
      ),
    );
  }

}

