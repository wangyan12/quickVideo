import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/styles.dart';

import 'change_cell_phone_number.dart';
import 'modify_nickname_page.dart';
import 'modify_password.dart';
import 'switch_account.dart';

class SecurityCenter extends StatefulWidget {
  // const SecurityCenter({Key? key, required this.accountInformation}) : super(key: key);
  // final Map<String, dynamic> accountInformation;

  const SecurityCenter({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SecurityCenterState();
  }
}
class SecurityCenterState extends State<SecurityCenter> {

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
      appBar: AppBar(
        backgroundColor: PageStyle.c_f7f7f7,
        title: Text(
          '安全中心',
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
      body: Container(
        color: PageStyle.c_f7f7f7,
        child: ListView(
          // padding: EdgeInsets.symmetric(vertical: 5.h),
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: PageStyle.c_EEEEEE, width: 1.w)),
              ),
              child: itemWidget(
                titleString: '手机号绑定',
                promptStr: '18877778888',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeCellPhoneNumberPage()));
                },
              ),
            ),
            itemWidget(
              titleString: '修改密码',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ModifyPasswordPage()));
              },
            ),
            // SizedBox(height: 5.h,),
            // itemWidget(
            //   titleString: '修改昵称',
            //   onTap: () {
            //     //  Navigator.push(context, MaterialPageRoute(builder: (context) => const ModifyPasswordPage()));
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => const ModifyNicknamePage()));
            //   },
            // ),
            SizedBox(height: 11.h,),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: PageStyle.c_EEEEEE, width: 1.w))
              ),
              child: itemWidget(
                titleString: '切换账号',
                // promptStr: widget.accountInformation['name'],
                promptStr: 'dd',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SwitchAccountPage(account: {},)));
                },
              ),
            ),
            itemWidget(
              titleString: '注销账号',
              onTap: () {

              },
            ),
          ],
        ),

      ),
    );
  }

  itemWidget({
    String? titleString,
    String? promptStr,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 49.h,
        color: Colors.white,
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleString!,
              style: TextStyle(
                color: const Color(0xff333333),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
            Row(
              children: [
                if (promptStr != null)...[
                  Text(
                    promptStr,
                    style: TextStyle(
                      color: const Color(0xff999999),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(width: 10.w,),
                ],
                Image.asset(
                  'assets/images/icon_more.png',
                  width: 6.w,
                  height: 10.w,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}