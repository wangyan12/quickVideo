import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shipin/event_bus.dart';
import 'package:shipin/net/repository_auth.dart';
import 'package:shipin/net/string.dart';
import 'package:shipin/pages/login/login_page.dart';
import 'package:shipin/pages/personal_center/charge_vip.dart';
import 'package:shipin/pages/personal_center/wallet.dart';
import 'package:shipin/pages/personal_center/withdraw.dart';
// import 'package:shipin/pages/personal_center/wallet.dart';
import 'package:shipin/pages/web_view/web_view_page.dart';
import 'package:shipin/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../global.dart';
import '../model/user_online_model.dart';
import '../model/user_vip_model.dart';
import '../storage.dart';
import 'personal_center/my_download.dart';
import 'personal_center/security_center.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }
}
class MyPageState extends State<MyPage> {
  bool loginBool = true;  // 是否登录
  String? cacheSting;  // 缓存大小
  UserVipModel? userVipModel;
  List<UserVipExtListListModel>? vipItemList;
  UserOnlineModel? userOnlineModel;
  Map<String, dynamic> mapPay = {};
  var userAvatarUrl = '';

  @override
  void initState() {
    super.initState();
    // loginBool = StorageUtil().whetherToLogin();
    // if (StorageUtil().whetherToLogin()) {
    //   online(); // 获取当前用户信息
    //   request();
    // }
    // loadCache();
    // eventBus.on<SwitchAccount>().listen((event) {
    //   if (event.refresh) {
    //     request();
    //     online();
    //   }
    // });
    // eventBus.on<ModifyNicknameModel>().listen((event) {
    //   if (event.refresh) {
    //     online();
    //   }
    // });
  }
  request() async {
    // Map<String, dynamic> mapData = await mapString(data: {});
    // RepositoryAuth.userVip(data: mapData, context: context).then((value) {
    //   debugPrint('======------=======    value = $value');
    //   userVipModel = value;
    //   List<UserVipExtListModel> listModel = userVipModel!.ext!.list ?? [];
    //   if (listModel.isNotEmpty) {
    //     UserVipExtListModel userVipExtListModel = listModel[0];
    //     vipItemList = userVipExtListModel.list ?? [];
    //   }
    //   setState(() {});
    // }).catchError((error) {
    //   debugPrint('======------=======  ++++++  error = $error');
    // });
  }
  online({String? name, String? pass}) async {
    // Map<String, dynamic> mapData = await mapString(data: {});
    // await RepositoryAuth.online(data: mapData, context: context).then((value) {
    //   userOnlineModel = value;
    //   debugPrint('++++++====---==-=--=-=-=  value = $value');
    //   debugPrint('++++++====---==-=--=-=-=  userOnlineModel = ${userOnlineModel!.toJson()}');
    //   setState(() {});
    // }).catchError((error) {
    //   debugPrint('++++++====---==-=--=-=-=  error = $error');
    // });
    //
    // if (name != null) {
    //   StorageUtil().setJSON(StorageUtil.currentAccountInformation, userOnlineModel!.ext!.user!.toJson());
    //   var accountMap = StorageUtil().getJSON(StorageUtil.accountList);
    //   if (accountMap == null) {
    //     Map<String, dynamic> accountInformation = userOnlineModel!.ext!.user!.toJson();
    //     accountInformation['pass'] = pass;
    //     Map<String, dynamic> account = {
    //       name: accountInformation,
    //     };
    //     await StorageUtil().setJSON(StorageUtil.accountList, account);
    //   } else {
    //     Map<String, dynamic> accountInformation = userOnlineModel!.ext!.user!.toJson();
    //     accountInformation['pass'] = pass;
    //     accountMap[name] = accountInformation;
    //     await StorageUtil().setJSON(StorageUtil.accountList, accountMap);
    //   }
    // }
  }
  // 加载缓存
  Future<void> loadCache() async {
    try {
      double value = await _getTotalSizeOfFilesInDir(await getTemporaryDirectory());
      debugPrint('临时目录大小: ${value.toString()}');
      debugPrint('临时目录大小: ${_renderSize(value)}');
      cacheSting = _renderSize(value);
      setState(() {});
    } catch (err) {
      debugPrint(' err = $err');
    }
  }
  // 递归方式 计算文件的大小
  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        // if (children != null)
          for (final FileSystemEntity child in children) {
            total += await _getTotalSizeOfFilesInDir(child);
          }
        return total;
      }
      return 0;
    } catch (e) {
      debugPrint('$e');
      return 0;
    }
  }
  // 格式化文件大小
  _renderSize(double value) {
    if (value == null) {
      return 0;
    }
    List<String> unitArr = ['B', 'K', 'M', 'G'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }
  // 删除  清除缓存
  Future clearCache() async {
    try {
      double value = await _getTotalSizeOfFilesInDir(await getTemporaryDirectory());
      if (value <= 0) {
        debugPrint('暂无缓存');
        EasyLoading.showToast('暂无缓存');
        return ;
      } else {
        debugPrint('正在清理中...');
        EasyLoading.showToast('正在清理中...');
      }
      await delDir(await getTemporaryDirectory());
      await loadCache();
    } catch (e) {
      debugPrint('清除缓存失败  $e');
      EasyLoading.showToast('清除缓存失败');
    }
  }
  // 递归方式删除目录
  Future<void> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
      debugPrint('清理完成');
      EasyLoading.showToast('清理完成');
    } catch(e) {
      debugPrint('+++++--- e = $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F5F8),
      body: ListView(
        padding: EdgeInsets.only(top: 0, bottom: 15.h,),
        children: [

          gradientBackGround(),


          SizedBox(height: 10.h),
          myServiceWidget(),
          // SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget gradientBackGround(){
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            colors: [Color(0xFFF0D8FF), Color(0xFFF7F7F7)]
        ),
      ),
      child: Column(
        children: [
          appBarWidget(),
          SizedBox(height: 10.h),
          myOrderWidget(),
        ],
      ),
    );
  }


  // vip item
  vipItemWidget() {
    if (vipItemList != null && vipItemList!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  debugPrint('-------======------- 111 连续');
                  // request();
                  // Map<String, dynamic> payResult = await mapString(data: {
                  //   'orderid': mapPay['orderid'],
                  // });
                  // RepositoryAuth.userVipQuery(data: payResult, context: context, ua: await uaString()).then((value) {
                  //   debugPrint('+++++++++********----------++++++userVipQuery00  value = $value');
                  // }).catchError((error) {
                  //   debugPrint('+++++++++********----------++++++userVipQuery00  error = $error');
                  // });
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: 102.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 37.h, bottom: 8.h),
                        child: Text(
                          '${vipItemList![0].name}',
                          style: TextStyle(
                            color: const Color(0xff242424),
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '¥',
                              style: TextStyle(
                                color: const Color(0xff242424),
                                fontSize: 11.sp,
                              ),
                            ),
                            TextSpan(
                              text: '${vipItemList![0].money}',
                              style: TextStyle(
                                color: const Color(0xff242424),
                                fontSize: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h, bottom: 5.5.h),
                        child: GestureDetector(
                          onTap: () async {
                            debugPrint('+++++++++++1 立即体验');
                            Map<String, dynamic> mapData = await mapString(data: {
                              'type': vipItemList![0].type,
                              'payment': 'alipay',
                            });
                            await RepositoryAuth.userVipOrder(data: mapData, context: context, ua: await uaString()).then((value) async {
                              debugPrint('++++------******++++++ userVipOrder  value = $value');
                              if (value['err'] == 0) {
                                mapPay = value['ext'];

                                Navigator.push(context, MaterialPageRoute(builder: (ctx) => WebViewPage(urlStr: mapPay['url']))).then((value) async {
                                  Map<String, dynamic> payResult = await mapString(data: {
                                    'orderid': mapPay['orderid'],
                                  });
                                  RepositoryAuth.userVipQuery(data: payResult, context: context, ua: await uaString()).then((value) {
                                    debugPrint('+++++++++********----------++++++userVipQuery00  value = $value');
                                  }).catchError((error) {
                                    debugPrint('+++++++++********----------++++++userVipQuery00  error = $error');
                                  });
                                });

                                // String url = mapPay['url'];
                                // if (await canLaunchUrl(Uri.parse(url))) {
                                //   debugPrint('======------========---------  00000000');
                                //   launchUrl(Uri.parse(url));
                                // } else {
                                //   debugPrint('======------========---------  11111111');
                                //   EasyLoading.showToast('url 不正确');
                                // }


                              } else {
                                EasyLoading.showToast('支付信息获取失败');
                              }
                            }).catchError((error) {
                              debugPrint('++++------******++++++ userVipOrder  error = $error');
                            });

                            // Future.delayed(const Duration(seconds: 20), () async {
                            //   Map<String, dynamic> payResult = await mapString(data: {
                            //     'orderid': mapPay['orderid'],
                            //   });
                            //   RepositoryAuth.userVipQuery(data: payResult, context: context, ua: await uaString()).then((value) {
                            //     debugPrint('+++++++++********----------++++++userVipQuery00  value = $value');
                            //   }).catchError((error) {
                            //     debugPrint('+++++++++********----------++++++userVipQuery00  error = $error');
                            //   });
                            // });
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            width: 75.5.w,
                            height: 23.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffCEAB7C),
                              borderRadius: BorderRadius.circular(11.5.w),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '立即体验',
                              style: TextStyle(
                                color: const Color(0xff735834),
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint('-------======------- 22222 连续');
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: 102.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 56.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffCEAB7C),
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              vipItemList![1].badge ?? '推荐选择',
                              style: TextStyle(
                                color: const Color(0xff735834),
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
                        child: Text(
                          '${vipItemList![1].name}',
                          style: TextStyle(
                            color: const Color(0xff242424),
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '¥',
                              style: TextStyle(
                                color: const Color(0xff242424),
                                fontSize: 11.sp,
                              ),
                            ),
                            TextSpan(
                              text: '${vipItemList![1].money}',
                              style: TextStyle(
                                color: const Color(0xff242424),
                                fontSize: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h, bottom: 5.5.h),
                        child: GestureDetector(
                          onTap: () async {
                            debugPrint('+++-----+++++++ 22222');
                            Map<String, dynamic> mapData = await mapString(data: {
                              'type': vipItemList![1].type,
                              'payment': 'alipay',
                            });
                            await RepositoryAuth.userVipOrder(data: mapData, context: context, ua: await uaString()).then((value) {
                              debugPrint('++++------******++++++ userVipOrder  value = $value');
                              if (value['err'] == 0) {
                                mapPay = value['ext'];
                                Navigator.push(context, MaterialPageRoute(builder: (ctx) => WebViewPage(urlStr: mapPay['url']))).then((value) async {
                                  Map<String, dynamic> payResult = await mapString(data: {
                                    'orderid': mapPay['orderid'],
                                  });
                                  RepositoryAuth.userVipQuery(data: payResult, context: context, ua: await uaString()).then((value) {
                                    debugPrint('+++++++++********----------++++++userVipQuery00  value = $value');
                                  }).catchError((error) {
                                    debugPrint('+++++++++********----------++++++userVipQuery00  error = $error');
                                  });
                                });
                              } else {
                                EasyLoading.showToast('支付信息获取失败');
                              }
                            }).catchError((error) {
                              debugPrint('++++------******++++++ userVipOrder  error = $error');
                            });
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            width: 75.5.w,
                            height: 23.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffCEAB7C),
                              borderRadius: BorderRadius.circular(11.5.w),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '立即体验',
                              style: TextStyle(
                                color: const Color(0xff735834),
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint('-------======------- 333333 连续');
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: 102.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 37.h, bottom: 8.h),
                        child: Text(
                          '${vipItemList![2].name}',
                          style: TextStyle(
                            color: const Color(0xff242424),
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '¥',
                              style: TextStyle(
                                color: const Color(0xff242424),
                                fontSize: 11.sp,
                              ),
                            ),
                            TextSpan(
                              text: '${vipItemList![2].money}',
                              style: TextStyle(
                                color: const Color(0xff242424),
                                fontSize: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h, bottom: 5.5.h),
                        child: GestureDetector(
                          onTap: () async {
                            debugPrint('+++*****---*-*-**--  3333333');
                            Map<String, dynamic> mapData = await mapString(data: {
                              'type': vipItemList![2].type,
                              'payment': 'alipay',
                            });
                            await RepositoryAuth.userVipOrder(data: mapData, context: context, ua: await uaString()).then((value) {
                              debugPrint('++++------******++++++ userVipOrder  value = $value');
                              if (value['err'] == 0) {
                                mapPay = value['ext'];
                                Navigator.push(context, MaterialPageRoute(builder: (ctx) => WebViewPage(urlStr: mapPay['url']))).then((value) async {
                                  Map<String, dynamic> payResult = await mapString(data: {
                                    'orderid': mapPay['orderid'],
                                  });
                                  RepositoryAuth.userVipQuery(data: payResult, context: context, ua: await uaString()).then((value) {
                                    debugPrint('+++++++++********----------++++++userVipQuery00  value = $value');
                                  }).catchError((error) {
                                    debugPrint('+++++++++********----------++++++userVipQuery00  error = $error');
                                  });
                                });
                              } else {
                                EasyLoading.showToast('支付信息获取失败');
                              }
                            }).catchError((error) {
                              debugPrint('++++------******++++++ userVipOrder  error = $error');
                            });
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            width: 75.5.w,
                            height: 23.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffCEAB7C),
                              borderRadius: BorderRadius.circular(11.5.w),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '立即体验',
                              style: TextStyle(
                                color: const Color(0xff735834),
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
        ],
      );
    } else {
      return Container();
    }
  }



  loginClick({void Function(String username, String pass)? loginClick}) {
    return showBottomSheet(
      backgroundColor: PageStyle.c_000000_opacity15p,
      context: context,
      enableDrag: false,
      builder: (ctx) {
        return LoginPage(
          signUpClick: (name, pass) {
            debugPrint('+++++++++++ ++++++++++ $name, $pass');
            loginClick!.call(name, pass);
          },
        );
      },
    );
  }

  // 判断时间 是否过去
  String timeClick({String? expireTime}) {
    String oldTime = expireTime!.padRight(13, '0');
    int oldInt = int.parse(oldTime);
    int newInt = DateTime.now().millisecondsSinceEpoch;
    if (oldInt > newInt) {
      DateTime timeDate = DateTime.fromMillisecondsSinceEpoch(oldInt);
      return "到期时间：\n${timeDate.year.toString().padLeft(4, '0')}-${timeDate.month.toString().padLeft(2, '0')}-${timeDate.day.toString().padLeft(2, '0')}";
    } else {
      return '已过期';
    }
  }



  // 导航
  appBarWidget() {
    return Container(
      // height: ScreenUtil().statusBarHeight + 150.h,
      width: 375.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight + 20.h),
          loginBool ?
          SizedBox(
            width: 335.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      userAvatarUrl.isNotEmpty ? ClipRRect(
                        borderRadius: BorderRadius.circular(27.5.w),
                        child: Image.network(
                          userAvatarUrl,
                          width: 55.w,
                          height: 55.w,
                          fit: BoxFit.cover,
                        ),
                      ) :Image.asset(
                        'assets/images/icon_head.png',
                        width: 60.w,
                        height: 60.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '喜羊羊',
                                  style: TextStyle(
                                    color: PageStyle.c_333333,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/my_icon_edit.png',
                                        width: 16.w,
                                        height: 16.w,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        '编辑资料',
                                        style: TextStyle(
                                          color: PageStyle.c_333333,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.w),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '会员ID：8459521',
                                    style: TextStyle(
                                      color: PageStyle.c_333333,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                Container(
                                  width: 60.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.w),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/icon_member_vip.png',
                                        width: 14.w,
                                        height: 14.w,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        'VIP·壹',
                                        style: TextStyle(
                                          color: PageStyle.c_333333,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
              : GestureDetector(
            onTap: () {

            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 164.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: const Color(0x19ffffff),
                borderRadius: BorderRadius.circular(10.w),
              ),
              alignment: Alignment.center,
              child: Text(
                '立即登录',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 11.h,),
          Container(
            height: 49.h,
            width: 355.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/member_bg.png'),
                fit: BoxFit.fill,// 完全填充
              ),
              // color: Colors.lightGreen,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_member_vip.png',
                      width: 22.w,
                      height: 22.w,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      '会员充值',
                      style: TextStyle(
                        color: const Color(0xFFF1C995),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    showVIPSheet();
                  },
                  child: Container(
                    width: 120.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.h),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 1.0],
                          colors: [Color.fromRGBO(206, 171, 124, 1), Color.fromRGBO(255, 255, 255, 1)]
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '立即开通',
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  // 我的分区
  myOrderWidget() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      // width: 345.w,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
      ),
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const WalletPage()));
                },
                behavior: HitTestBehavior.opaque,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/my_icon_1.png',
                          width: 36.w,
                          height: 36.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '钱包',
                          style: TextStyle(
                            color: const Color(0xff333333),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    // if ((logic.userIndexOrderModel.value.uncomment ?? 0) > 0)
                    //   Positioned(
                    //     top: 0,
                    //     right: 0,
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(20),
                    //         color: const Color(0xffaa1f29),
                    //       ),
                    //       alignment: Alignment.center,
                    //       width: 13.w,
                    //       height: 13.w,
                    //       child: Text(
                    //         '${logic.userIndexOrderModel.value.uncomment ?? 0}',
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 8.sp,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                behavior: HitTestBehavior.opaque,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/my_icon_2.png',
                          width: 36.w,
                          height: 36.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '提现',
                          style: TextStyle(
                              color: const Color(0xff333333),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                behavior: HitTestBehavior.opaque,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/my_icon_3.png',
                          width: 36.w,
                          height: 36.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '活动',
                          style: TextStyle(
                              color: const Color(0xff333333),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                behavior: HitTestBehavior.opaque,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/my_icon_4.png',
                          width: 36.w,
                          height: 36.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '推广',
                          style: TextStyle(
                              color: const Color(0xff333333),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
    );
  }
  // 我的服务
  myServiceWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
      // padding: EdgeInsets.symmetric(horizontal: 15.w),
      width: 345.w,
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10))),
      child: Column(
        children: [
          itemWidget(
            imgName: 'assets/images/my_icon_5.png',
            titleString: '收支明细',
            onTap: () {

            },
          ),
          itemWidget(
            imgName: 'assets/images/my_icon_6.png',
            titleString: '安全中心',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SecurityCenter()));
              // if (StorageUtil().whetherToLogin()) {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => SecurityCenter(accountInformation: userOnlineModel!.ext!.user!.toJson(),))).then((value) {
              //     debugPrint('+++++++-----*****+++++   value = $value');
              //     if (value != null && value) {
              //       setState(() {
              //         loginBool = StorageUtil().whetherToLogin();
              //       });
              //     }
              //   });
              // } else {
              //   EasyLoading.showToast('请登录账号');
              // }
            },
          ),
          itemWidget(
            imgName: 'assets/images/my_icon_7.png',
            titleString: '正在下载',
            onTap: () {
              if (StorageUtil().whetherToLogin()) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyDownloadPage()));
              } else {
                EasyLoading.showToast('请登录账号');
              }
            },
          ),
          itemWidget(
            imgName: 'assets/images/my_icon_8.png',
            titleString: '清除缓存',
            numString: '$cacheSting',
            arrowBool: false,
            onTap: () {
              clearCache();
            },
          ),
          itemWidget(
            imgName: 'assets/images/my_icon_9.png',
            titleString: '专属客服',
            onTap: () {

            },
          ),
          itemWidget(
            imgName: 'assets/images/my_icon_10.png',
            titleString: '版本更新',
            onTap: () {

            },
          ),
          itemWidget(
            imgName: 'assets/images/my_icon_11.png',
            titleString: '退出登录',
            onTap: () {
              StorageUtil().remove(StorageUtil.userAuth);
              StorageUtil().remove(StorageUtil.currentAccountInformation);
              userOnlineModel = null;
              setState(() {
                loginBool = false;
              });
            },
          ),
        ],
      ),
    );
  }
  //服务Item
  itemWidget({
    String? imgName,
    String? titleString,
    String? numString,
    bool arrowBool = true,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.only(left:  12.w, right: arrowBool ? 8.5.w : 12.5.w),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(4.w),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  imgName!,
                  width: 22.w,
                  height: 22.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10.w),
                Text(
                  titleString!,
                  style: TextStyle(
                      color: PageStyle.c_333333,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            if (arrowBool)
              Image.asset(
                'assets/images/icon_rightArrow.png',
                width: 16.w,
                height: 16.w,
                fit: BoxFit.fill,
              ),
            if (!arrowBool)
              Text(
                numString!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 9.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }

  showVIPSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (bottomCtx) {
          return const ChargeVip();
        });
  }

}