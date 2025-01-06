import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/net/repository_auth.dart';
import 'package:shipin/net/string.dart';

import '../../model/user_online_model.dart';
import '../../storage.dart';

class AddAccountPage extends StatefulWidget{
  const AddAccountPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddAccountPageState();
  }
}
class AddAccountPageState extends State<AddAccountPage>{
  TextEditingController accountEC = TextEditingController();
  FocusNode accountFocusNode = FocusNode();
  TextEditingController passwordEC = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/icon_return.png',
                color: Colors.black,
                width: 23.w,
                height: 23.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '请输入您的账号',
                    style: TextStyle(
                      color: const Color(0xff151515),
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 14.h,),
                  Text(
                    '手机号/用户名',
                    style: TextStyle(
                      color: const Color(0xffa4a4a4),
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 17.h,),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 53.h,
                    decoration: BoxDecoration(
                      color: const Color(0xfffafafa),
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: TextField(
                      controller: accountEC,
                      focusNode: accountFocusNode,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xff232323),
                        fontSize: 14.sp,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: '请输入账号',
                        hintStyle: TextStyle(
                          color: const Color(0xffc0bfbf),
                          fontSize: 14.sp,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h,),
                  Container(
                    height: 53.h,
                    decoration: BoxDecoration(
                      color: const Color(0xfffafafa),
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: TextField(
                      controller: passwordEC,
                      focusNode: passwordFocusNode,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xff232323),
                        fontSize: 14.sp,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: '请输入密码',
                        hintStyle: TextStyle(
                          color: const Color(0xffc0bfbf),
                          fontSize: 14.sp,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h,),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.5.h),
              child: GestureDetector(
                onTap: () async {
                  debugPrint('============立即登录 点击事件============');
                  if (accountEC.text.isEmpty) {
                    EasyLoading.showToast('请输入账号');
                    return;
                  }
                  if (passwordEC.text.isEmpty) {
                    EasyLoading.showToast('请输入密码');
                    return;
                  }
                  Map<String, dynamic> mapData = await mapString(
                    data: {
                      'username': accountEC.text,
                      'pass1': passwordEC.text,
                      'pass2': passwordEC.text,
                    },
                  );
                  String auth = '';
                  await RepositoryAuth.register(data: mapData, context: context, ua: await uaString()).then((value) {
                    debugPrint('=======-------======= ******  value = $value');
                    if (value['err'] == 0) {
                      // StorageUtil().setString(StorageUtil.userAuth, value['ext']['auth']);
                      auth = value['ext']['auth'];
                    } else {
                      EasyLoading.showToast('添加失败');
                    }
                  }).catchError((error) {
                    debugPrint('=======-------======= ******  error = $error');
                  });
                  UserOnlineModel? userOnlineModel;
                  await RepositoryAuth.othersOnline(data: await mapString(data: {}), context: context, auth: auth).then((value) {
                    debugPrint('++++++====---==-=--=-=-=  value = $value');
                    userOnlineModel = value;
                  }).catchError((error) {
                    debugPrint('++++++====---==-=--=-=-=  error = $error');
                  });

                  var accountMap = StorageUtil().getJSON(StorageUtil.accountList);
                  if (accountMap == null) {
                    Map<String, dynamic> accountInformation = userOnlineModel!.ext!.user!.toJson();
                    accountInformation['pass'] = passwordEC.text;
                    Map<String, dynamic> account = {
                      accountEC.text: accountInformation,
                    };
                    await StorageUtil().setJSON(StorageUtil.accountList, account);
                  } else {
                    Map<String, dynamic> accountInformation = userOnlineModel!.ext!.user!.toJson();
                    accountInformation['pass'] = passwordEC.text;
                    accountMap[accountEC.text] = accountInformation;
                    await StorageUtil().setJSON(StorageUtil.accountList, accountMap);
                  }
                  if (mounted) {
                    EasyLoading.showToast('添加成功');
                    Navigator.pop(context);
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  height: 53.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffdfc885),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '立即登录',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}