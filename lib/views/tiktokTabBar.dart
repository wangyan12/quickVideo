
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/style/style.dart';
import 'package:shipin/views/selectText.dart';

enum TikTokPageTag {
  home,
  follow,
  msg,
  me,
}

class TikTokTabBar extends StatelessWidget {
  final Function(TikTokPageTag)? onTabSwitch;
  final Function()? onAddButton;

  final bool hasBackground;
  final TikTokPageTag? current;

  const TikTokTabBar({
    Key? key,
    this.onTabSwitch,
    this.current,
    this.onAddButton,
    this.hasBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
      height: 65.h + ScreenUtil().bottomBarHeight,
      child: SizedBox(
        height: 65.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 16.h,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: hasBackground ? Colors.white : Colors.white.withOpacity(0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onTabSwitch?.call(TikTokPageTag.home),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/${current == TikTokPageTag.home ? 'home_selected' : 'home_default'}.png', // .png
                              width: 26.w,
                              height: 26.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              '首页',
                              style: TextStyle(
                                color: current == TikTokPageTag.home ? const Color(0xff9b23ea) : const Color(0xff999999),
                                fontSize: 10.sp,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onTabSwitch?.call(TikTokPageTag.follow),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/${current == TikTokPageTag.follow ? 'game_selected' : 'game_default'}.png', // .png
                              width: 26.w,
                              height: 26.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              '游戏',
                              style: TextStyle(
                                color: current == TikTokPageTag.follow ? const Color(0xff9b23ea) : const Color(0xff999999),
                                fontSize: 10.sp,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: const SizedBox(),
                        onTap: () => onAddButton?.call(),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onTabSwitch?.call(TikTokPageTag.msg),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/${current == TikTokPageTag.msg ? 'activity_selected' : 'activity_default'}.png', // .png
                              width: 26.w,
                              height: 26.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              '活动',
                              style: TextStyle(
                                color: current == TikTokPageTag.msg ? const Color(0xff9b23ea) : const Color(0xff999999),
                                fontSize: 10.sp,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onTabSwitch?.call(TikTokPageTag.me),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/${current == TikTokPageTag.me ? 'my_selected' : 'my_default'}.png', // .png
                              width: 26.w,
                              height: 26.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              '我的',
                              style: TextStyle(
                                color: current == TikTokPageTag.me ? const Color(0xff9b23ea) : const Color(0xff999999),
                                fontSize: 10.sp,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 162.5.w,
              child: GestureDetector(
                onTap: () => onAddButton?.call(),
                behavior: HitTestBehavior.opaque,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.w),
                  child: Container(
                    color: hasBackground ? Colors.white : Colors.white.withOpacity(0),
                    alignment: Alignment.center,
                    width: 50.w,
                    height: 50.w,
                    child: Image.asset(
                      'assets/images/addImage.png',
                      width: 41.w,
                      height: 41.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
