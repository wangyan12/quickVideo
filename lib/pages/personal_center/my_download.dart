import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/storage.dart';

class MyDownloadPage extends StatefulWidget{
  const MyDownloadPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyDownloadPageState();
  }
}
class MyDownloadPageState extends State<MyDownloadPage> {
  bool editorOrFinishBool = false;
  List itemList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  List downloadList = [];
  List chooseArray = [];

  @override
  void initState() {
    super.initState();
    downloadListClick();
  }
  downloadListClick() async {
    downloadList = await StorageUtil().getJSON(StorageUtil.downloadRecord);
    setState(() {});
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
          '我的下载',
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
              debugPrint(' 编辑 完成   点击事件');
              chooseArray.clear();
              setState(() {
                editorOrFinishBool = !editorOrFinishBool;
              });
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: 62.w,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                editorOrFinishBool ? '完成' : '编辑',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xfff1f5f8),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                itemCount: downloadList.length,
                separatorBuilder: (ctx, index) {
                  return SizedBox(height: 5.h,);
                },
                itemBuilder: (ctx, index) {
                  /*
                  if (index == 0) {
                    // return SizedBox(
                    //   height: 60.h,
                    //   child: CachedNetworkImage(
                    //     imageUrl: "http://ali3.a.yximgs.com/upic/2018/08/07/20/BMjAxODA4MDcyMDQ5MjJfNDM0MDc5NTAwXzc0ODc2NDI5NzRfMl8z_B05248cf759b8fc4ac5ca3a8555fc6d5b.jpg?tag=1-1533692761-h-0-no8r5yuw4j-6b6be077064e4a27",
                    //     placeholder: (context, url) => const CircularProgressIndicator(),
                    //     errorWidget: (context, url, error) => const Icon(Icons.error),
                    //   ),
                    // );
                    return SizedBox(
                      height: 60.h,
                      child: Image.network(
                        "http://ali3.a.yximgs.com/upic/2018/08/07/20/BMjAxODA4MDcyMDQ5MjJfNDM0MDc5NTAwXzc0ODc2NDI5NzRfMl8z_B05248cf759b8fc4ac5ca3a8555fc6d5b.jpg",
                      ),
                    );
                  } else if (index == 1) {
                    return SizedBox(
                      height: 60.h,
                      child: CachedNetworkImage(
                        imageUrl: "http://ali3.a.yximgs.com/upic/2018/08/07/20/BMjAxODA4MDcyMDQ5MjJfNDM0MDc5NTAwXzc0ODc2NDI5NzRfMl8z_B05248cf759b8fc4ac5ca3a8555fc6d5b.jpg",
                        progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    );
                  } else if (index == 2) {
                    return SizedBox(
                      height: 60.h,
                      child: CachedNetworkImage(
                        imageUrl: "http://ali3.a.yximgs.com/upic/2018/08/07/20/BMjAxODA4MDcyMDQ5MjJfNDM0MDc5NTAwXzc0ODc2NDI5NzRfMl8z_B05248cf759b8fc4ac5ca3a8555fc6d5b.jpg",
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                              ),
                            ),
                          );
                        },
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    );
                  }
                  */
                  return itemWidget(
                    titleString: downloadList[index]['title'],  // '第${itemList[index]}个',
                    index: index,
                  );
                },
              ),
            ),
            if (editorOrFinishBool)
              Container(
                height: 44.h,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        for (int i = 0; i < chooseArray.length; i++) {
                          itemList.remove(chooseArray[i]);
                        }
                        chooseArray.clear();
                        setState(() {});
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: 187.w,
                        height: 44.h,
                        alignment: Alignment.center,
                        child: Text(
                          '删除',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0xff7a7a7a),
                      width: 1.w,
                      height: 26.5.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        chooseArray.clear();
                        chooseArray.addAll(itemList);
                        setState(() {});
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: 187.w,
                        height: 44.h,
                        alignment: Alignment.center,
                        child: Text(
                          '全选（${chooseArray.length}）',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),

      ),
    );
  }

  itemWidget({String? titleString, int? index}) {
    Map<String, dynamic> downloadMap = downloadList[index!];
    String imageStr = downloadMap['image'];
    imageStr = imageStr.split('?')[0];
    bool containsBool = chooseArray.contains(itemList[index]);
    return GestureDetector(
      onTap: () {
        debugPrint('============  ${downloadMap['image']}');
        // if (editorOrFinishBool) {
        //   if (containsBool) {
        //     chooseArray.remove(itemList[index]);
        //   } else {
        //     chooseArray.add(itemList[index]);
        //   }
        // } else {
        //   debugPrint(' 不是选择状态 点击事件 ');
        // }
        setState(() { });
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12.5.h),
        child: Row(
          children: [
            if (editorOrFinishBool)...[
              SizedBox(width: 12.w,),
              Image.asset(
                containsBool ? 'assets/images/icon_select.png' : 'assets/images/icon_defealt.png',
                width: 20.w,
                height: 20.w,
                fit: BoxFit.fill,
              ),
              SizedBox(width: 10.w,),
            ],
            if (!editorOrFinishBool)
              SizedBox(width: 20.w,),
            CachedNetworkImage(
              imageUrl: imageStr,  //  downloadMap['image'],
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/reserve_drive_ok.png',
                width: 130.w,
                height: 75.h,
                fit: BoxFit.cover,
              ),
              width: 130.w,
              height: 75.h,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12.w,),
            Expanded(
              child: SizedBox(
                height: 75.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      downloadMap['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 13.h,),
                    Text(
                      '第28集',
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '下载完成',
                      // '正在下载 60%',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xffa1a1a1),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}