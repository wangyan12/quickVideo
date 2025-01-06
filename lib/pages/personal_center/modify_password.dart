import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/net/repository_auth.dart';
import 'package:shipin/net/string.dart';
import 'package:shipin/storage.dart';
import 'package:shipin/styles.dart';


class ModifyPasswordPage extends StatefulWidget{
  const ModifyPasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ModifyPasswordPageState();
  }
}
class ModifyPasswordPageState extends State<ModifyPasswordPage>{
  TextEditingController oldPasswordEC = TextEditingController();
  FocusNode oldPasswordFocusNode = FocusNode();
  TextEditingController newPasswordEC = TextEditingController();
  FocusNode newPasswordFocusNode = FocusNode();
  TextEditingController confirmPasswordEC = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
  }

  exchangePassword() async{
    debugPrint('修改密码  完成   点击事件');
    if (oldPasswordEC.text.isEmpty) {
      EasyLoading.showToast('请输入旧密码');
      return ;
    }
    if (newPasswordEC.text.isEmpty) {
      EasyLoading.showToast('请输入新密码');
      return ;
    }
    if (confirmPasswordEC.text.isEmpty) {
      EasyLoading.showToast('请重新输入新密码');
      return ;
    }
    if (newPasswordEC.text != confirmPasswordEC.text) {
      EasyLoading.showToast('新密码与确认密码不相同');
      return ;
    }

    Map<String, dynamic> passMap = await mapString(
      data: {
        'pass': oldPasswordEC.text,
        'pass1': newPasswordEC.text,
        'pass2': confirmPasswordEC.text,
      },
    );
    RepositoryAuth.pass(data: passMap, context: context).then((value) {
      debugPrint('======-----======== pass value = $value');
      if (value['err'] == 0) {
        EasyLoading.showToast(value['msg']);
        StorageUtil().remove(StorageUtil.userAuth);
        Navigator.of(context)..pop()..pop(true);
      }
    }).catchError((error) {
      debugPrint('======-----======== pass error = $error');
    });
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
        backgroundColor: const Color(0xfff7f7f7),
        appBar: AppBar(
          backgroundColor: const Color(0xfff7f7f7),
          title: Text(
            '修改密码',
            style: TextStyle(
              color: PageStyle.c_333333,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          elevation: 0,
          centerTitle: true,
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
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h,),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '修改后下次直接使用新密码登录',
                  style: TextStyle(
                    color: const Color(0xff999999),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              SizedBox(height: 15.h,),
              Container(
                height: 49.h,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.w,
                      alignment: Alignment.center,
                      child: Text(
                        '原密码',
                        style: TextStyle(
                          color: const Color(0xff333333),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Expanded(
                      child: TextField(
                        controller: oldPasswordEC,
                        focusNode: oldPasswordFocusNode,
                        style: TextStyle(
                          color: const Color(0xff232323),
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: '填写原密码',
                          hintStyle: TextStyle(
                            color: const Color(0xff999999),
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
                    SizedBox(width: 10.w,),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Container(
                height: 49.h,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.w,
                      alignment: Alignment.center,
                      child: Text(
                        '新密码',
                        style: TextStyle(
                          color: const Color(0xff333333),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Expanded(
                      child: TextField(
                        controller: newPasswordEC,
                        focusNode: newPasswordFocusNode,
                        style: TextStyle(
                          color: const Color(0xff333333),
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: '填写新密码',
                          hintStyle: TextStyle(
                            color: const Color(0xff999999),
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
                    SizedBox(width: 10.w,),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Container(
                height: 49.h,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.w,
                      alignment: Alignment.center,
                      child: Text(
                        '确认密码',
                        style: TextStyle(
                          color: const Color(0xff333333),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Expanded(
                      child: TextField(
                        controller: confirmPasswordEC,
                        focusNode: confirmPasswordFocusNode,
                        style: TextStyle(
                          color: const Color(0xff333333),
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: '再次填写确认',
                          hintStyle: TextStyle(
                            color: const Color(0xff999999),
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
                    SizedBox(width: 10.w,),
                  ],
                ),
              ),
              SizedBox(height: 50.h,),
              GestureDetector(
                onTap: () {
                  // if (phoneBool) {
                  //   debugPrint('========== 点击事件 ==========');
                  // }
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  height: 49.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9B23EA),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '确定',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
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
}