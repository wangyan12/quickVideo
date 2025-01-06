import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    this.index = 0,
    required this.items,
  }) : super(key: key);
  final int index;
  final List<BottomBarItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64 + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.12),
            offset: const Offset(0, -1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          items.length,
              (index) => _buildItemView(
            i: index,
            item: items.elementAt(index),
          ),
        ).toList(),
      ),
    );
  }

  Widget _buildItemView({required int i, required BottomBarItem item}) =>
      Expanded(
        child: GestureDetector(
          onTap: () {
            if (item.onClick != null) item.onClick!(i);
          },
          behavior: HitTestBehavior.translucent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 38,
                child: Text(
                  item.label,
                  style: i == index ? (item.selectedStyle ?? const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF1B72EC),
                  )) : (item.unselectedStyle ?? const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF1B72EC),
                  )),
                ),
              ),
              Positioned(
                top: 8,
                child: Image.asset(
                  i == index ? item.selectedImgRes : item.unselectedImgRes,
                  width: item.imgWidth,
                  height: item.imgHeight,
                  fit: BoxFit.fill,
                ),
              ),
              // Positioned(
              //   top: 3.h,
              //   child: Container(
              //     padding: EdgeInsets.only(left: 15.w),
              //     child: UnreadCountView(
              //       steam: item.steam,
              //       count: item.count,
              //       qqBadge: true,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
}

class BottomBarItem {
  final String selectedImgRes;
  final String unselectedImgRes;
  final String label;
  final TextStyle? selectedStyle;
  final TextStyle? unselectedStyle;
  final double imgWidth;
  final double imgHeight;
  final Function(int index)? onClick;
  final Stream<int>? steam;
  final int? count;

  BottomBarItem(
      {required this.selectedImgRes,
        required this.unselectedImgRes,
        required this.label,
        this.selectedStyle,
        this.unselectedStyle,
        required this.imgWidth,
        required this.imgHeight,
        this.onClick,
        this.steam,
        this.count});
}
