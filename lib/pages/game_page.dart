import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shipin/event_bus.dart';
import 'package:shipin/net/repository_auth.dart';
import 'package:shipin/net/string.dart';
import 'package:shipin/pages/personal_center/coupon_list.dart';
import 'package:shipin/pages/personal_center/wallet.dart';
import 'package:shipin/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/list_app_model.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GamePageState();
  }
}
class GamePageState extends State<GamePage> {
  ScrollController sController = ScrollController();
  ListAppModel? listAppModel;
  List<ListAppExtAppListModel>? appList;

  //当前选中
  int _selectIndex=0;
  //左侧列表数据
  List leftCateList = [{'img': '','title': '热门'},{'img': '','title': '手游'},{'img': '','title': '卡牌'},{'img': '','title': '战略'}];
  //右侧列表数据
  List rightCateList = [{'img': '','title': '王者荣耀'},{'img': '','title': '和平精英'},{'img': '','title': '和平精英'},{'img': '','title': '和平精英'},{'img': '','title': '和平精英'}];

  @override
  void initState() {
    super.initState();
    request();
    eventBus.on<SwitchAccount>().listen((event) {
      if (event.refresh) {
        request();
      }
    });

    _getLeftCateData();
  }
  Future<void> request() async {
    await RepositoryAuth.listApp(data: await mapString(data: {}), context: context).then((value) {
      debugPrint('+++++++******------listApp   value = $value');
      listAppModel = value;
      appList = listAppModel?.ext?.appList ?? [];
      setState(() {});
    }).catchError((error) {
      debugPrint('+++++++******------listApp   error = $error');
    });
  }

  //左侧分类的数据
  _getLeftCateData() {
    // var api = '${Config.domain}api/pcate';
    // var result = await Dio().get(api);
    // var leftCateList = new CateModel.fromJson(result.data);
    // setState(() {
    //   this.leftCateList = leftCateList.result;
    // });
    // _getRightCateData(leftCateList.result[0].sId);
  }

