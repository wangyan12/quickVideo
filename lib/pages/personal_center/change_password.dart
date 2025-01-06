import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordPage extends StatefulWidget{
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChangePasswordPageState();
  }
}
class ChangePasswordPageState extends State<ChangePasswordPage>{
  TextEditingController newPasswordEC = TextEditingController();
  FocusNode newPasswordFocusNode = FocusNode();
  TextEditingController confirmPasswordEC = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode();

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
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '更换密码',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.sp,
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
          actions: [
            GestureDetector(
              onTap: () {
                debugPrint('更换密码  完成   点击事件');
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: 62.w,
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  '完成',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xfff1f5f8),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 31.h,
                alignment: Alignment.centerLeft,
                child: Text(
                  '更换后，可使用当前手机号登录',
                  style: TextStyle(
                    color: const Color(0xffa4a4a4),
                    fontSize: 11.sp,
                  ),
                ),
              ),
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
                      width: 63.w,
                      alignment: Alignment.center,
                      child: Text(
                        '新密码',
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
                    SizedBox(width: 10.w,),
                    Expanded(
                      child: TextField(
                        controller: newPasswordEC,
                        focusNode: newPasswordFocusNode,
                        style: TextStyle(
                          color: const Color(0xff232323),
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: '请输入账号新密码',
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
                    SizedBox(width: 10.w,),
                  ],
                ),
              ),
              SizedBox(height: 6.h,),
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
                      width: 63.w,
                      alignment: Alignment.center,
                      child: Text(
                        '确认密码',
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
                    SizedBox(width: 10.w,),
                    Expanded(
                      child: TextField(
                        controller: confirmPasswordEC,
                        focusNode: confirmPasswordFocusNode,
                        style: TextStyle(
                          color: const Color(0xff232323),
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: '请确认账号新密码',
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
                    SizedBox(width: 10.w,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}