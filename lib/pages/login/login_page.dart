import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.signUpClick}) : super(key: key);
  final void Function(String username, String pass)? signUpClick;

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}
class LoginPageState extends State<LoginPage> {
  TextEditingController phoneEC = TextEditingController();
  TextEditingController passwordEC = TextEditingController();
  bool hiddenBool = true;

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
        Navigator.pop(context);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 375.w,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                height: 351.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.w),
                    topRight: Radius.circular(15.w),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        children: [
                          SizedBox(height: 26.h,),
                          Text(
                            '登录获得更多精彩',
                            style: TextStyle(
                              color: const Color(0xff333333),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 49.h,),
                          Container(
                            height: 43.h,
                            decoration: BoxDecoration(
                              color: const Color(0xfff9f9f9),
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.5.sp),
                            child: TextField(
                              controller: phoneEC,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                              // keyboardType: TextInputType.phone,
                              onSubmitted: (str) {
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: '请输入您的账号',
                                hintStyle: TextStyle(
                                  color: const Color(0xffbab9b9),
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
                          SizedBox(height: 3.5.h,),
                          Container(
                            height: 43.h,
                            decoration: BoxDecoration(
                              color: const Color(0xfff9f9f9),
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.5.sp),
                            child: TextField(
                              controller: passwordEC,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                              onSubmitted: (str) {
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              obscureText: hiddenBool,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: '请输入您的密码',
                                hintStyle: TextStyle(
                                  color: const Color(0xffbab9b9),
                                  fontSize: 14.sp,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      hiddenBool = !hiddenBool;
                                    });
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    width: 43.w,
                                    height: 43.w,
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      hiddenBool ? 'assets/images/close_eye_image.png' : 'assets/images/eye_image.png',
                                      width: 20.w,
                                      height: 20.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                          Container(
                            height: 28.h,
                            alignment: Alignment.centerRight,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '已阅读并同意 ',
                                    style: TextStyle(
                                      color: const Color(0xff010101),
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '用户协议',
                                    style: TextStyle(
                                      color: const Color(0xffdfc885),
                                      fontSize: 10.sp,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        debugPrint(' ===----==== ---====  用户协议  点击事件');
                                      },
                                  ),
                                  TextSpan(
                                    text: ' 和 ',
                                    style: TextStyle(
                                      color: const Color(0xff010101),
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '隐私政策',
                                    style: TextStyle(
                                      color: const Color(0xffdfc885),
                                      fontSize: 10.sp,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        debugPrint(' ===----==== ---====  隐私政策  点击事件');
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          GestureDetector(
                            onTap: () {
                              debugPrint('！！！！登录/注册  点击事件！！！！');
                              // widget.signUpClick!(username: phoneEC.text, pass: passwordEC.text);
                              if (phoneEC.text.isEmpty) {
                                EasyLoading.showToast('请输入账号');
                                return;
                              }
                              if (passwordEC.text.isEmpty) {
                                EasyLoading.showToast('请输入密码');
                                return;
                              }
                              widget.signUpClick!.call(phoneEC.text, passwordEC.text);
                              Navigator.pop(context);
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              height: 43.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffdfc885),
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '登录/注册',
                                style: TextStyle(
                                  color: const Color(0xffF1F5F8),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          width: 51.5.w,
                          height: 51.5.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.w),
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/icon_close.png',
                            width: 15.5.w,
                            height: 15.5.w,
                            fit: BoxFit.fill,
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
      ),
    );
  }
}