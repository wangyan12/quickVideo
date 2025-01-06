import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF7F7F7),
          titleTextStyle: TextStyle(
            fontSize: 16.sp,
            color: PageStyle.c_333333,
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
                width: 23.w,
                height: 23.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            "提现",
            style: TextStyle(fontSize: 16.sp, color: PageStyle.c_333333),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.w),
              ),
              padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "到账账户",
                    style: TextStyle(
                      color: PageStyle.c_333333,
                      fontSize: 14.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "请选择",
                        style: TextStyle(
                          color: PageStyle.c_999999,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Image.asset(
                        'assets/images/icon_more.png',
                        width: 16.w,
                        height: 16.w,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.w),
              ),
              padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "提现金额",
                    style: TextStyle(
                      color: PageStyle.c_333333,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 27.5.w,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/rmb.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                      SizedBox(width: 10.w,),
                      Expanded(
                        child: TextField(
                          cursorColor: PageStyle.c_9B23EA,
                          style: TextStyle(
                              color: PageStyle.c_333333, fontSize: 14.sp),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入提现金额",
                              hintStyle: TextStyle(
                                color: PageStyle.c_999999,
                                fontSize: 14.sp,
                              ),
                              isCollapsed: true),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "可提现金额 ¥ 666.66",
                        style: TextStyle(
                            color: PageStyle.c_999999, fontSize: 12.sp),
                      ),
                      Text(
                        "全部提现",
                        style: TextStyle(
                            color: PageStyle.c_9B23EA, fontSize: 12.sp),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.w,
            ),
            Container(
              decoration: BoxDecoration(
                color: PageStyle.c_9B23EA,
                borderRadius: BorderRadius.circular(17.w),
              ),
              width: 345.w,
              height: 34.w,
              child: Center(
                  child: Text(
                "确认提现",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              )),
            )
          ],
        ));
  }
}
