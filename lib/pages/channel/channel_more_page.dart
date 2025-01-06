import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/cate_model.dart';
import '../../net/repository_auth.dart';
import '../../net/string.dart';
import 'channel_list_page.dart';

class ChannelMorePage extends StatefulWidget {
  const ChannelMorePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChannelMorePageState();
  }
}
class ChannelMorePageState extends State<ChannelMorePage> {
  List<CateExtModel> cateList = [];    // 分类列表

  @override
  void initState() {
    super.initState();
    request();
  }
  request() async {
    Map<String, dynamic> dataMap = await mapString(data: {});
    await RepositoryAuth.cate(data: dataMap, context: context).then((value) {
      // debugPrint('********======= cate  value = $value');
      CateModel cateModel = value;
      List<CateExtModel> modelList = cateModel.ext ?? [];
      // List<CateExtModel> cateList = [];
      if (modelList.length > 3) {
        cateList = modelList.sublist(0, 3);
      } else {
        cateList.addAll(modelList);
      }
    }).catchError((error) {
      debugPrint('********======= cate 111111  error = $error');
    });
    cateList.insert(0, CateExtModel(name: '推荐', cid: '', type: '', isVert: null, isHide: null));
    setState(() {});
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
        title: Text(
          '更多',
          style: TextStyle(
            color: const Color(0xff232323),
            fontSize: 17.sp,
          ),
        ),
        backgroundColor: Colors.white,
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
      ),
      body: Container(
        width: 375.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Wrap(
          spacing: 5.w,
          runSpacing: 10.h,
          children: cateList.map((e) {
            return GestureDetector(
              onTap: () {
                debugPrint('你好， 点击事件  ${e.toJson()}');
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => ChannelListPage(cateExtModel: e,)));
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border.all(
                    color: const Color(0xffa0a0a0),
                    width: 0.5,
                  ),
                ),
                child: Text(
                  e.name!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

      ),
    );
  }
}