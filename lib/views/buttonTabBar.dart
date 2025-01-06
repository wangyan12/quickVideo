
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'selectText.dart';

enum ButtonPageTag {
  home,
  channel,
  found,
  game,
  my,
}

class ButtonTabBar extends StatelessWidget {
  final Function(ButtonPageTag)? onTabSwitch;
  final Function()? onAddButton;

  final bool hasBackground;
  final ButtonPageTag? current;

  const ButtonTabBar({
    Key? key,
    this.onTabSwitch,
    this.current,
    this.onAddButton,
    this.hasBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    Widget row = Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => onTabSwitch?.call(ButtonPageTag.home),
            behavior: HitTestBehavior.translucent,
            child: SelectText(
              isSelect: current == ButtonPageTag.home,
              title: '首页',
              // selectedImgRes: 'assets/images/home_selected.png',
              // unselectedImgRes: 'assets/images/home_default.png',
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: SelectText(
              isSelect: current == ButtonPageTag.channel,
              title: '频道',
              // selectedImgRes: 'assets/images/video_selected.png',
              // unselectedImgRes: 'assets/images/video_default.png',
            ),
            onTap: () => onTabSwitch?.call(ButtonPageTag.channel),
          ),
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: SelectText(
              isSelect: current == ButtonPageTag.found,
              title: '发现',
              // selectedImgRes: 'assets/images/live_selected.png',
              // unselectedImgRes: 'assets/images/live_default.png',
            ),
            onTap: () => onTabSwitch?.call(ButtonPageTag.found),
          ),
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: SelectText(
              isSelect: current == ButtonPageTag.game,
              title: '游戏',
              // selectedImgRes: 'assets/images/apply_selected.png',
              // unselectedImgRes: 'assets/images/apply_default.png',
            ),
            onTap: () => onTabSwitch?.call(ButtonPageTag.game),
          ),
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: SelectText(
              isSelect: current == ButtonPageTag.my,
              title: '我的',
              // selectedImgRes: 'assets/images/my_selected.png',
              // unselectedImgRes: 'assets/images/my_default.png',
            ),
            onTap: () => onTabSwitch?.call(ButtonPageTag.my),
          ),
        ),
      ],
    );
    return Container(
      // color: hasBackground ? ColorPlate.back2 : ColorPlate.back2.withOpacity(0),
      color: const Color(0xffF6F6F6),
      child: Container(
        padding: EdgeInsets.only(bottom: padding.bottom),
        height: 50.h + padding.bottom,
        child: row,
      ),
    );
  }
}