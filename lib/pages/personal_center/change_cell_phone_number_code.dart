import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class ChangeCellPhoneNumberCodePage extends StatefulWidget{
  const ChangeCellPhoneNumberCodePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChangeCellPhoneNumberCodePageState();
  }
}
class ChangeCellPhoneNumberCodePageState extends State<ChangeCellPhoneNumberCodePage>{

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
    return Scaffold(
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
        actions: [
          GestureDetector(
            onTap: () {
              debugPrint(' 完成   点击事件');
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
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
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
                  '请输入新的验证码',
                  style: TextStyle(
                    color: const Color(0xff151515),
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 14.h,),
                Text(
                  '换绑后，可使用当前密码登录',
                  style: TextStyle(
                    color: const Color(0xffa4a4a4),
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 30.h,),
                VerificationCode(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                  ),
                  keyboardType: TextInputType.number,
                  underlineColor: const Color(0xffdfc885), // 底部颜色  选中
                  underlineUnfocusedColor: const Color(0xffdfc885), // 底部颜色 未选中
                  length: 4,
                  cursorColor: const Color(0xffdfc885), // 光标颜色
                  margin: const EdgeInsets.all(12),
                  onCompleted: (String value) {
                    debugPrint('====------===---- onCompleted  value = $value');
                  },
                  onEditing: (bool value) {
                    debugPrint('-----------==========-----onEditing  value = $value');
                    // setState(() {
                    //   _onEditing = value;
                    // });
                    // if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}