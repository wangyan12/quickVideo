import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh_strong/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shipin/styles.dart';

class FoundPage extends StatefulWidget {
  const FoundPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FoundPageState();
  }
}
class FoundPageState extends State<FoundPage> {
  List listArray = [
    ['会变的时光机1', false],
    ['会变的时光机2', false],
    ['会变的时光机3', true],
    ['会变的时光机4', false],
    ['会变的时光机5', false],
    ['会变的时光机6', true],
    ['会变的时光机7', true],
    ['会变的时光机8', false],

    ['会变的时光机9', false],
    ['会变的时光机10', false],
    ['会变的时光机11', true],
    ['会变的时光机12', false],
    ['会变的时光机13', false],
    ['会变的时光机14', true],
    ['会变的时光机15', true],
    ['会变的时光机16', false],

    ['会变的时光机17', false],
    ['会变的时光机18', false],
    ['会变的时光机19', true],
    ['会变的时光机20', false],
    ['会变的时光机21', false],
    ['会变的时光机22', true],
    ['会变的时光机23', true],
    ['会变的时光机24', false],

    ['会变的时光机25', false],
    ['会变的时光机26', false],
    ['会变的时光机27', true],
    ['会变的时光机28', false],
    ['会变的时光机29', false],
    ['会变的时光机30', true],
    ['会变的时光机31', true],
    ['会变的时光机32', false],
  ];
  ScrollController sController = ScrollController();
  EasyRefreshController? easyRefreshController;

  @override
  void initState() {
    super.initState();
    easyRefreshController = EasyRefreshController();
  }
  @override
  void dispose() {
    super.dispose();
    easyRefreshController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '发现',
          style: PageStyle.ts_000000_18sp,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: MasonryGridView.count(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        scrollDirection: Axis.vertical, // 滚动方向
        reverse: false,   // 颠倒 (数据颠倒显示)
        controller: sController, // 控制器
        // primary: ,
        // physics: const NeverScrollableScrollPhysics(),  // 本身不滚动，让外面的singlescrollview来滚动
        shrinkWrap: true, //收缩，让元素宽度自适应
        crossAxisCount: 1,  // 展示几列
        itemCount: listArray.length,
        mainAxisSpacing: 5.w, // 纵向元素间距  排间距
        crossAxisSpacing: 0.h, // 横向元素间距  列间距
        itemBuilder: (ctx, index) {
          return itemWidget(index);
        },
        // addAutomaticKeepAlives: true, // 添加自动保持活动
        // addRepaintBoundaries: true,  // 添加重新绘制边界
        // addSemanticIndexes: true,  // 添加语义索引
      ),
    );
  }
  // itemWidget
  Widget itemWidget(int index) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.w),
          child: Image.asset(
            'assets/images/reserve_drive_ok.png',
            width: 351.w, // 174.w, //
            height: index % 5 == 0 ? 240.h : index % 5 == 3 ? 270.h : 290.h,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 9.w,
          right: 9.w,
          bottom: 13.5.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  listArray[index][0],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint('====-----=====  点击事件 ');
                  setState(() {
                    listArray[index][1] = !listArray[index][1];
                  });
                },
                behavior: HitTestBehavior.translucent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      listArray[index][1] ? 'assets/images/heart_disselected.png' : 'assets/images/heart.png',
                      width: 20.w,
                      height: 20.w,
                    ),
                    Text(
                      ' 1025',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}