import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles.dart';
import 'change_cell_phone_number_code.dart';

class ChangeCellPhoneNumberPage extends StatefulWidget {
  const ChangeCellPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChangeCellPhoneNumberPageState();
  }
}
class ChangeCellPhoneNumberPageState extends State<ChangeCellPhoneNumberPage>{
  TextEditingController phoneEC = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  bool phoneBool = false;
  TextEditingController codeEC = TextEditingController();
  FocusNode codeFocusNode = FocusNode();
  bool sendCodeBool = false;
  int codeNum = 0;
  Timer? codeTimer;


  @override
  void initState() {
    super.initState();
  }

  // 获取验证码
  timerClick() {
    codeNum = 60;
    codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        codeNum = codeNum - 1;
      });
      if (codeNum == 0) {
        codeTimer!.cancel();
      }
    });
    // Map<String, dynamic> dataMap = {
    //   'mobile': phoneController.text.trim(),
    //   'prefix': areaCode.value,
    // };
    // RepositoryAuth.authRegCaptcha(data: dataMap).then((value) {
    //   Logger.print('authRegCaptcha   value = $value   ');
    //   if (value['errno'] == 0) {
    //     IMWidget.showToast('验证码发送成功');
    //   }
    // }).catchError((error) {
    //   Logger.print('authRegCaptcha   error = $error   ');
    // });
  }

  @override
  void dispose() {
    super.dispose();
    if (codeTimer != null) {
      codeTimer!.cancel();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: PageStyle.c_f7f7f7,
        title: Text(
          '更换手机号',
          style: TextStyle(
              color: PageStyle.c_333333,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500
          ),
        ),
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
              width: 11.w,
              height: 18.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '换绑后，可使用当前密码登录',
                  style: TextStyle(
                    color: const Color(0xff999999),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 15.h,),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 49.h,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Row(
                          children: [
                            Text(
                              '+86',
                              style: TextStyle(
                                color: const Color(0xff232323),
                                fontSize: 14.sp,
                              ),
                            ),
                            Image.asset(
                              'assets/images/login_arrow_bottom.png',
                              width: 12.w,
                              height: 12.w,
                              fit: BoxFit.cover,
                            ),
                          ],
                       ),
                      SizedBox(width: 15.w,),
                      Expanded(
                        child: TextField(
                          controller: phoneEC,
                          focusNode: phoneFocusNode,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (str) {
                            if (str.length == 11) {
                              if (!phoneBool) {
                                setState(() {
                                  phoneBool = true;
                                });
                              }
                            } else {
                              if (phoneBool) {
                                setState(() {
                                  phoneBool = false;
                                });
                              }
                            }
                          },
                          style: TextStyle(
                            color: const Color(0xff242424),
                            fontSize: 15.sp,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: '请输入手机号',
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
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  height: 49.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: codeEC,
                          focusNode: codeFocusNode,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                            color: const Color(0xff242424),
                            fontSize: 15.sp,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: '请输入验证码',
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
                      SizedBox(width: 15.w,),
                      GestureDetector(
                        onTap: (){
                          timerClick();
                        },
                        child: Container(
                          child: codeNum == 0
                              ? Text(
                                '获取验证码',
                                style: TextStyle(
                                  color: const Color(0xff9B23EA),
                                  fontSize: 14.sp,
                                 fontWeight: FontWeight.w500
                                ),)
                              : Text(
                                 '${codeNum}s重新获取',
                                 style: TextStyle(
                                    color: const Color(0xff999999),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                 ),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
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
        ],
      ),
    );
  }

}