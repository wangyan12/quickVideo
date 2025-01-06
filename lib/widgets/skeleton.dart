// import 'package:car_lincoln/config/colors.dart';
// import 'package:car_lincoln/utils/utils.dart';
// import 'package:car_lincoln/widgets/common/button.dart';
// import 'package:car_lincoln/widgets/common/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// // ignore: must_be_immutable
// class MySkeleton extends StatefulWidget {
//   // logo 骨架屏、loading 加载中、fail 接口请求失败。默认是logo
//   // 失败的处理方式，由回调决定
//   final String? type;
//   bool netFail; // 网络错误（暂时只在home页有用。可看作是type=fail的一种情况，优先级高于一切）
//   final double? height;
//   final double width;
//   double marginTop;
//   double marginBottom;
//   final String failText;
//   final bool failToBack; // 如果接口请求失败，是否返回上一个页面
//   final failToRefresh; // 如果接口请求失败，传入的刷新回调
//
//   MySkeleton({
//     Key? key,
//     this.height,
//     this.width = 350, // logo默认大小
//     this.marginTop = 0,
//     this.marginBottom = 0,
//     this.type,
//     this.netFail = false,
//     this.failText = '数据获取失败',
//     this.failToBack = false,
//     this.failToRefresh,
//   }) : super(key: key);
//
//   @override
//   createState() => MySkeletonState();
// }
//
// class MySkeletonState extends State<MySkeleton> with SingleTickerProviderStateMixin {
//   AnimationController? _controller;
//   Animation? animation;
//   String? _type;
//   var _eventBusFn;
//
//   @override
//   void initState() {
//     super.initState();
//     _type = widget.type;
//
//     _eventBusFn = eventBus.on<ResponseShow>().listen((event) async {
//       if (event.type == 'fail') {
//         // 如果是网络错误，界面展示
//         if (widget.netFail) return;
//         // 回退至上一个页面，主要是因为有的页面没有顶部回退按钮，所以直接回退好了
//         if (widget.failToBack) {
//           bool canPop = await Navigator.of(context).maybePop();
//           if (!canPop) {
//             Navigator.of(context).popAndPushNamed("/layout");
//           }
//           Navigator.of(context).maybePop();
//         } else {
//           setState(() {
//             _type = event.type;
//           });
//         }
//       }
//     });
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//
//     animation = Tween<double>(begin: -1.0, end: 2.0).animate(
//         CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller!));
//
//     animation!.addStatusListener((status) {
//       if (status == AnimationStatus.completed ||
//           status == AnimationStatus.dismissed) {
//         _controller!.repeat();
//       } else if (status == AnimationStatus.dismissed) {
//         _controller!.forward();
//       }
//     });
//     _controller!.forward();
//   }
//
//   @override
//   void dispose() {
//     _eventBusFn.cancel();
//     _controller!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: widget.height != null ? widget.height.h : double.infinity,
//       margin: EdgeInsets.only(
//         top: widget.marginTop.h,
//         bottom: widget.marginBottom.h,
//       ),
//       child: Center(
//         child: widget.netFail ? Text(
//           '网络未连接，请检查网络后重试',
//         ) : _type == 'loading' ? myLoading(width: 60) : _type == 'fail' ? widget.failToRefresh == null ? Text(
//           widget.failText,
//           style: TextStyle(color: AppColors.text),
//         ) : SizedBox(
//           width: 100.w,
//           child: myButton(
//             text: '点击刷新',
//             borderRadius: 4,
//             onPress: () {
//               setState(() {
//                 _type = 'loading';
//               });
//               widget.failToRefresh();
//             },
//           ),
//         ) : Opacity(
//           opacity: 0.1,
//           child: Image.asset(
//             'assets/images/logo.png',
//             width: 80.w,
//             fit: BoxFit.contain,
//             color: const Color(0xffffffff),
//             colorBlendMode: BlendMode.saturation,
//           ),
//         ),
//       ),
//     );
//   }
// }
