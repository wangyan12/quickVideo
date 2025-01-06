import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class PageStyle {
  static const c_FFFFFF = Color(0xFFFFFFFF);
  static const c_000000 = Color(0xFF000000);
  static const c_F6F6F6 = Color(0xFFF6F6F6);
  static const c_F8F8F8 = Color(0xFFF8F8F8);
  static const c_1D6BED = Color(0xff28A5FF); //Color(0xFF1D6BED);
  static const c_1D81FD = Color(0xFF1D81FD);
  static const c_1B72EC = Color(0xFF1B72EC);
  static const c_F3F3F3 = Color(0xFFF3F3F3);
  static const c_666666 = Color(0xFF666666);
  static const c_F0F0F0 = Color(0xFFF0F0F0);
  static const c_999999 = Color(0xFF999999);
  static const c_E8F2FF = Color(0xFFE8F2FF);
  static const c_1B61D6 = Color(0xFF1B61D6);
  static const c_EEEEEE = Color(0xFFEEEEEE);
  static const c_EDEDED = Color(0xFFEDEDED);
  static const c_979797 = Color(0xFF979797);
  static const c_F1F1F1 = Color(0xFFF1F1F1);
  static const c_03091C = Color(0xFF03091C);
  static const c_D8D8D8 = Color(0xFFD8D8D8);
  static const c_333333 = Color(0xFF333333);
  static const c_898989 = Color(0xFF898989);
  static const c_418AE5 = Color(0xFF418AE5);
  static const c_10CC64 = Color(0xFF10CC64);
  static const c_959595 = Color(0xFF959595);
  static const c_5496EB = Color(0xFF5496EB);
  static const c_A2C9F8 = Color(0xFFA2C9F8);
  static const c_FDDFA1 = Color(0xFFFDDFA1);
  static const c_F5F5F5 = Color(0xFFF5F5F5);
  static const c_FF6160 = Color(0xFFFF6160);
  static const c_f7f7f7 = Color(0xfff7f7f7);
  static const c_0096FF = Color(0xff0096FF);
  static const c_33ccff = Color(0xff33ccff);
  static const c_9B23EA = Color(0xFF9B23EA);
  static const c_F8EDFF = Color(0xFFF8EDFF);

  static var c_D8D8D8_opacity40p = const Color(0xFFD8D8D8).withOpacity(0.4);
  static var c_000000_opacity40p = const Color(0xFF000000).withOpacity(0.4);
  static var c_000000_opacity8p = const Color(0xFF000000).withOpacity(0.08);
  static var c_000000_opacity12p = const Color(0xFF000000).withOpacity(0.12);
  static var c_000000_opacity10p = const Color(0xFF000000).withOpacity(0.10);
  static var c_000000_opacity15p = const Color(0xFF000000).withOpacity(0.15);
  static var c_000000_opacity60p = const Color(0xFF000000).withOpacity(0.6);
  static var c_999999_opacity40p = const Color(0xFF999999).withOpacity(0.4);
  static var c_979797_opacity50p = const Color(0xFF979797).withOpacity(0.5);
  static var c_333333_opacity40p = const Color(0xFF333333).withOpacity(0.4);

  ///
  static var ts_FFFFFF_10sp = TextStyle(
    fontSize: 10.sp,
    color: const Color(0xFFFFFFFF),
  );


  static var ts_FFFFFF_12sp = TextStyle(
    fontSize: 12.sp,
    color: const Color(0xFFFFFFFF),
  );
  static var ts_FFFFFF_14sp = TextStyle(
    fontSize: 14.sp,
    color: const Color(0xFFFFFFFF),
  );
  static var ts_FFFFFF_16sp = TextStyle(
    fontSize: 16.sp,
    color: const Color(0xFFFFFFFF),
  );
  static var ts_FFFFFF_18sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFFFFFFFF),
  );
  static var ts_FFFFFF_20sp = TextStyle(
    fontSize: 20.sp,
    color: const Color(0xFFFFFFFF),
  );
  static var ts_FFFFFF_21sp_bold = TextStyle(
    fontSize: 21.sp,
    fontWeight: FontWeight.bold,
    color: const Color(0xFFFFFFFF),
  );
  static var ts_FFFFFF_24sp = TextStyle(
    fontSize: 24.sp,
    color: const Color(0xFFFFFFFF),
  );
  static var ts_FFFFFF_32sp = TextStyle(
    fontSize: 32.sp,
    color: const Color(0xFFFFFFFF),
  );
  static var ts_FFFFFF_opacity40p_18sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFFFFFFFF).withOpacity(0.4),
  );
  static var ts_000000_9sp = TextStyle(
    fontSize: 9.sp,
    color: const Color(0xFF000000),
  );
  static var ts_000000_10sp = TextStyle(
    fontSize: 10.sp,
    color: const Color(0xFF000000),
  );
  static var ts_000000_12sp = TextStyle(
    fontSize: 12.sp,
    color: const Color(0xFF000000),
  );
  static var ts_000000_13sp = TextStyle(
    fontSize: 13.sp,
    color: const Color(0xFF000000),
  );
  static var ts_000000_14sp = TextStyle(
    fontSize: 14.sp,
    color: const Color(0xFF000000),
  );
  static var ts_000000_16sp = TextStyle(
    fontSize: 16.sp,
    color: const Color(0xFF000000),
  );
  static var ts_000000_18sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFF000000),
  );
  static var ts_000000_opacity40p_18sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFF000000).withOpacity(0.4),
  );
  static var ts_000000_opacity50p_16sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFF000000).withOpacity(0.5),
  );
  static var ts_000000_20sp = TextStyle(
    fontSize: 20.sp,
    color: const Color(0xFF000000),
  );
  static var ts_333333_12sp = TextStyle(
    fontSize: 12.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_13sp = TextStyle(
    fontSize: 13.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_14sp = TextStyle(
    fontSize: 14.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_15sp = TextStyle(
    fontSize: 15.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_16sp = TextStyle(
    fontSize: 16.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_18sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_19sp = TextStyle(
    fontSize: 19.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_20sp = TextStyle(
    fontSize: 20.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_24sp = TextStyle(
    fontSize: 24.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_26sp = TextStyle(
    fontSize: 26.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_28sp = TextStyle(
    fontSize: 28.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_32sp = TextStyle(
    fontSize: 32.sp,
    color: const Color(0xFF333333),
  );
  static var ts_333333_opacity40p_14sp = TextStyle(
    fontSize: 14.sp,
    color: const Color(0xFF333333).withOpacity(0.4),
  );
  static var ts_333333_opacity40p_18sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFF333333).withOpacity(0.4),
  );
  static var ts_43DBFF_12sp = TextStyle(
    fontSize: 12.sp,
    color: const Color(0xFF43DBFF),
  );

  static var ts_1D6BED_12sp = TextStyle(
    fontSize: 12.sp,
    color: const Color(0xFF1D6BED),
  );
  static var ts_1D6BED_14sp = TextStyle(
    color: const Color(0xFF1D6BED),
    fontSize: 14.sp,
  );
  static var ts_1D6BED_16sp = TextStyle(
    fontSize: 16.sp,
    color: const Color(0xFF1D6BED),
  );

  static var ts_1B72EC_10sp = TextStyle(
    fontSize: 10.sp,
    color: const Color(0xFF1B72EC),
  );
  static var ts_1B72EC_14sp = TextStyle(
    fontSize: 14.sp,
    color: const Color(0xFF1B72EC),
  );
  static var ts_1B72EC_14sp_underline = TextStyle(
    fontSize: 14.sp,
    color: const Color(0xFF1B72EC),
    decoration: TextDecoration.underline,
  );
  static var ts_1B72EC_16sp = TextStyle(
    fontSize: 16.sp,
    color: const Color(0xFF1B72EC),
  );
  static var ts_1B72EC_22sp = TextStyle(
    color: const Color(0xFF1B72EC),
    fontSize: 22.sp,
  );
  static var ts_006AFF_12sp = TextStyle(
    fontSize: 12.sp,
    color: const Color(0xFF006AFF),
  );

  static var ts_418AE5_12sp = TextStyle(
    color: const Color(0xFF418AE5),
    fontSize: 12.sp,
  );

  static var ts_1D81FD_16sp = TextStyle(
    color: const Color(0xFF1D81FD),
    fontSize: 16.sp,
  );

  static var ts_1B61D6_14sp = TextStyle(
    color: const Color(0xFF1B61D6),
    fontSize: 14.sp,
  );
  static var ts_1B61D6_16sp = TextStyle(
    color: const Color(0xFF1B61D6),
    fontSize: 16.sp,
  );
  static var ts_1B61D6_18sp = TextStyle(
    color: const Color(0xFF1B61D6),
    fontSize: 18.sp,
  );

  static var ts_999999_10sp = TextStyle(
    fontSize: 10.sp,
    color: const Color(0xFF999999),
  );
  static var ts_999999_11sp = TextStyle(
    fontSize: 11.sp,
    color: const Color(0xFF999999),
  );
  static var ts_999999_12sp = TextStyle(
    fontSize: 12.sp,
    color: const Color(0xFF999999),
  );
  static var ts_999999_13sp = TextStyle(
    fontSize: 13.sp,
    color: const Color(0xFF999999),
  );
  static var ts_999999_14sp = TextStyle(
    fontSize: 14.sp,
    color: const Color(0xFF999999),
  );
  static var ts_999999_16sp = TextStyle(
    fontSize: 16.sp,
    color: const Color(0xFF999999),
  );
  static var ts_999999_18sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFF999999),
  );
  static var ts_666666_10sp = TextStyle(
    fontSize: 10.sp,
    color: const Color(0xFF666666),
  );
  static var ts_b7b7b7_10sp = TextStyle(
    fontSize: 10.sp,
    color: const Color(0xFFB7B7B7),
  );
  static var ts_c8a06a_10sp = TextStyle(
    fontSize: 10.sp,
    color: const Color(0xFFC8A06A),
  );
  static var ts_666666_12sp = TextStyle(
    fontSize: 12.sp,
    color: const Color(0xFF666666),
  );
  static var ts_666666_13sp = TextStyle(
    fontSize: 13.sp,
    color: const Color(0xFF666666),
  );
  static var ts_666666_14sp = TextStyle(
    fontSize: 14.sp,
    color: const Color(0xFF666666),
  );
  static var ts_666666_15sp = TextStyle(
    fontSize: 15.sp,
    color: const Color(0xFF666666),
  );
  static var ts_666666_16sp = TextStyle(
    fontSize: 16.sp,
    color: const Color(0xFF666666),
  );
  static var ts_666666_18sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFF666666),
  );
  static var ts_F44038_13sp = TextStyle(
    fontSize: 13.sp,
    color: const Color(0xFFF44038),
  );
  static var ts_FF6160_16sp = TextStyle(
    fontSize: 16.sp,
    color: const Color(0xFFFF6160),
  );

  static var ts_D9350D_18sp = TextStyle(
    color: const Color(0xFFD9350D),
    fontSize: 18.sp,
  );
  static var ts_E80000_16sp = TextStyle(
    color: const Color(0xFFE80000),
    fontSize: 16.sp,
  );
  static var ts_F33E37_15sp = TextStyle(
    color: const Color(0xFFF33E37),
    fontSize: 15.sp,
  );
  static var ts_F33E37_13sp = TextStyle(
    color: const Color(0xFFF33E37),
    fontSize: 13.sp,
  );

  static var ts_B8B8B8_14sp = TextStyle(
    color: const Color(0xFFB8B8B8),
    fontSize: 14.sp,
  );

  static var ts_EDEDED_14sp = TextStyle(
    color: const Color(0xFFEDEDED),
    fontSize: 14.sp,
  );
  static var ts_898989_12sp = TextStyle(
    fontSize: 12.sp,
    color: const Color(0xFF898989),
  );
  static var ts_898989_13sp = TextStyle(
    fontSize: 13.sp,
    color: const Color(0xFF898989),
  );
  static var ts_898989_14sp = TextStyle(
    fontSize: 14.sp,
    color: const Color(0xFF898989),
  );
  static var ts_898989_16sp = TextStyle(
    fontSize: 16.sp,
    color: const Color(0xFF898989),
  );

  static var ts_898989_18sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFF898989),
  );

  static var ts_9F9F9F_16sp = TextStyle(
    fontSize: 16.sp,
    color: const Color(0xFF9F9F9F),
  );

  static var ts_ADADAD_18sp = TextStyle(
    fontSize: 18.sp,
    color: const Color(0xFFADADAD),
  );
  static var ts_ABABAB_12sp = TextStyle(
    fontSize: 12.sp,
    color: const Color(0xffababab),
  );
  static var ts_FF8C00_10sp = TextStyle(
    fontSize: 10.sp,
    color: const Color(0xFFFF8C00),
  );
  static var ts_2691ED_10sp = TextStyle(
    fontSize: 10.sp,
    color: const Color(0xFF2691ED),
  );
}

class SysSize {
  static const double avatar = 56;
  // static const double iconBig = 40;
  static const double iconNormal = 24;
  // static const double big = 18;
  // static const double normal = 16;
  // static const double small = 12;
  static const double iconBig = 40;
  static const double big = 16;
  static const double normal = 14;
  static const double small = 12;
}

class StandardTextStyle {
  static const TextStyle big = TextStyle(
    color: Color(0xFF666666),
    fontWeight: FontWeight.w600,
    fontSize: SysSize.big,
    inherit: true,
  );
  static const TextStyle bigWithOpacity = TextStyle(
    color: Color.fromRGBO(0x66, 0x66, 0x66, .66),
    fontWeight: FontWeight.w600,
    fontSize: SysSize.big,
    inherit: true,
  );
  static const TextStyle normalW = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: SysSize.normal,
    inherit: true,
  );
  static const TextStyle normal = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: SysSize.normal,
    inherit: true,
  );
  static const TextStyle normalWithOpacity = TextStyle(
    color: Color.fromRGBO(0xff, 0xff, 0xff, .66),
    fontWeight: FontWeight.normal,
    fontSize: SysSize.normal,
    inherit: true,
  );
  static const TextStyle small = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: SysSize.small,
    inherit: true,
  );
  static const TextStyle smallWithOpacity = TextStyle(
    color: Color.fromRGBO(0xff, 0xff, 0xff, .66),
    fontWeight: FontWeight.normal,
    fontSize: SysSize.small,
    inherit: true,
  );
}

class ColorPlate {
  // 配色
  static const Color orange = Color(0xffFFC459);
  static const Color yellow = Color(0xffF1E300);
  static const Color green = Color(0xff7ED321);
  static const Color red = Color(0xffEB3838);
  static const Color darkGray = Color(0xff4A4A4A);
  static const Color gray = Color(0xff9b9b9b);
  static const Color lightGray = Color(0xfff5f5f4);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color clear = Color(0);

  /// 深色背景
  static const Color back1 = Color(0xff1D1F22);

  /// 比深色背景略深一点
  static const Color back2 = Color(0xff121314);
}

// buildAppBarTheme()=>AppBarTheme(
//   backgroundColor: Color(0xFFF7F7F7),
//   titleTextStyle: TextStyle(
//     fontSize: 16.sp,
//     color: PageStyle.c_333333,
//   ),
//   centerTitle: true,
//   elevation: 0,
// );