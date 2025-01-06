
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapped/tapped.dart';

import 'selectText.dart';

class TikTokHeader extends StatefulWidget {
  final Function? onSearch;
  final Function(int index)? onItemEvent;
  const TikTokHeader({
    Key? key,
    this.onSearch,
    this.onItemEvent
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TikTokHeaderState();
  }
}

class _TikTokHeaderState extends State<TikTokHeader> {
  int currentSelect = 0;
  @override
  Widget build(BuildContext context) {
    List<String> list = ['推荐', '视频', '发现', '游戏'];
    List<Widget> headList = [];
    for (var i = 0; i < list.length; i++) {
      headList.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentSelect = i;
            });
            widget.onItemEvent!.call(i);
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                Text(
                  list[i],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    height: 1,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  width: 18.w,
                  height: 1.5.h,
                  decoration: BoxDecoration(
                    color: currentSelect == i ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(1.h),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.5.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: headList,
          ),
          GestureDetector(
            onTap: () {
              widget.onSearch!.call();
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 37.w,
              height: 37.w,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/icon_searchWhite.png',
                width: 22.w,
                height: 22.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      // color: Colors.black.withOpacity(0.3),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Expanded(
          //   child: Tapped(
          //     child: Container(
          //       color: Colors.black.withOpacity(0),
          //       padding: EdgeInsets.all(4),
          //       alignment: Alignment.centerLeft,
          //       child: Icon(
          //         Icons.search,
          //         color: Colors.white.withOpacity(0.66),
          //       ),
          //     ),
          //     onTap: widget.onSearch,
          //   ),
          // ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     color: Colors.black.withOpacity(0),
          //     alignment: Alignment.center,
          //     child: headSwitch,
          //   ),
          // ),
          // Expanded(
          //   child: Tapped(
          //     child: Container(
          //       color: Colors.black.withOpacity(0),
          //       padding: EdgeInsets.all(4),
          //       alignment: Alignment.centerRight,
          //       child: Icon(
          //         Icons.tv,
          //         color: Colors.white.withOpacity(0.66),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
