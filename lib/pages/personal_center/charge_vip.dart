import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles.dart';

class PriceItem extends StatelessWidget {
  const PriceItem(
      {super.key,
      required this.price,
      required this.showOnSell,
      required this.title,
      required this.onClick,
      required this.valueGroup});

  final num price;
  final num valueGroup;
  final String title;
  final bool showOnSell;
  final ValueChanged<num> onClick;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 5.w,
          left: 0,
          right: 0,
          // width: 99.w,
          height: 130.w,
          child: GestureDetector(
            onTap: () => onClick(price),
            child: Container(
              decoration: BoxDecoration(
                  color:
                      price == valueGroup ? PageStyle.c_F8EDFF : Colors.white,
                  borderRadius: BorderRadius.circular(8.sp),
                  border: Border.all(width: 0.5.w, color: PageStyle.c_9B23EA)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: PageStyle.c_333333,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp),
                  ),
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              color: PageStyle.c_9B23EA,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: "¥",
                            style: TextStyle(
                              fontSize: 14.sp,
                            )),
                        TextSpan(
                            text: "$price",
                            style: TextStyle(
                              fontSize: 32.sp,
                            )),
                        TextSpan(
                            text: " ",
                            style: TextStyle(
                              fontSize: 14.sp,
                            )),
                      ])),
                  Container(
                    padding: EdgeInsets.only(
                        top: 2.5.w, left: 13.w, right: 13.w, bottom: 3.w),
                    decoration: BoxDecoration(
                      color: PageStyle.c_9B23EA,
                      borderRadius: BorderRadius.circular(9.w),
                    ),
                    child: Text(
                      "立即体验",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showOnSell)
          Positioned(
              top: 0,
              left: 0,
              // width: 56.w,
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: 2.5.w, horizontal: 6.5.w),
                decoration: BoxDecoration(
                  color: PageStyle.c_9B23EA,
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: Text(
                  "首充特惠",
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                ),
              ))
      ],
    );
  }
}

//
class PaymentTile extends StatelessWidget {
  const PaymentTile(
      {super.key,
      required this.onTap,
      required this.imageAssert,
      required this.paymentType,
      required this.radioGroup,
      required this.title});
  final ValueChanged<String> onTap;
  final String imageAssert;
  final String title;
  final String paymentType;
  final String radioGroup;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(paymentType),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.5.w, vertical: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          border: Border.all(color: PageStyle.c_9B23EA, width: 0.5.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/icon_$imageAssert.png",
                  width: 12.5.sp,
                  height: 12.5.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 12.sp, color: PageStyle.c_333333),
                ),
              ],
            ),
            Icon(
              paymentType == radioGroup
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: PageStyle.c_9B23EA,
            )
          ],
        ),
      ),
    );
  }
}

class ChargeVip extends StatefulWidget {
  const ChargeVip({super.key});

  @override
  State<ChargeVip> createState() => _ChargeVipState();
}

class _ChargeVipState extends State<ChargeVip> {
  num selectedPrice = 128;
  String selectPayment = "alipay"; // alipay wechat

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.dg),
              topRight: Radius.circular(25.dg))),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "会员充值",
                style: TextStyle(
                    color: PageStyle.c_333333,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
            ],
          ),
          // itemCard;

          SizedBox(
            width: 345.w,
            height: 135.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: PriceItem(
                  price: 128,
                  showOnSell: true,
                  valueGroup: selectedPrice,
                  title: "连续包年",
                  onClick: (price) => setState(() {
                    selectedPrice = price;
                  }),
                )),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                    child: PriceItem(
                  price: 60,
                  title: "连续包季",
                  valueGroup: selectedPrice,
                  showOnSell: false,
                  onClick: (price) => setState(() {
                    selectedPrice = price;
                  }),
                )),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                    child: PriceItem(
                  price: 20,
                  title: "连续包月",
                  valueGroup: selectedPrice,
                  showOnSell: false,
                  onClick: (price) => setState(() {
                    selectedPrice = price;
                  }),
                )),
              ],
            ),
          ),

          // payment_tile
          PaymentTile(
            onTap: (value) => setState(() {
              selectPayment = value;
            }),
            imageAssert: 'alipay',
            paymentType: 'alipay',
            radioGroup: selectPayment,
            title: '支付宝充值',
          ),
          PaymentTile(
            onTap: (value) => setState(() {
              selectPayment = value;
            }),
            imageAssert: 'wechat',
            paymentType: 'wechat',
            radioGroup: selectPayment,
            title: '微信充值',
          ),

          // pay_button;

          Container(
            decoration: BoxDecoration(
              color: PageStyle.c_9B23EA,
              borderRadius: BorderRadius.circular(17.w),
            ),
            width: 345.w,
            height: 34.w,
            child: Center(
                child: Text(
              "¥${selectedPrice.roundToDouble().toStringAsFixed(2)} 立即开通",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            )),
          )
        ],
      ),
    );
  }
}
