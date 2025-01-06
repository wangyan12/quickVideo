import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh_strong/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/net/repository_auth.dart';
import 'package:shipin/net/string.dart';
import 'package:shipin/storage.dart';
import 'package:video_player/video_player.dart';

import '../../model/commend_model.dart';
import '../../model/comment_model.dart';
import '../../model/detail_model.dart';
import '../../model/guess_model.dart';
import '../../widgets/refresh.dart';

class VideoPlaybackPage extends StatefulWidget{
  const VideoPlaybackPage({Key? key, required this.commendExtTypeListModel}) : super(key: key);
  final CommendExtTypeListModel commendExtTypeListModel;

  @override
  State<StatefulWidget> createState() {
    return VideoPlaybackPageState();
  }
}
class VideoPlaybackPageState extends State<VideoPlaybackPage> with WidgetsBindingObserver {
  bool commentsBool = false;
  bool keyboardBool = false;
  TextEditingController commentsEC = TextEditingController();
  FocusNode commentsFocusNode = FocusNode();
  bool likeBool = false;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  // GuessModel? guessModel;
  List<GuessExtVodListModel>? vodList;
  int guessIndex = 1;  // 猜你喜欢
  EasyRefreshController? guessEasyRefreshController; // 猜你喜欢下拉刷新控制器
  DetailModel? detailModel;   // 视频详情
  // CommentModel? commentModel; // 评论model列表
  List<CommentExtListModel>? commentList; // 评论列表
  bool isKeyboard = false;
  int commentsIndex = 1; // 评论列表
  EasyRefreshController? commentsEasyRefreshController; // 评论下拉刷新控制器
  int favExist = 0;  // 0. 未收藏   1. 已收藏
  bool boolVip = false;   //  是否是会员
  int chooseIndex = 0;  // 选择事件

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    commentsEasyRefreshController = EasyRefreshController();
    guessEasyRefreshController = EasyRefreshController();
    Map<String, dynamic> userInformation = StorageUtil().getJSON(StorageUtil.currentAccountInformation) ?? {};
    boolVip = userInformation['vip'] == '1' ? true : false;
    request();
  }
  request() async {
    // 获取视频信息
    Map<String, dynamic> mapData = await mapString(data: {});
    await RepositoryAuth.detail(
      type: widget.commendExtTypeListModel.type,
      param: widget.commendExtTypeListModel.param,
      data: mapData,
      context: context,
    ).then((value) {
      debugPrint('=============== -------------detail  value = $value');
      detailModel = value;
    }).catchError((error) {
      debugPrint('=============== -------------detail  error = $error');
    });

    if (detailModel != null) {
      String videoStr = detailModel!.ext!.playUrls![detailModel!.ext!.playDef!].url!;
      List<DetailExtPlayUrlsModel> playUrls = detailModel?.ext?.playUrls ?? [];
      chooseIndex = detailModel!.ext!.playDef!;
      playerInitialization(videoUrl: videoStr, playUrls: playUrls, position: Duration.zero);
      /*
      videoPlayerController = VideoPlayerController.network(
        videoStr,
      );
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 375.w / 209.h,
        autoPlay: true,
        looping: true,
        // // 右上角 更多按钮
        // additionalOptions: (ctx) {
        //   return playUrls.map((e) {
        //     return OptionItem(
        //       onTap: () {
        //         debugPrint(' =====  ${e.title},  ${e.url}');
        //       },
        //       iconData: Icons.video_camera_back_outlined,
        //       title: e.title!,
        //     );
        //   }).toList();
        // },
        // 右上角 更多按钮  自定义样式
        optionsBuilder: (ctx, list) async {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.w),
                topRight: Radius.circular(10.w),
              ),
            ),
            builder: (crx) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: playUrls.asMap().map((indexNum, model) {
                      return MapEntry(
                        indexNum,
                        GestureDetector(
                          onTap: () {
                            debugPrint(' =====  ${model.title},  ${model.url}');
                            videoPlayerController = VideoPlayerController.network(
                              model.url!,
                            );
                            chewieController = ChewieController(
                              videoPlayerController: videoPlayerController,
                              aspectRatio: 375.w / 209.h,
                              autoPlay: true,
                              looping: true,
                            );
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            height: 45.h,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffa0a0a0),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              model.title!,
                              style: TextStyle(
                                color: indexNum == chooseIndex ? Colors.red : const Color(0xff222222),
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).values.toList(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      height: 45.h,
                      alignment: Alignment.center,
                      child: Text(
                        '取消',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        // optionsTranslation: OptionsTranslation(
        //   playbackSpeedButtonText: '播放速度',
        //   // subtitlesButtonText: 'Untertitel',
        //   cancelButtonText: '取消',
        // ),
      );
      */
      setState(() {});
    }
    // 获取 猜你喜欢
    Map<String, dynamic> guessMap = await mapString(data: {'type': widget.commendExtTypeListModel.type, 'page': '1'});
    RepositoryAuth.guess(data: guessMap, context: context).then((value) {
      debugPrint('++++++----******++++ guess value = $value');
      GuessModel guessModel = value;
      vodList = guessModel.ext?.vodList ?? [];
      setState(() {});
    }).catchError((error) {
      debugPrint('++++++----******++++ guess error = $error');
    });
    // 获取评论列表
    RepositoryAuth.comment(
      type: widget.commendExtTypeListModel.type,
      param: widget.commendExtTypeListModel.param,
      data: await mapString(data: {}), context: context,
      page: 1,
    ).then((value) {
      debugPrint('========---------===========comment   value = $value');
      CommentModel commentModel = value;
      debugPrint('========---------===========comment   commentModel = ${commentModel.toJson()}');
      commentList = commentModel.ext?.list ?? [];
      setState(() {});
    }).catchError((error) {
      debugPrint('========---------===========comment   error = $error');
    });
    // 判断是否收藏
    RepositoryAuth.favExist(
      data: await mapString(data: {
        'type': widget.commendExtTypeListModel.type,
        'id': widget.commendExtTypeListModel.param,
      }),
      context: context,
    ).then((value) {
      debugPrint('++++++++=====------ favExist   value = $value');
      if (value['msg'] == 1) {
        favExist = 1;
        setState(() {});
      }
    }).catchError((error) {
      debugPrint('++++++++=====------ favExist   error = $error');
    });
  }
  Future<void> commentRequest(int? page) async {
    commentsIndex = page!;
    // 获取评论列表
    RepositoryAuth.comment(
      type: widget.commendExtTypeListModel.type,
      param: widget.commendExtTypeListModel.param,
      data: await mapString(data: {}), context: context,
      page: page,
    ).then((value) {
      debugPrint('========---------===========comment   value = $value');
      CommentModel commentModel = value;
      debugPrint('========---------===========comment   commentModel = ${commentModel.toJson()}');
      if (page == 1) {
        commentList = commentModel.ext?.list ?? [];
      } else {
        commentList!.addAll(commentModel.ext?.list ?? []);
      }
      commentsEasyRefreshController!.finishLoad(success: true, noMore: commentModel.ext!.pageCount! == page);
      setState(() {});
    }).catchError((error) {
      commentsEasyRefreshController!.finishLoad(success: true, noMore: false);
      debugPrint('========---------===========comment   error = $error');
    });
  }
  Future<void> guessRequest(int? page) async {
    guessIndex = page!;
    Map<String, dynamic> guessMap = await mapString(data: {'type': widget.commendExtTypeListModel.type, 'page': page});
    RepositoryAuth.guess(data: guessMap, context: context).then((value) {
      debugPrint('========---------===========guess   value = $value');
      GuessModel guessModel = value;
      debugPrint('========---------===========guess  guessModel.ext!.pageCount! = ${guessModel.ext!.pageCount!},   commentModel = ${guessModel.toJson()}');
      if (page == 1) {
        vodList = guessModel.ext?.vodList ?? [];
      } else {
        vodList!.addAll(guessModel.ext?.vodList ?? []);
      }
      guessEasyRefreshController!.finishLoad(success: true, noMore: guessModel.ext!.pageCount! == page);
      setState(() {});
    }).catchError((error) {
      guessEasyRefreshController!.finishLoad(success: true, noMore: false);
      debugPrint('========---------===========guess   error = $error');
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          //关闭键盘
          // debugPrint('=======-------111111  关闭键盘');
          isKeyboard = false;
        } else {
          //显示键盘
          // debugPrint('=======-------111111  显示键盘');
          isKeyboard = true;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
    commentsEasyRefreshController!.dispose();
    guessEasyRefreshController!.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  playerInitialization({required String videoUrl, required List<DetailExtPlayUrlsModel> playUrls, required Duration position}) async {
    videoPlayerController = VideoPlayerController.network(
      videoUrl,
    );
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 375.w / 209.h,
      autoPlay: true,
      looping: true,
      startAt: position,
      // // 右上角 更多按钮
      // additionalOptions: (ctx) {
      //   return playUrls.map((e) {
      //     return OptionItem(
      //       onTap: () {
      //         debugPrint(' =====  ${e.title},  ${e.url}');
      //       },
      //       iconData: Icons.video_camera_back_outlined,
      //       title: e.title!,
      //     );
      //   }).toList();
      // },
      // 右上角 更多按钮  自定义样式
      optionsBuilder: (BuildContext ctx, List<OptionItem> optionsItemList) async {
        showModalBottomSheet(
          context: context,
          builder: (ctx) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: playUrls.asMap().map((indexNum, model) {
                    return MapEntry(
                      indexNum,
                      GestureDetector(
                        onTap: () {
                          String titleStr = detailModel!.ext!.playUrls![detailModel!.ext!.playDef!].title!;
                          titleStr = titleStr.toLowerCase();
                          if (titleStr.contains('vip') && !boolVip) {
                            EasyLoading.showToast('请先成为vip在观看');
                            Navigator.pop(context);
                            return ;
                          }
                          chooseIndex = indexNum;
                          playerInitialization(videoUrl: model.url!, playUrls: playUrls, position: chewieController.videoPlayerController.value.position);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          height: 45.h,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffa0a0a0),
                                width: 0.5,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            model.title!,
                            style: TextStyle(
                              color: indexNum == chooseIndex ? Colors.red : const Color(0xff222222),
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).values.toList(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    height: 45.h,
                    alignment: Alignment.center,
                    child: Text(
                      '取消',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      // optionsTranslation: OptionsTranslation(
      //   playbackSpeedButtonText: '播放速度',
      //   // subtitlesButtonText: 'Untertitel',
      //   cancelButtonText: '取消',
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('s========da=====ada=======');
        FocusScope.of(context).requestFocus(FocusNode());
        if (!isKeyboard) {
          keyboardBool = false;
          commentsBool = false;
        }
        setState(() {});
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              SizedBox(
                width: 375.w,
                height: 667.h,
                child: Column(
                  children: [
                    // 视频
                    videoWidget(),
                    // 猜你喜欢
                    if (!commentsBool)...[
                      // 视频名字
                      Container(
                        height: 82.h,
                        width: 375.w,
                        padding: EdgeInsets.only(
                          left: 11.w,
                          top: 20.h,
                          right: 11.w,
                          bottom: 15.h,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    detailModel?.ext?.title ?? widget.commendExtTypeListModel.title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '播放次数：${detailModel?.ext?.clicks ?? 0}',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            GestureDetector(
                              onTap: () async {
                                debugPrint('============---------=========== 收藏按钮  点击事件');
                                if (!StorageUtil().whetherToLogin()) {
                                  EasyLoading.showToast('请先登陆');
                                  return ;
                                }
                                if (favExist == 0) {
                                  RepositoryAuth.favAdd(
                                    data: await mapString(data: {
                                      'type': widget.commendExtTypeListModel.type,
                                      'id': widget.commendExtTypeListModel.param,
                                    }),
                                    context: context,
                                  ).then((value) {
                                    debugPrint('++++++++=====------ favAdd   value = $value');
                                    if (value['err'] == 0) {
                                      favExist = 1;
                                      EasyLoading.showToast(value['msg'].toString());
                                      setState(() {});
                                    }
                                  }).catchError((error) {
                                    debugPrint('++++++++=====------ favAdd   error = $error');
                                  });
                                } else {
                                  RepositoryAuth.favDo(
                                    data: await mapString(data: {
                                      'type': widget.commendExtTypeListModel.type,
                                      'id': widget.commendExtTypeListModel.param,
                                    }),
                                    context: context,
                                  ).then((value) {
                                    debugPrint('++++++++=====------ favDo   value = $value');
                                    if (value['err'] == 0) {
                                      favExist = 0;
                                      EasyLoading.showToast(value['msg'].toString());
                                      setState(() {});
                                    }
                                  }).catchError((error) {
                                    debugPrint('++++++++=====------ favDo   error = $error');
                                  });
                                }
                                // else {
                                //   RepositoryAuth.favDel(
                                //     data: await mapString(data: {
                                //       'type': widget.commendExtTypeListModel.type,
                                //       'id': widget.commendExtTypeListModel.param,
                                //     }),
                                //     context: context,
                                //   ).then((value) {
                                //     debugPrint('++++++++=====------ favAdd   value = $value');
                                //     if (value['err'] == 0) {
                                //       favExist = 0;
                                //       EasyLoading.showToast(value['msg'].toString());
                                //       setState(() {});
                                //     }
                                //   }).catchError((error) {
                                //     debugPrint('++++++++=====------ favAdd   error = $error');
                                //   });
                                // }
                              },
                              behavior: HitTestBehavior.translucent,
                              child: SizedBox(
                                width: 33.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_collection.png',
                                      width: 22.w,
                                      height: 22.w,
                                      color: favExist == 0 ? const Color(0xff222222) : Colors.red,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      '收藏',
                                      style: TextStyle(
                                        color: favExist == 0 ? const Color(0xff222222) : Colors.red,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                debugPrint('============---------=========== 转发按钮  点击事件');
                                if (StorageUtil().whetherToLogin()) {
                                  RepositoryAuth.share(
                                    data: await mapString(data: {}),
                                    context: context,
                                  ).then((value) {
                                    debugPrint('++++++++=====------ share   value = $value');
                                  }).catchError((error) {
                                    debugPrint('++++++++=====------ share   error = $error');
                                  });
                                  // RepositoryAuth.shareSucc(
                                  //   data: await mapString(data: {}),
                                  //   context: context,
                                  // ).then((value) {
                                  //   debugPrint('++++++++=====------ shareSucc   value = $value');
                                  // }).catchError((error) {
                                  //   debugPrint('++++++++=====------ shareSucc   error = $error');
                                  // });
                                  /*
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      //这里是modal的边框样式
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7.5.w),
                                        topRight: Radius.circular(7.5.w),
                                      ),
                                    ),
                                    builder: (ctx) {
                                      return SizedBox(
                                        height: 215.h,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 12.w,
                                                top: 17.h,
                                                bottom: 18.h,
                                              ),
                                              child: Text(
                                                '分享至',
                                                style: TextStyle(
                                                  color: const Color(0xff3d3d3d),
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          debugPrint('---------0000000 微信按钮 点击事件');
                                                        },
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/icon_wx.png',
                                                              width: 42.w,
                                                              height: 42.w,
                                                            ),
                                                            SizedBox(height: 3.h,),
                                                            Text(
                                                              '微信',
                                                              style: TextStyle(
                                                                color: const Color(0xff3c3c3c),
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          debugPrint('---------0000000 朋友圈按钮 点击事件');
                                                        },
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/icon_pyq.png',
                                                              width: 42.w,
                                                              height: 42.w,
                                                            ),
                                                            SizedBox(height: 3.h,),
                                                            Text(
                                                              '朋友圈',
                                                              style: TextStyle(
                                                                color: const Color(0xff3c3c3c),
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          debugPrint('---------0000000 QQ空间按钮 点击事件');
                                                        },
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/icon_qqkj.png',
                                                              width: 42.w,
                                                              height: 42.w,
                                                            ),
                                                            SizedBox(height: 3.h,),
                                                            Text(
                                                              'QQ空间',
                                                              style: TextStyle(
                                                                color: const Color(0xff3c3c3c),
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          debugPrint('---------0000000 QQ按钮 点击事件');
                                                        },
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/icon_qq.png',
                                                              width: 42.w,
                                                              height: 42.w,
                                                            ),
                                                            SizedBox(height: 3.h,),
                                                            Text(
                                                              'QQ',
                                                              style: TextStyle(
                                                                color: const Color(0xff3c3c3c),
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20.h,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          debugPrint('---------0000000 保存按钮 点击事件');
                                                        },
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/icon_preservation.png',
                                                              width: 42.w,
                                                              height: 42.w,
                                                            ),
                                                            SizedBox(height: 3.h,),
                                                            Text(
                                                              '保存',
                                                              style: TextStyle(
                                                                color: const Color(0xff3c3c3c),
                                                                fontSize: 13.sp,
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
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  */
                                } else {
                                  EasyLoading.showToast('请先登录账号');
                                }
                                // RepositoryAuth.favExist(
                                //   data: await mapString(data: {
                                //     'type': widget.commendExtTypeListModel.type,
                                //     'id': widget.commendExtTypeListModel.param,
                                //   }),
                                //   context: context,
                                // ).then((value) {
                                //   debugPrint('++++++++=====------ favAdd   value = $value');
                                //   // if (value['err'] == 0) {
                                //   //   favExist = 1;
                                //   //   EasyLoading.showToast(value['msg'].toString());
                                //   //   setState(() {});
                                //   // }
                                // }).catchError((error) {
                                //   debugPrint('++++++++=====------ favAdd   error = $error');
                                // });
                              },
                              behavior: HitTestBehavior.translucent,
                              child: SizedBox(
                                width: 33.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/share_image.png',
                                      width: 22.w,
                                      height: 22.w,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      '转发',
                                      style: TextStyle(
                                        color: const Color(0xff232323),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0.5.h,
                        indent: 7.w,
                        endIndent: 7.w,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20.h,
                          left: 12.w,
                          bottom: 15.h,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '猜你喜欢',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: myRefresh(
                          key: const ValueKey('guessEasyRefreshController'),
                          controller: guessEasyRefreshController,
                          refreshFn: () => guessRequest(1),
                          loadFn: () => guessRequest(++guessIndex),
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (ctx, index) {
                              return itemWidget(index: index);
                            },
                            separatorBuilder: (ctx, index) {
                              return SizedBox(height: 15.h);
                            },
                            itemCount: vodList?.length ?? 0,
                          ),
                        ),
                      ),
                    ],
                    // 评论列表
                    if (commentsBool)...[
                      Container(
                        height: 42.5.h,
                        alignment: Alignment.center,
                        child: Text(
                          '${commentList?.length ?? 0}条评论',
                          style: TextStyle(
                            color: const Color(0xff2c2c2c),
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Expanded(
                        child: myRefresh(
                          key: const ValueKey('commentsEasyRefreshController'),
                          controller: commentsEasyRefreshController,
                          refreshFn: () => commentRequest(1),
                          loadFn: () => commentRequest(++commentsIndex),
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            itemBuilder: (ctx, index) {
                              return commentsListItem(index: index);
                            },
                            separatorBuilder: (ctx, index) {
                              return SizedBox(height: 30.h,);
                            },
                            itemCount: commentList?.length ?? 0,
                          ),
                        ),
                      ),
                    ],
                    !keyboardBool ? Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                              color: const Color(0xffdedede),
                              width: 0.5.h
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(left: 12.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (StorageUtil().whetherToLogin()) {
                                setState((){
                                  keyboardBool = true;
                                  commentsBool = true;
                                });
                              } else {
                                EasyLoading.showToast('请先登录账号');
                              }
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              width: 166.5.w,
                              height: 37.h,
                              decoration: BoxDecoration(
                                color: const Color(0xfff0f0f0),
                                borderRadius: BorderRadius.circular(18.5.h),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10.w,),
                                  Image.asset(
                                    'assets/images/icon_edit.png',
                                    width: 17.w,
                                    height: 17.w,
                                  ),
                                  SizedBox(width: 13.5.w,),
                                  Text(
                                    '我来说一说...',
                                    style: TextStyle(
                                      color: const Color(0xff858585),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                debugPrint('----====评论按钮 ==== 点击事件====----');
                                setState(() {
                                  commentsBool = !commentsBool;
                                });
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/icon_comment.png',
                                    width: 22.w,
                                    height: 22.w,
                                    color: commentsBool ? Colors.red : Colors.black,
                                  ),
                                  SizedBox(height: 4.h,),
                                  Text(
                                    '${detailModel?.ext?.comments ?? 0}',
                                    style: TextStyle(
                                      color: const Color(0xffb9b9b9),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                debugPrint('----====点赞按钮 ==== 点击事件====----');
                                if (StorageUtil().whetherToLogin()) {
                                  setState(() {
                                    likeBool = !likeBool;
                                  });
                                } else {
                                  EasyLoading.showToast('请先登录账号');
                                }
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/icon_collection.png',
                                    width: 22.w,
                                    height: 22.w,
                                    color: likeBool ? Colors.red : const Color(0xff232323),
                                  ),
                                  SizedBox(height: 4.h,),
                                  Text(
                                    '${detailModel?.ext?.ups ?? 0}',
                                    style: TextStyle(
                                      color: likeBool ? Colors.red : const Color(0xffb9b9b9),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                debugPrint('----====分享按钮 ==== 点击事件====----');
                                if (StorageUtil().whetherToLogin()) {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      //这里是modal的边框样式
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7.5.w),
                                        topRight: Radius.circular(7.5.w),
                                      ),
                                    ),
                                    builder: (ctx) {
                                      return SizedBox(
                                        height: 215.h,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 12.w,
                                                top: 17.h,
                                                bottom: 18.h,
                                              ),
                                              child: Text(
                                                '分享至',
                                                style: TextStyle(
                                                  color: const Color(0xff3d3d3d),
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          debugPrint('---------0000000 微信按钮 点击事件');
                                                        },
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/icon_wx.png',
                                                              width: 42.w,
                                                              height: 42.w,
                                                            ),
                                                            SizedBox(height: 3.h,),
                                                            Text(
                                                              '微信',
                                                              style: TextStyle(
                                                                color: const Color(0xff3c3c3c),
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          debugPrint('---------0000000 朋友圈按钮 点击事件');
                                                        },
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/icon_pyq.png',
                                                              width: 42.w,
                                                              height: 42.w,
                                                            ),
                                                            SizedBox(height: 3.h,),
                                                            Text(
                                                              '朋友圈',
                                                              style: TextStyle(
                                                                color: const Color(0xff3c3c3c),
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          debugPrint('---------0000000 QQ空间按钮 点击事件');
                                                        },
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/icon_qqkj.png',
                                                              width: 42.w,
                                                              height: 42.w,
                                                            ),
                                                            SizedBox(height: 3.h,),
                                                            Text(
                                                              'QQ空间',
                                                              style: TextStyle(
                                                                color: const Color(0xff3c3c3c),
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          debugPrint('---------0000000 QQ按钮 点击事件');
                                                        },
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/icon_qq.png',
                                                              width: 42.w,
                                                              height: 42.w,
                                                            ),
                                                            SizedBox(height: 3.h,),
                                                            Text(
                                                              'QQ',
                                                              style: TextStyle(
                                                                color: const Color(0xff3c3c3c),
                                                                fontSize: 13.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20.h,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          debugPrint('---------0000000 保存按钮 点击事件');
                                                        },
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/icon_preservation.png',
                                                              width: 42.w,
                                                              height: 42.w,
                                                            ),
                                                            SizedBox(height: 3.h,),
                                                            Text(
                                                              '保存',
                                                              style: TextStyle(
                                                                color: const Color(0xff3c3c3c),
                                                                fontSize: 13.sp,
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
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  EasyLoading.showToast('请先登录账号');
                                }
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/icon_forward.png',
                                    width: 22.w,
                                    height: 22.w,
                                  ),
                                  SizedBox(height: 4.h,),
                                  Text(
                                    '${detailModel?.ext?.shares ?? 0}',
                                    style: TextStyle(
                                      color: const Color(0xffb9b9b9),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) : Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                              color: const Color(0xffdedede),
                              width: 0.5.h
                          ),
                        ),
                      ),
                      // padding: EdgeInsets.only(left: 12.w),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      constraints: BoxConstraints(
                        minHeight: 50.h,
                      ),
                      child: TextField(
                        controller: commentsEC,
                        focusNode: commentsFocusNode,
                        style: TextStyle(
                          color: const Color(0xff232323),
                          fontSize: 12.sp,
                        ),
                        maxLines: 4,
                        minLines: 1,
                        autofocus: true,
                        onEditingComplete: () async {
                          debugPrint(' ======-----=======   点击事件 ============= ${commentsEC.text}');
                          // commentList!.insert(
                          //   0,
                          //   CommentExtListModel(
                          //     id: 'szy',
                          //     avatar: 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2537878359.jpg',
                          //     content: commentsEC.text,
                          //     ups: 888,
                          //     time: 1669791646,
                          //   ),
                          // );
                          // commentsEC.text = '';
                          if (commentsEC.text.isNotEmpty) {
                            RepositoryAuth.userCommentAdd(
                              data: await mapString(data: {}),
                              context: context,
                              content: commentsEC.text,
                              id: widget.commendExtTypeListModel.param,
                            ).then((value) {
                              debugPrint('====--=-=-=-=- userCommentAdd  value = $value');
                              if (value['err'] == 0) {
                                EasyLoading.showToast('评论成功，等待审核！');
                              }
                              commentsEC.text = '';
                              setState(() {});
                            }).catchError((error) {
                              debugPrint('====--=-=-=-=- userCommentAdd  error = $error');
                            });
                          } else {
                            EasyLoading.showToast('请输入评论内容');
                          }
                        },
                        textInputAction: TextInputAction.send,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: const Color(0xfff0f0f0),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 13.5.w),
                          hintText: '我来说一说...',
                          hintStyle: TextStyle(
                            color: const Color(0xff858585),
                            fontSize: 12.sp,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.5.h),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.5.h),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 0.w,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/icon_return.png',
                      width: 18.w,
                      height: 18.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // 视频（小）
  videoWidget() {
    if (detailModel != null) {
      // String titleStr = detailModel!.ext!.playUrls![detailModel!.ext!.playDef!].title!;
      // debugPrint('++++++++--------**********  boolVip = $boolVip, titleStr = $titleStr');
      // titleStr = titleStr.toLowerCase();
      // if (!(titleStr.contains('vip') || titleStr.contains('VIP')) && boolVip) {
      //   return SizedBox(
      //     width: 375.w,
      //     height: 209.h,
      //     child: Chewie(
      //       controller: chewieController,
      //     ),
      //   );
      // } else {
      //   return SizedBox(
      //     width: 375.w,
      //     height: 209.h,
      //     child: const Text(
      //       '需要vip',
      //       style: TextStyle(
      //         color: Colors.amber,
      //         fontSize: 15,
      //       ),
      //     ),
      //   );
      // }
      return SizedBox(
        width: 375.w,
        height: 209.h,
        child: Chewie(
          controller: chewieController,
        ),
      );
    } else {
      return SizedBox(
        width: 375.w,
        height: 209.h,
        child: Image.network(
          widget.commendExtTypeListModel.cover!,
          fit: BoxFit.cover,
        ),
      );
    }
    return Stack(
      children: [
        SizedBox(
          width: 375.w,
          height: 209.h,
          child: Image.asset(
            'assets/images/reserve_drive_ok.png',
            width: 375.w,
            height: 209.h,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 15.w,
          right: 15.w,
          bottom: 12.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  debugPrint('视频开始（暂停）播放  点击事件');
                },
                behavior: HitTestBehavior.translucent,
                child: Image.asset(
                  'assets/images/icon_play.png',
                  width: 16.w,
                  height: 16.w,
                ),
              ),
              SizedBox(
                width: 27.w,
                child: Center(
                  child: Text(
                    '8:23',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.sp,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 0.5.h,
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100.w,
                          height: 0.5.h,
                          color: const Color(0xffc8a06a),
                        ),
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffd7a568),
                            borderRadius: BorderRadius.circular(3.w),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 27.w,
                child: Center(
                  child: Text(
                    '14：31',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.sp,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint('视频全屏 ===---=== 点击事件');
                },
                behavior: HitTestBehavior.translucent,
                child: Image.asset(
                  'assets/images/icon_amplification.png',
                  width: 16.w,
                  height: 16.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  // 猜你喜欢 item
  itemWidget({int? index,}) {
    GuessExtVodListModel vodModel = vodList![index!];
    return GestureDetector(
      onTap: () {
        // debugPrint('+++++ vodModel = ${vodModel.toJson()}');
        Navigator.of(context)..pop()..push(
          MaterialPageRoute(builder: (ctx) => VideoPlaybackPage(
            commendExtTypeListModel: CommendExtTypeListModel.fromJson(vodModel.toJson()),
          )),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.w),
              child: Image.network(
                vodModel.cover ?? '',
                width: 167.w,
                height: 95.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              child: SizedBox(
                height: 85.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      vodModel.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      // '2018-12-20',
                      getMessageTime(vodModel.time!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 11.sp,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icon_heat.png',
                          width: 20.w,
                          height: 20.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 6.w,),
                        Text(
                          '热度 ${vodModel.hot ?? 0}',
                          style: TextStyle(
                            color: const Color(0xffC8A06A),
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // 得到留言时间
  String getMessageTime(int downList) {
    String time = '';
    int timestamp = int.parse(downList.toString().padRight(13, '0'));
    DateTime timeDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    time = "${timeDate.year.toString().padLeft(4, '0')}-${timeDate.month.toString().padLeft(2, '0')}-${timeDate.day.toString().padLeft(2, '0')} ${timeDate.hour.toString().padLeft(2, '0')}:${timeDate.minute.toString().padLeft(2, '0')}:${timeDate.second.toString().padLeft(2, '0')}";
    return time;
  }
  // 评论列表 item
  commentsListItem({int? index}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.network(
            'http://csjk.top${commentList?[index!].avatar ?? ''}',
            width: 32.w,
            height: 32.w,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    commentList?[index!].id ?? '',
                    style: TextStyle(
                      color: const Color(0xffdddddd),
                      fontSize: 13.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // commentsList[index][1] = !commentsList[index][1];
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          commentList?[index!].ups?.toString() ?? '',
                          style: TextStyle(
                            // color: commentsList[index][1] ? Colors.red : const Color(0xffddddda),
                            color: const Color(0xffddddda),
                            fontSize: 10.sp,
                          ),
                        ),
                        SizedBox(width: 3.w,),
                        Image.asset(
                          'assets/images/icon_fabulous.png',
                          width: 16.w,
                          height: 16.w,
                          // color: commentsList[index][1] ? Colors.red : const Color(0xff999999),
                          color: const Color(0xff999999),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h,),
              Text(
                // '35星要能打成这样，小学生都能上荣耀, 35星要能打成这样，小学生都能上荣耀35星要能打成这样，小学生都能上荣耀',
                commentList?[index!].content ?? '',
                style: TextStyle(
                  color: const Color(0xff323232),
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 11.h,),
              Text(
                getMessageTime(commentList?[index!].time ?? 0),
                style: TextStyle(
                  color: const Color(0xffddddda),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


}