import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shipin/event_bus.dart';
import 'package:shipin/net/repository_auth.dart';
import 'package:shipin/storage.dart';

import '../../net/string.dart';
import 'add_account.dart';

class SwitchAccountPage extends StatefulWidget{
  const SwitchAccountPage({Key? key, required this.account}) : super(key: key);
  final Map<String, dynamic>? account;

  @override
  State<StatefulWidget> createState() {
    return SwitchAccountPageState();
  }
}
class SwitchAccountPageState extends State<SwitchAccountPage>{
  Map<String, dynamic> accountList = {};

  @override
  void initState() {
    super.initState();
    accountList = StorageUtil().getJSON(StorageUtil.accountList) ?? {};
    debugPrint('++++****------  accountList = $accountList');
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '切换账号',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
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
              width: 23.w,
              height: 23.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              debugPrint(' 添加   点击事件');
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAccountPage())).then((value) {
                accountList = StorageUtil().getJSON(StorageUtil.accountList) ?? {};
                setState(() {});
              });
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: 62.w,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                '添加',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xfff1f5f8),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          itemCount: accountList.length,
          separatorBuilder: (ctx, index) {
            return Container(
              height: 6.h,
            );
          },
          itemBuilder: (ctx, index) {
            return itemWidget(index: index);
          },
        ),
      ),
    );
  }

  itemWidget({
    int? index,
  }) {
    String keyStr = accountList.keys.toList()[index!];
    Map<String, dynamic> account = accountList.values.toList()[index];
    bool currentAccount = false;
    if ((account['username'] == widget.account!['username']) && (account['nickname'] == widget.account!['nickname'])) {
      currentAccount = true;
    }
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (ctx) async {
              debugPrint(' ====------====   Archive  ====------====  ');
              accountList.remove(keyStr);
              await StorageUtil().setJSON(StorageUtil.accountList, accountList);
              setState(() { });
            },
            backgroundColor: const Color(0xFFFF4343),
            foregroundColor: Colors.white,
            label: '删除',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () async {
          debugPrint('切换账号  点击事件 ！！！！！！=========== account = $account');
          if (!currentAccount) {
            debugPrint('+++++++++  登陆事件 获取用户信息  +++++++++');
            Map<String, dynamic> mapData = await mapString(
              data: {
                'username': account['username'],
                'pass1': account['pass'],
                'pass2': account['pass'],
              },
            );
            RepositoryAuth.register(data: mapData, context: context, ua: await uaString()).then((value) {
              if (value['err'] == 0) {
                StorageUtil().setString(StorageUtil.userAuth, value['ext']['auth']);
                EasyLoading.showToast('账号切换成功');
                eventBus.fire(SwitchAccount()..refresh = true);
                Navigator.of(context)..pop()..pop();
              } else {
                EasyLoading.showToast('${value['msg']}');
              }
            }).catchError((error) {

            });

          }
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          color: Colors.white,
          height: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(34.5.w),
                child: account['avatar'] != null ? Image.network(
                  'http://csjk.top${account['avatar']}',
                  width: 69.w,
                  height: 69.w,
                  fit: BoxFit.cover,
                ) : Image.asset(
                  'assets/images/logo_image.png',
                  width: 69.w,
                  height: 69.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 9.w,),
              Expanded(
                child: SizedBox(
                  height: 50.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        account['nickname'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xff232323),
                          fontSize: 16.sp,
                        ),
                      ),
                      if (currentAccount)
                        Text(
                          '当前账号',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xffc2c2c2),
                            fontSize: 12.sp,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 9.w,),
              Image.asset(
                'assets/images/icon_more.png',
                width: 14.w,
                height: 14.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

}