import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../styles.dart';
import '../../widgets/flutterToast.dart';
import 'charge_vip.dart';


class CouponList extends StatefulWidget {
  const CouponList({super.key});

  @override
  State<CouponList> createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {

  //模拟数据
  List <couponModel> couponsList =[];
  // List couponList = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 5; i++) {
      couponModel model = couponModel();
      model.couponName = "连续包年50元优惠券";
      model.couponPrice = (50+i).toString();
      if (i == 0) {
        model.canUse = false;
        model.disable = false;
      } else if ( i == 1 || i == 2){
        model.canUse = true;
        model.disable = false;
      } else {
        model.canUse = false;
        model.disable = true;
      }

      couponsList.add(model);
    }

  }
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
        title: const Text("优惠券"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: ListView.separated(
          itemBuilder: (ctx, index) {
            return couponWidget(numInt: index);
          },
          separatorBuilder: (ctx, index) {
            return SizedBox(height: 10.h);
          },
          itemCount: couponsList.length,
        ),
      ),
    );
  }

  // 优惠券item
  couponWidget({required int numInt}) {
    return Container(
      // width: 345.w,
      // height: 170.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(6.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Container(
           margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Expanded(
                   child: Row(
                     children: [
                       Container(
                         padding: EdgeInsets.all(15.w),
                         decoration: BoxDecoration(
                           border: Border(right: BorderSide(color: PageStyle.c_EEEEEE, width: 1.w)),
                         ),
                         child: RichText(
                           text: TextSpan(
                             children: [
                               TextSpan(
                                 text: '¥',
                                 style: TextStyle(
                                   color: couponsList[numInt].disable ?PageStyle.c_999999 :PageStyle.c_9B23EA,
                                   fontSize: 16.sp,
                                   fontWeight: FontWeight.w500,
                                 ),
                               ),
                               TextSpan(
                                 text: couponsList[numInt].couponPrice,
                                 style: TextStyle(
                                   color: couponsList[numInt].disable ?PageStyle.c_999999 :PageStyle.c_9B23EA,
                                   fontSize: 32.sp,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                       SizedBox(width: 20.w,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             couponsList[numInt].couponName,
                             style: TextStyle(
                               color: couponsList[numInt].disable ?PageStyle.c_999999 :PageStyle.c_9B23EA,
                               fontSize: 16.sp,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           SizedBox(height: 5.h,),
                           Text(
                             '2023.11.20失效',
                             style: TextStyle(
                               color: PageStyle.c_999999,
                               fontSize: 12.sp,
                               fontWeight: FontWeight.w400,
                             ),
                           ),
                           SizedBox(height: 5.h,),
                           Text(
                             '满￥128使用',
                             style: TextStyle(
                               color: PageStyle.c_999999,
                               fontSize: 12.sp,
                               fontWeight: FontWeight.w400,
                             ),
                           )
                         ],
                       )
                     ],
                   )
               ),
               if(!couponsList[numInt].disable)
               GestureDetector(
                 onTap: (){
                   if(couponsList[numInt].canUse){
                     showVIPSheet();
                   }else{
                     showToast('领取成功！');
                     couponsList[numInt].canUse = true;
                     setState(() {
                     });
                   }
                 },
                 child: Container(
                   width: 56.w,
                   height: 26.h,
                   alignment: Alignment.center,
                   decoration: ShapeDecoration(
                     color: const Color(0xff9B23EA),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadiusDirectional.circular(10.w),
                     ),
                   ),
                   child: Text(
                     couponsList[numInt].canUse ?'使用' :'领取',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 14.sp,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ),
               )
             ],
           ),
         ),
         Container(
           margin: EdgeInsets.symmetric(vertical: 0.h,horizontal: 5.w),
            padding: EdgeInsets.only(top: 10.h),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: PageStyle.c_EEEEEE, width: 1.w)),
            ),
           child: Text(
             '1.限VIP连续包年使用；  2.每笔订单只能使用一张优惠券，多张优惠券不能同享，每惠券只能使用一次；  3.不支持兑现，不支持找零，不与其他优惠同享。',
             softWrap: true,
             maxLines: 3,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(
               color: PageStyle.c_999999,
               fontSize: 11.sp,
               fontWeight: FontWeight.w400,
             ),
           ),
         )
        ],
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


class couponModel {
  String couponName = '';
  String couponPrice = '';
  bool canUse = false;
  bool disable = false;

}