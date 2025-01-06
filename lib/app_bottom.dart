import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/pages/found_page.dart';

import 'bottombar.dart';
import 'pages/channel_page.dart';
import 'pages/foundpage.dart';
import 'pages/game_page.dart';
import 'pages/home_page.dart';
import 'pages/my_page.dart';
import 'styles.dart';

class FirstAppPage extends StatefulWidget {
  const FirstAppPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
class FirstAppPageState extends State<FirstAppPage> {
  int index = 0;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  void switchTab(int i) {
    setState(() {
      index = i;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: index,
              children: const [
                HomePage(),
                GamePage(),
                // FoundPageView(),
                FoundPage(),
                ChannelPage(),
                MyPage(),
              ],
            ),
          ),
          BottomBar(
            index: index,
            items: [
              BottomBarItem(
                selectedImgRes: 'assets/images/home_selected.png',
                unselectedImgRes: 'assets/images/home_default.png',
                selectedStyle: PageStyle.ts_666666_10sp,
                unselectedStyle: PageStyle.ts_666666_10sp,
                label: '首页',
                imgWidth: 25.w,
                imgHeight: 25.w,
                onClick: (i) => switchTab(i),
                count: 0,
              ),
              BottomBarItem(
                selectedImgRes: 'assets/images/video_selected.png',
                unselectedImgRes: 'assets/images/video_default.png',
                selectedStyle: PageStyle.ts_666666_10sp,
                unselectedStyle: PageStyle.ts_666666_10sp,
                label: '游戏',
                imgWidth: 25.w,
                imgHeight: 25.w,
                onClick: (i) => switchTab(i),
                // steam: logic.imLogic.unreadMsgCountCtrl.stream,
                count: 0,
              ),
              BottomBarItem(
                selectedImgRes: 'assets/images/live_selected.png',
                unselectedImgRes: 'assets/images/live_default.png',
                selectedStyle: PageStyle.ts_666666_10sp,
                unselectedStyle: PageStyle.ts_666666_10sp,
                label: '',
                imgWidth: 25.w,
                imgHeight: 25.w,
                onClick: (i) => switchTab(i),
                count: 0,
              ),
              BottomBarItem(
                selectedImgRes: 'assets/images/apply_selected.png',
                unselectedImgRes: 'assets/images/apply_default.png',
                selectedStyle: PageStyle.ts_666666_10sp,
                unselectedStyle: PageStyle.ts_666666_10sp,
                label: '活动',
                imgWidth: 25.w,
                imgHeight: 25.w,
                onClick: (i) => switchTab(i),
              ),
              BottomBarItem(
                selectedImgRes: 'assets/images/my_selected.png',
                unselectedImgRes: 'assets/images/my_default.png',
                selectedStyle: PageStyle.ts_666666_10sp,
                unselectedStyle: PageStyle.ts_666666_10sp,
                label: '我的',
                imgWidth: 25.w,
                imgHeight: 25.w,
                onClick: (i) => switchTab(i),
              ),
            ],
          ),
        ],
      ),
    );
  }
}