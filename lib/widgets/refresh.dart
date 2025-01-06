import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh_strong/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget myEmptyViewWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        'assets/images/no_data.png',
        width: 64.w,
        height: 64.w,
      ),
      SizedBox(
        height: 10.w,
      ),
      Text(
        "暂无数据",
        style: TextStyle(color: const Color(0xff999999).withAlpha(150)),
      )
    ],
  );
}

// 为了设置MaterialHeader的valueColor，改为了状态组件
class myRefresh extends StatefulWidget {
  EasyRefreshController? controller;
  Function? refreshFn;
  Function? loadFn;
  Widget? child;
  bool showEmptyWidget;
  myRefresh({
    Key? key,
    @required this.controller,
    this.refreshFn,
    this.loadFn,
    this.child,
    this.showEmptyWidget = false,
  }) : super(key: key);

  @override
  State<myRefresh> createState() => myRefreshState();
}

class myRefreshState extends State<myRefresh> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    // 这里面的参数设置不重要
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      controller: widget.controller,
      emptyWidget: widget.showEmptyWidget ? myEmptyViewWidget() : null,
      bottomBouncing: true,
      header: MaterialHeader(
        valueColor: ColorTween(
          begin: Colors.black,
          end: const Color(0xff222222),
        ).animate(_controller!),
      ),
      footer: BallPulseFooter(
        color: const Color(0xff222222),
      ),
      onRefresh: widget.refreshFn != null
          ? () async {
        try {
          await widget.refreshFn!();
        } finally {
          widget.controller!.finishRefresh();
        }
      } : null,
      onLoad: widget.loadFn != null
          ? () async {
        try {
          await widget.loadFn!();
        } finally {
          widget.controller!.finishLoad();
        }
      } : null,
      child: widget.child,
    );
  }
}
