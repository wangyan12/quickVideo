
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh_strong/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shipin/event_bus.dart';
import 'package:shipin/model/list_model.dart';
import 'package:shipin/net/repository_auth.dart';
import 'package:shipin/net/string.dart';
import 'package:shipin/styles.dart';

import '../model/cate_model.dart';
import '../model/commend_model.dart';
import '../widgets/refresh.dart';
import 'channel/channel_more_page.dart';
import 'video_playback/video_playback_page.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChannelPageState();
  }
}
class ChannelPageState extends State<ChannelPage> with SingleTickerProviderStateMixin {
  // List<Penfriend> _friendList = [];
  List _gameList = [{},{},{}];
  List _liveList = [{},{},{},{},{},{}];
  int chooseIndex = 0;  // 选中类型  0.游戏   1.直播
  ScrollController gameController = ScrollController();
  ScrollController liveController = ScrollController();
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      chooseIndex = tabController!.index;
      setState(() { });
    });

    // request();
    // cateListRequest(cateExtModel: CateExtModel(name: '推荐', cid: '', type: '', isVert: null, isHide: null), page: 1);
    // eventBus.on<SwitchAccount>().listen((event) {
    //   if (event.refresh) {
    //     cateListRequest(page: 1, cateExtModel: cateList[chooseIndex]);
    //   }
    // });
  }
  @override
  void dispose() {
    super.dispose();
    // _easyRefreshController?.dispose();
    tabController!.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            width: 1.sw,
            height: 1.sh,
            color: const Color(0xFFF7F7F7),
            child: Column(
              children: [
                SizedBox(
                  width: 375.w,
                  // height: 235.h,
                  child: appBarWidget(),
                ),
                DefaultTabController(
                    length: 2,
                    child:Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            gamePage(),
                            livePage()
                          ],
                        ))
                ),
              ],
            ),
          ),
    );
  }
  // 导航
  appBarWidget() {
    return Container(
      width: 375.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            colors: [Color.fromRGBO(206, 171, 124, 1), Color.fromRGBO(255, 255, 255, 1)]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          SizedBox(
            width: 200.w,
            height: 40.h,
            child: TabBar(
              controller: tabController,
              labelColor: const Color(0xffffffff), //设置选中时的字体颜色
              labelStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ), //设置选中时的字体样式
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: const Color(0xffffffff),  // 下划线颜色
              indicatorWeight: 2.h,  // 选中下划线的高度
              unselectedLabelColor: const Color(0xff333333), //设置未选中时的字体颜色
              unselectedLabelStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ), //设置未选中时的字体样式
              onTap: (int index) {
                chooseIndex = index;
              },
              tabs: const [
                Tab(text: '游戏活动',),
                Tab(text: '直播活动',),
              ],
            ),
          ),
          // SizedBox(height: 100.h,)
        ],
      ),
    );
  }

  gamePage() {
    return  ListView.builder(
      padding: EdgeInsets.only(bottom: 10.h),
      controller: gameController,
      itemCount:  _gameList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
          return _buildFriendItem();
      },
    );
  }

  livePage() {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 10.h),
      controller: liveController,
      itemCount: _liveList.isNotEmpty ? _liveList.length + 1 : 1,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildFriendItem();
      },
    );
  }

  Widget _buildFriendItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
      child: Image.asset(
        'assets/images/game_pic.png',
        width: 345.w,
        height: 195.h,
        fit: BoxFit.cover,
      ),
    );
  }

  // 没有内容 展示页面
  Widget _buildEmptyHolder() => SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 155.h),
        Image.asset(
          'assets/images/holder_empty_letter.png',
          width: 44.w,
          height: 44.w,
          fit: BoxFit.fill,
        ),
        SizedBox(height: 16.h),
        Text(
          '暂无内容',
          style: TextStyle(
            color: const Color(0xffb2b2b2),
            fontSize: 14.sp,
          ),
        ),
      ],
    ),
  );

}

