import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/event_bus.dart';
import 'package:shipin/net/repository_auth.dart';
import 'package:shipin/net/string.dart';

class ModifyNicknamePage extends StatefulWidget {
  const ModifyNicknamePage({Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ModifyNicknamePageState();
  }
}
class ModifyNicknamePageState extends State<ModifyNicknamePage> {
  TextEditingController nameEC = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '修改昵称',
            style: TextStyle(
              color: const Color(0xff222222),
              fontSize: 17.sp,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
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
        body: Container(
          color: const Color(0xfff1f5f8),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 31.h,
                alignment: Alignment.centerLeft,
                child: Text(
                  '请设置您的新昵称',
                  style: TextStyle(
                    color: const Color(0xffa4a4a4),
                    fontSize: 11.sp,
                  ),
                ),
              ),
              SizedBox(height: 5.5.h,),
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: TextField(
                  controller: nameEC,
                  focusNode: nameFocusNode,
                  style: TextStyle(
                    color: const Color(0xff232323),
                    fontSize: 14.sp,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                    hintText: '请输入您的昵称',
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
              SizedBox(height: 25.h,),
              GestureDetector(
                onTap: () async {
                  debugPrint('+++++++----*******  ');
                  if (nameEC.text.isEmpty) {
                    EasyLoading.showToast('请输入昵称');
                    return ;
                  }
                  Map<String, dynamic> map = await mapString(data: {'nickname': nameEC.text},);
                  RepositoryAuth.nickname(data: map, context: context).then((value) {
                    debugPrint('+++++++--------- nickname  value = $value');
                    if (value['err'] == 0) {
                      EasyLoading.showToast('修改成功');
                      eventBus.fire(ModifyNicknameModel()..refresh = true);
                      Navigator.of(context)..pop()..pop();
                    } else {
                      EasyLoading.showToast('修改失败');
                    }
                  }).catchError((error) {
                    debugPrint('+++++++--------- nickname  error = $error');
                  });
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '确定修改',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}