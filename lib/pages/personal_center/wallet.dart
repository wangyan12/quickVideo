import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/pages/personal_center/charge_vip.dart';
import 'package:shipin/styles.dart';

class _ChargeValueGroupItem extends StatelessWidget {
  const _ChargeValueGroupItem(
      {super.key,
      required this.value,
      required this.valueGroup,
      required this.valueChanged});
  final String value;
  final String valueGroup;
  final ValueChanged<String> valueChanged;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => valueChanged(value),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: value == valueGroup ? PageStyle.c_F8EDFF : Colors.white,
            borderRadius: BorderRadius.circular(5.w),
            border: Border.all(color: PageStyle.c_9B23EA, width: 0.5.w)),
        width: 98.w,
        height: 50.w,
        child: Text(
          "$value元",
          style: PageStyle.ts_333333_14sp,
        ),
      ),
    );
  }
}

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String chargeValueGroup = "50";
  valueChanged(value) => setState(() => chargeValueGroup = value);
  String paymentType = "alipay";
  paymentChanged(value) => setState(() => paymentType = value);
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        title: const Text("钱包"),
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                foregroundColor: PageStyle.c_333333,
                textStyle: TextStyle(fontSize: 13.sp)),
            child: const Text("咨询客服"),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {

          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: ListView(
            children: [
              SizedBox(
                height: 10.w,
              ),
              buildTotal(),
              SizedBox(
                height: 10.w,
              ),
              buildChargeAmount(),
              SizedBox(
                height: 10.w,
              ),
              buildPayment(),
            ],
          ),
        ),
      ),
    );
  }

  buildTotal() {
    return Container(
      width: 345.w,
      height: 82.5.w,
      decoration: BoxDecoration(
        color: PageStyle.c_9B23EA,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
            color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text.rich(TextSpan(children: [
              // WidgetSpan(child: Image.asset("name")
              TextSpan(text: "总资产")
            ])),
            SizedBox(
              height: 12.w,
            ),
            const Text("3232.86 元")
          ],
        ),
      ),
    );
  }

  buildChargeAmount() {
    var inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.w),
        borderSide: BorderSide(
            color: PageStyle.c_9B23EA, style: BorderStyle.solid, width: 0.5.w));
    return Container(
      width: 345.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      padding: EdgeInsets.all(15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "充值金额",
            style: TextStyle(
                color: PageStyle.c_333333,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.w,
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                valueChanged("0");
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: chargeValueGroup == "0"? PageStyle.c_F8EDFF :Colors.white,
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border.all(color: PageStyle.c_9B23EA, width: 0.5.w)),
              width: 315.w,
              height: 49.w,
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  left: 16.5.w, right: 25.5.w, top: 12.w, bottom: 15.w),
              child: Row(
                children: [
                  Text("自定义充值",style: TextStyle(color: PageStyle.c_333333,fontSize: 12.sp),),
                  Expanded(
                    child: TextField(
                      controller: controller,

                      onTap: (){
                        setState(() {
                          valueChanged("0");
                        });
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: PageStyle.c_9B23EA,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: PageStyle.c_333333,
                          fontWeight: FontWeight.bold),
                      // decoration: InputDecoration.collapsed(hintText: "自定义充值"),

                      inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                      decoration: const InputDecoration(

                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: InputBorder.none,
                        // suffixText: "元",
                        contentPadding: EdgeInsets.zero,
                        isCollapsed: true,
                        focusColor: PageStyle.c_9B23EA,
                      ),
                    ),
                  ),
                  Text("元",style: TextStyle(color: PageStyle.c_333333,fontSize: 12.sp),),
                  SizedBox(width: 10.w,),
                  Image.asset(
                    'assets/images/my_icon_edit.png',
                    width: 22.w,
                    height: 22.w,
                    fit: BoxFit.contain,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.w,
            children: [
              _ChargeValueGroupItem(
                  value: "50",
                  valueGroup: chargeValueGroup,
                  valueChanged: valueChanged),
              _ChargeValueGroupItem(
                  value: "100",
                  valueGroup: chargeValueGroup,
                  valueChanged: valueChanged),
              _ChargeValueGroupItem(
                  value: "200",
                  valueGroup: chargeValueGroup,
                  valueChanged: valueChanged),
              _ChargeValueGroupItem(
                  value: "300",
                  valueGroup: chargeValueGroup,
                  valueChanged: valueChanged),
              _ChargeValueGroupItem(
                  value: "500",
                  valueGroup: chargeValueGroup,
                  valueChanged: valueChanged),
              _ChargeValueGroupItem(
                  value: "800",
                  valueGroup: chargeValueGroup,
                  valueChanged: valueChanged),
            ],
          ),
        ],
      ),
    );
  }

  buildPayment() {
    return Container(
      height: 243.5.w,
      width: 345.w,
      padding:
          EdgeInsets.only(top: 14.5.w, left: 15.w, right: 15.w, bottom: 25.w),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "充值方式",
            style: TextStyle(
                color: PageStyle.c_333333,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp),
          ),
          PaymentTile(
              onTap: paymentChanged,
              imageAssert: "alipay",
              paymentType: "alipay",
              radioGroup: paymentType,
              title: "支付宝充值"),
          PaymentTile(
              onTap: paymentChanged,
              imageAssert: "wechat",
              paymentType: "wechat",
              radioGroup: paymentType,
              title: "微信充值"),
          Container(
            decoration: BoxDecoration(
              color: PageStyle.c_9B23EA,
              borderRadius: BorderRadius.circular(17.w),
            ),
            width: 345.w,
            height: 34.w,
            child: Center(
                child: Text(
              "¥ ${parseValue()} 立即充值",
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

  parseValue(){
    return chargeValueGroup=="0"? double.tryParse(controller.text)?.toStringAsFixed(2) ?? "0.00":double.parse(chargeValueGroup).toStringAsFixed(2);
  }
}
