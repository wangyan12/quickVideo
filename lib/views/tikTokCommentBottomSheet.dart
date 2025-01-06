
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../style/style.dart';

class TikTokCommentBottomSheet extends StatefulWidget {
  const TikTokCommentBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<TikTokCommentBottomSheet> createState() => _TikTokCommentBottomSheetState();
}

class _TikTokCommentBottomSheetState extends State<TikTokCommentBottomSheet> {
  TextEditingController commentEC = TextEditingController();
  FocusNode commentFC = FocusNode();
  double keyboard = 0.0;

  @override
  void initState() {
    super.initState();

    commentFC.addListener(() {
      if (commentFC.hasFocus) {
        debugPrint('11111222222222221111111122');
      } else {
        debugPrint('99999998888888889999999999');
      }
      Future.delayed(const Duration(milliseconds: 100), () {
        // 键盘高度
        keyboard = EdgeInsets.fromViewPadding(
          View.of(context).viewInsets,
          View.of(context).devicePixelRatio,
        ).bottom;
        setState(() { });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.w)),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 23.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 32.w),
                  Text(
                    '1235条评论',
                    style: TextStyle(
                      color: const Color(0xff333333),
                      fontSize: 12.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/icon_close.png',
                        width: 14.w,
                        height: 14.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  left: 15.w,
                  top: 5.h,
                  right: 15.w,
                  bottom: 5.h,
                ),
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                children: [
                  firstCommentEvent(numInt: 1),
                  firstCommentEvent(numInt: 0),
                  firstCommentEvent(numInt: 0),
                  firstCommentEvent(numInt: 3),
                  firstCommentEvent(numInt: 1),
                  firstCommentEvent(numInt: 2),
                  firstCommentEvent(numInt: 1),
                  firstCommentEvent(numInt: 0),
                  firstCommentEvent(numInt: 0),
                  firstCommentEvent(numInt: 0),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff0f0f0),
                  borderRadius: BorderRadius.circular(5.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                child: TextField(
                  controller: commentEC,
                  focusNode: commentFC,
                  style: TextStyle(
                    color: const Color(0xff232323),
                    fontSize: 12.sp,
                  ),
                  // maxLines: 4, // 这个和return 发生冲突
                  // minLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                    isDense: true,
                    hintText: '我来说一说...',
                    hintStyle: TextStyle(
                      color: const Color(0xff999999),
                      fontSize: 12.sp,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.send,
                  // onEditingComplete: () {
                  //   debugPrint('=====----====-----=====  111222333');
                  // },
                  onSubmitted: (str) {
                    debugPrint('=====----====-----=====  str = $str');
                  },
                ),
              ),
            ),
            if (keyboard == 0)
              SizedBox(height: 7.5.h + (ScreenUtil().bottomBarHeight == 0 ? 10 : ScreenUtil().bottomBarHeight)),
            if (keyboard > 0)
              SizedBox(height: keyboard),
          ],
        ),
      ),
    );
  }
  // 一级评论
  firstCommentEvent({required int numInt}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/icon_head.png',
                width: 27.w,
                height: 27.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '灰太狼$numInt',
                    style: TextStyle(
                      color: const Color(0xff666666),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '人生没有标准答案  勇敢的人先享受世界',
                    style: TextStyle(
                      color: const Color(0xff333333),
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '昨天14:32',
                        style: TextStyle(
                          color: const Color(0xff999999),
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        '回复',
                        style: TextStyle(
                          color: const Color(0xff999999),
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  if (numInt > 0)...[
                    SizedBox(height: 20.h),
                    for (int i = 0; i < numInt; i++)...[
                      secondaryCommentEvent(numInt: i),
                      if (i != numInt - 1)...[
                        SizedBox(height: 15.h),
                      ],
                    ],
                  ],
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
  // 二级评论
  secondaryCommentEvent({required int numInt}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/g2.png',
            width: 27.w,
            height: 27.w,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '灰太狼$numInt',
                style: TextStyle(
                  color: const Color(0xff666666),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                '人生没有标准答案  勇敢的人先享受世界',
                style: TextStyle(
                  color: const Color(0xff333333),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '昨天14:32',
                    style: TextStyle(
                      color: const Color(0xff999999),
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    '回复',
                    style: TextStyle(
                      color: const Color(0xff999999),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '是假用户哟',
          style: StandardTextStyle.smallWithOpacity,
        ),
        Container(height: 2),
        Text(
          '这是一条模拟评论，主播666啊。',
          style: StandardTextStyle.normal,
        ),
      ],
    );
    Widget right = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        Text(
          '54',
          style: StandardTextStyle.small,
        ),
      ],
    );
    right = Opacity(
      opacity: 0.3,
      child: right,
    );
    var avatar = Container(
      margin: EdgeInsets.fromLTRB(0, 8, 10, 8),
      child: Container(
        height: 36,
        width: 36,
        child: ClipOval(
          child: Image.network(
            "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: <Widget>[
          avatar,
          Expanded(child: info),
          right,
        ],
      ),
    );
  }
}
