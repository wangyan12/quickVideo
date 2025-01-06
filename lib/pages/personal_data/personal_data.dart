// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class PersonalData extends StatefulWidget {
//   const PersonalData({Key? key, required this.contentString}) : super(key: key);
//   final String contentString;
//
//   @override
//   State<StatefulWidget> createState() {
//     return PersonalDataState();
//   }
// }
// class PersonalDataState extends State<PersonalData> {
//   String? contentStr;
//
//   @override
//   void initState() {
//     super.initState();
//     contentStr = widget.contentString;
//   }
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   refreshClick(String? titleStr) {
//     setState(() {
//       contentStr = titleStr;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           '个人资料',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 17.sp,
//           ),
//         ),
//       ),
//       body: Container(
//         color: Colors.amber,
//         child: Center(
//           child: Text(
//             contentStr!,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20.sp,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shipin/styles.dart';
import 'package:tapped/tapped.dart';

import '../../views/topToolRow.dart';

class PersonalData extends StatefulWidget {
  final bool canPop;
  final bool isSelfPage;
  final Function? onPop;
  final Function? onSwitch;

  const PersonalData({
    Key? key,
    this.canPop = false,
    this.onPop,
    required this.isSelfPage,
    this.onSwitch,
  }) : super(key: key);

  @override
  PersonalDataState createState() => PersonalDataState();
}

class PersonalDataState extends State<PersonalData> {
  int chooseIndex = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('000000++++++++---------   个人页面  ${widget.key}');
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Widget likeButton = Container(
      color: ColorPlate.back1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Tapped(
            child: _UserRightButton(
              title: widget.isSelfPage ? '钱包' : '关注',
            ),
          ),
        ],
      ),
    );
    Widget avatar = Container(
      height: 120 + MediaQuery.of(context).padding.top,
      padding: const EdgeInsets.only(left: 18),
      alignment: Alignment.bottomLeft,
      child: OverflowBox(
        alignment: Alignment.bottomLeft,
        minHeight: 20,
        maxHeight: 300,
        child: Container(
          height: 74,
          width: 74,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(44),
            color: Colors.orange,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
    Widget body = ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      children: <Widget>[
        Container(height: 20),
        // 头像与关注
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[likeButton, avatar],
        ),
        Container(
          color: ColorPlate.back1,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 18),
                color: ColorPlate.back1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      '@用户名',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SysSize.big,
                        fontWeight: FontWeight.w600,
                        inherit: true,
                      ),
                    ),
                    Container(height: 8),
                    Text(
                      '朴实无华，且枯燥',
                      style: StandardTextStyle.smallWithOpacity.apply(
                        color: Colors.white,
                      ),
                    ),
                    Container(height: 10),
                    Row(
                      children: const <Widget>[
                        _UserTag(tag: '幽默'),
                        _UserTag(tag: '机智'),
                        _UserTag(tag: '枯燥'),
                        _UserTag(tag: '狮子座'),
                      ],
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                color: ColorPlate.back1,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    TextGroup('356', '关注'),
                    TextGroup('145万', '粉丝'),
                    TextGroup('1423万', '获赞'),
                  ],
                ),
              ),
              Container(
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
              UserVideoTable(
                chooseNum: chooseIndex,
                chooseClick: (int index) {
                  setState(() {
                    chooseIndex = index;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            Colors.orange,
            Colors.red,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 400),
            height: double.infinity,
            width: double.infinity,
            color: ColorPlate.back1,
          ),
          body,
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 62,
            child: TopToolRow(
              canPop: widget.canPop,
              onPop: widget.onPop,
              right: Tapped(
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.36),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.more_horiz,
                    size: 24,
                  ),
                ),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (ctx) => UserDetailPage(),
                  // ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserRightButton extends StatelessWidget {
  const _UserRightButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 20,
      ),
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: ColorPlate.orange),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        title,
        style: const TextStyle(color: ColorPlate.orange),
      ),
    );
  }
}

class _UserTag extends StatelessWidget {
  final String? tag;
  const _UserTag({
    Key? key,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tag ?? '标签',
        style: StandardTextStyle.smallWithOpacity,
      ),
    );
  }
}

class UserVideoTable extends StatelessWidget {
  final Function(int index)? chooseClick;
  final int chooseNum;
  const UserVideoTable({
    Key? key,
    this.chooseClick,
    required this.chooseNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: ColorPlate.back1,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _PointSelectTextButton(chooseNum == 0, '作品', onTap: () {chooseClick!.call(0);},),
              _PointSelectTextButton(chooseNum == 1, '关注', onTap: () {chooseClick!.call(1);},),
              _PointSelectTextButton(chooseNum == 2, '喜欢', onTap: () {chooseClick!.call(2);},),
            ],
          ),
        ),
        MasonryGridView.count(
          crossAxisCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,//增加
          itemCount: 90,
          mainAxisSpacing: 0.w, // 纵向元素间距  排间距
          crossAxisSpacing: 0.h, // 横向元素间距  列间距
          itemBuilder: (ctx, index) {
            return AspectRatio(
              aspectRatio: 3 / 5.0,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorPlate.darkGray,
                  border: Border.all(color: Colors.black),
                ),
                alignment: Alignment.center,
                child: Text(
                  '作品$index',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.1),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SmallVideo extends StatelessWidget {
  const _SmallVideo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 3 / 4.0,
        child: Container(
          decoration: BoxDecoration(
            color: ColorPlate.darkGray,
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: Text(
            '作品',
            style: TextStyle(
              color: Colors.white.withOpacity(0.1),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class _PointSelectTextButton extends StatelessWidget {
  final bool isSelect;
  final String title;
  final Function() onTap;
  const _PointSelectTextButton(
      this.isSelect,
      this.title, {
        Key? key,
        required this.onTap,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isSelect ? Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: ColorPlate.orange,
                  borderRadius: BorderRadius.circular(3),
                ),
              ) : Container(),
              Container(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: isSelect ? const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: SysSize.small,
                    inherit: true,
                  ) : StandardTextStyle.smallWithOpacity,
                  // style: isSelect ? StandardTextStyle.small : StandardTextStyle.smallWithOpacity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _IconTextButton extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Function onTap;
//   const _IconTextButton(
//     this.icon,
//     this.title, {
//     Key key,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(icon, color: ColorPlate.yellow),
//           Container(
//             padding: EdgeInsets.only(left: 2),
//             child: Text(
//               title,
//               style: TextStyle(color: ColorPlate.yellow),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class TextGroup extends StatelessWidget {
  final String title, tag;
  final Color? color;

  const TextGroup(
      this.title,
      this.tag, {
        Key? key,
        this.color,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      // child: Row(
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: <Widget>[
      //     Text(
      //       title,
      //       style: StandardTextStyle.big.apply(color: color),
      //     ),
      //     Container(width: 4),
      //     Text(
      //       tag,
      //       style: StandardTextStyle.smallWithOpacity.apply(
      //         color: color?.withOpacity(0.6),
      //       ),
      //     ),
      //   ],
      // ),
      // child: Text.rich(textSpan),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                inherit: true
              ).apply(color: color),
            ),
            TextSpan(
              text: tag,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  inherit: true
              ).apply(color: color?.withOpacity(0.6)),
            ),

          ],
        ),
      ),
    );
  }
}