  //右侧分类数据
  _getRightCateData(pid) {

    // setState(() {
    //   this.rightCateList = rightCateList.result;
    // });
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        child:Column(
          children: [
            appBarWidget(),
            SizedBox(height: 10.h),
            appTipWidget(),
            SizedBox(height: 10.h),
            accountWidget(),
            gameWidget(),
          ],
        ),
      ),
/*
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (ctx, index) {
          return Container(
            height: 1.h,
            color: Colors.white,
            child: Divider(
              height: 1,
              indent: 48.w,
              endIndent: 6.w,
              color: const Color(0xff000000).withOpacity(0.1),
            ),
          );
        },
        itemBuilder: (ctx, index) {
          return gameItemWidget(index: index);
        },
      ),
*/
    );
  }

  // 导航
  appBarWidget() {
    return Container(
      width: 375.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          colors: [
            Color(0xfff0d8ff),
            Color(0xfff7f7f7),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15.h + ScreenUtil().statusBarHeight),
          SizedBox(
            width: 345.w,
            height: 195.h,
            child: Swiper(
              loop: true,
              autoplay: true,
              itemCount: 4,
              itemBuilder: (ctx, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(5.w),
                  child: Image.asset(
                    'assets/images/game_pic.png',
                    width: 345.w,
                    height: 195.h,
                    fit: BoxFit.cover,
                  ),
                );
              },
              pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.white,
                  color: Color(0x7fffffff),
                  size: 6.0,
                  activeSize: 6.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // 提醒
  appTipWidget() {
    return Container(
      height: 34.h,
      width: 345.w,
      padding: EdgeInsets.symmetric(horizontal: 13.5.w),
      decoration: ShapeDecoration(
        color: PageStyle.c_333333,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(6.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icon_tip.png',
            width: 22.w,
            height: 22.w,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              '王者荣耀新英雄上线。',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 游戏账户信息
  accountWidget() {
    return Container(
      width: 345.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(6.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.w),
                      child: Image.asset(
                        'assets/images/g1.png',
                        width: 32.w,
                        height: 32.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      '喜洋洋',
                      style: TextStyle(
                        color: PageStyle.c_333333,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    SizedBox(width: 20.w,),
                    Text(
                      '￥ 321.00',
                      style: TextStyle(
                        color: PageStyle.c_333333,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 186.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                countItemWidget(1,'存款',() {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const WalletPage()));
                }),
                countItemWidget(2,'提现',() {}),
                countItemWidget(3,'优惠',() {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const CouponList()));
                }),
                countItemWidget(4,'记录',() {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  countItemWidget(int index, String title, Function()? onTap ) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/game_icon_$index.png',
            width: 32.w,
            height: 32.w,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 9.5.h),
          Text(
            title,
            style: TextStyle(
              color: PageStyle.c_333333,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  gameWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      height: 325.h,
      child: Row(
        children: [
          _leftCateWidget(),
          SizedBox(width: 10.w,),
          _rightCateWidget()
        ],
      ),
    );
  }
  //左侧列表布局
  Widget _leftCateWidget(){
    if(leftCateList.isNotEmpty){
      return Container(
        width: 120.w,
        // color: Colors.white,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(6.w),
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 0.h),
          itemCount: leftCateList.length,
          itemBuilder: (context,index){
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    setState(() {
                      //刷新右侧列表的数据
                      _selectIndex= index;
                      _getRightCateData(leftCateList[index].sId);
                    });
                  },
                  child: Container(
                    // width: 90.w,
                    // height: 70.h,
                    padding: EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 0),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                          'assets/images/game_left_icon.png',
                          // width: 89.w,
                          // height: 60.h,
                          fit: BoxFit.fitWidth,
                        ),
                        Container(
                          height: 30.h,
                          // width: 60.w,
                          padding: EdgeInsets.all(5.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.0, 1.0],
                              colors: [
                                Color(0xFFceab7c),
                                Color(0x00ffffff),
                              ],
                            ),
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.w)),
                          ),
                          child: Text('热门',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },

        ),
      );
    } else {
      return Container(
          width: 120.w,
          height: double.infinity,
      );
    }
  }

  //创建右侧列表
  Widget _rightCateWidget(){
    if(rightCateList.isNotEmpty){
      return Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.all(10.w),
            height: double.infinity,
            // color: Colors.white,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(6.w),
              ),
            ),
            child: GridView.builder(
              padding: EdgeInsets.only(top: 0.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:3,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h
              ),
              itemCount: rightCateList.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){},
                  child: Container(
                // padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                          AspectRatio(
                            aspectRatio: 1/1,
                            child: Image.asset(
                                'assets/images/game_right_item_icon.png',
                                fit: BoxFit.cover
                            ),
                           ),
                           SizedBox(height: 5.h,),
                           Text(
                             '王者荣耀',
                             style: TextStyle(
                                color: PageStyle.c_333333,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                             ),
                             overflow: TextOverflow.ellipsis,
                             maxLines: 1,
                          )
                        ],
                    ),
                   ),
                  );
                },
            )
        ),
      );
    } else {
      return Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromRGBO(240, 246, 246, 0.9),
            child: Text("加载中..."),
          )
      );
    }
  }

  // 游戏item
  gameItemWidget({required int index}) {
    return Container(
      height: 150.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.5),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.w),
            child: Image.asset(
              'assets/images/reserve_drive_ok.png',
              width: 135.h,
              height: 135.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15.w,),
          Expanded(
            child: SizedBox(
              height: 135.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h,),
                      Text(
                        '王者荣耀',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      Text(
                        '《王者荣耀》是腾讯天美工作室推出的英雄竞技手游,不是一个人的王者,而是团队的荣耀!5v5王者峡谷PVP对战,领略英雄竞技的酣畅淋漓!',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          debugPrint('=======----=======    立即下载 $index 点击事件    =======----=======');
                        },
                        child: Container(
                          width: 72.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.w),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xffF4D8AB),
                                Color(0xffE8B764),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '立即下载',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
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
    );
  }

}