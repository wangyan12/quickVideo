
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/style/style.dart';
import 'package:tapped/tapped.dart';

class TikTokButtonColumn extends StatelessWidget {
  final double? bottomPadding;
  final bool isFavorite;
  final bool isCollect;
  final Function? onFavorite;
  final Function? onComment;
  final Function? onShare;
  final Function? onAvatar;
  final Function? onCollect;
  const TikTokButtonColumn({
    Key? key,
    this.bottomPadding,
    this.onFavorite,
    this.onComment,
    this.onShare,
    this.isFavorite = false,
    this.onAvatar,
    this.onCollect,
    this.isCollect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SysSize.avatar,
      margin: EdgeInsets.only(
        bottom: bottomPadding ?? 50.h,
        right: 12.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Tapped(
            onTap: onAvatar,
            child: const TikTokAvatar(),
          ),
          SizedBox(height: 35.h),
          _IconButton(
            icon: Image.asset(
              'assets/images/comment_image.png',
              width: 30.w,
              height: 30.w,
              fit: BoxFit.cover,
            ),
            text: '4213',
            onTap: onComment,
          ),
          SizedBox(height: 15.h,),
          FavoriteIcon(
            onFavorite: onFavorite,
            isFavorite: isFavorite,
          ),
          SizedBox(height: 15.h,),
          _IconButton(
            icon: Image.asset(
              'assets/images/${isCollect ? 'selectCollect_image' : 'uncheckedCollect_image'}.png',
              width: 30.w,
              height: 30.w,
              fit: BoxFit.cover,
            ),
            text: '32.2w',
            onTap: onCollect,
          ),
          SizedBox(height: 15.h,),
          _IconButton(
            icon: Image.asset(
              'assets/images/shareImage.png',
              width: 30.w,
              height: 30.w,
              fit: BoxFit.cover,
            ),
            text: '30w',
            onTap: onShare,
          ),
        ],
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    Key? key,
    required this.onFavorite,
    this.isFavorite,
  }) : super(key: key);
  final bool? isFavorite;
  final Function? onFavorite;

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: Image.asset(
        'assets/images/${isFavorite! ? 'heart_disselected' : 'heart'}.png',
        width: 30.w,
        height: 30.w,
        fit: BoxFit.cover,
      ), //isFavorite! ? ,
      text: '1.0w',
      onTap: onFavorite,
    );
  }
}

class TikTokAvatar extends StatelessWidget {
  const TikTokAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          width: 54.w,
          height: 54.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(27.w),
          ),
          alignment: Alignment.center,
          child: ClipOval(
            child: Image.network(
              "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif",
              width: 50.w,
              height: 50.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Image.asset(
          'assets/images/addFollow_image.png',
          width: 20.w,
          height: 20.w,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

/// 把IconData转换为文字，使其可以使用文字样式
class IconToText extends StatelessWidget {
  final IconData? icon;
  final TextStyle? style;
  final double? size;
  final Color? color;

  const IconToText(
    this.icon, {
    Key? key,
    this.style,
    this.size,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon!.codePoint),
      style: style ?? TextStyle(
        fontFamily: 'MaterialIcons',
        fontSize: size ?? 30,
        inherit: true,
        color: color ?? ColorPlate.white,
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final Function? onTap;
  const _IconButton({
    Key? key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shadowStyle = TextStyle(
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 1),
          blurRadius: 1,
        ),
      ],
    );
    Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Tapped(
          onTap: onTap,
          child: icon ?? Container(),
        ),
        SizedBox(height: 2.h),
        Text(
          text ?? '??',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 11.sp,
            color: ColorPlate.white,
          ),
        ),
      ],
    );
    return DefaultTextStyle(
      style: shadowStyle,
      child: body,
    );
  }
}
