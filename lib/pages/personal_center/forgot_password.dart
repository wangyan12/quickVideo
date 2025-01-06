import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'change_password.dart';

class ForgotPasswordPage extends StatefulWidget{
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordPageState();
  }
}
class ForgotPasswordPageState extends State<ForgotPasswordPage>{
  TextEditingController phoneEC = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();

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
                    '请验证您的手机号',
                    style: TextStyle(
                      color: const Color(0xff151515),
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 14.h,),
                  Text(
                    '验证后，可修改密码',
                    style: TextStyle(
                      color: const Color(0xffa4a4a4),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h,),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 54.w,
                          alignment: Alignment.center,
                          child: Text(
                            '+86',
                            style: TextStyle(
                              color: const Color(0xff232323),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        Container(
                          width: 2.w,
                          height: 25.h,
                          color: const Color(0xffdfc885),
                        ),
                        SizedBox(width: 15.w,),
                        Expanded(
                          child: TextField(
                            controller: phoneEC,
                            focusNode: phoneFocusNode,
                            style: TextStyle(
                              color: const Color(0xff232323),
                              fontSize: 14.sp,
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
                        SizedBox(width: 15.w,),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h,),
                  GestureDetector(
                    onTap: () {
                      debugPrint('=====------ 获取验证码 点击事件');
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => const ChangePasswordPage()));
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      height: 53.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffd9d9d9),
                        borderRadius: BorderRadius.circular(4.w),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '获取验证码',
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
      ),
    );
  }

}