import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shipin/mock/video.dart';
import 'package:shipin/model/comment_model.dart';
import 'package:shipin/model/detail_model.dart';
import 'package:shipin/net/api.dart';
import 'package:shipin/net/http.dart';

import 'package:http/http.dart' as http;

import '../model/banner_model.dart';
import '../model/boot_model.dart';
import '../model/cate_model.dart';
import '../model/commend_model.dart';
import '../model/guess_model.dart';
import '../model/list_app_model.dart';
import '../model/list_model.dart';
import '../model/user_online_model.dart';
import '../model/user_vip_model.dart';

class RepositoryAuth {


  // 测试签名接口
  static Future sign({Map<String, dynamic>? data, BuildContext? context}) async {
    // Map<String, dynamic> map = await HttpUtil().post(
    //   VideoApi.sign,
    //   context: context,
    //   data: data,
    //   headers: headers,
    //   sign: sign,
    // );
    // if (map.isNotEmpty) {
    //   return map;
    // }
    // return Future.error('接口请求失败');
    var response = await http.post(
      Uri.parse(VideoApi.sign),
      body: data,
    );
    if (response.statusCode == 200) {
      Map map = json.decode(response.body);
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 启动参数
  static Future boot({Map<String, dynamic>? data, BuildContext? context,}) async {
    // Map<String, dynamic> map = await HttpUtil().post(
    //   VideoApi.boot,
    //   context: context,
    //   data: data,
    //   headers: headers,
    //   sign: sign,
    // );
    // if (map.isNotEmpty) {
    //   return map;
    // }
    var response = await http.post(
      Uri.parse(VideoApi.boot),
      body: data,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      return BootModel.fromJson(map);
    }
    return Future.error('接口请求失败');
  }
  // 首页横幅列表
  static Future banner({Map<String, dynamic>? data, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.banner,
      context: context,
      data: data,
    );
    // debugPrint('***********-------  map = $map');
    // debugPrint('***********-------  map = ${map['ext']}');
    if (map.isNotEmpty) {
      return BannerModel.fromJson(map);
      // return map;
    }
    // var response = await http.post(
    //   Uri.parse(VideoApi.banner),
    //   body: data,
    // );
    // debugPrint('banner ********* map = ${Uri.parse(VideoApi.banner)}');
    // if (response.statusCode == 200) {
    //   Map<String, dynamic> map = json.decode(response.body);
    //   debugPrint('banner ********* map = $map');
    //   return BannerModel.fromJson(map);
    // }
    return Future.error('接口请求失败');
  }
  // 首页推荐列表
  static Future commend({Map<String, dynamic>? data, BuildContext? context}) async {
    // Map<String, dynamic> map = await HttpUtil().post(
    //   VideoApi.commend,
    //   context: context,
    //   data: data,
    //   headers: headers,
    // );
    // if (map.isNotEmpty) {
    //   return map;
    // }
    var response = await http.post(
      Uri.parse(VideoApi.commend),
      body: data,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      // debugPrint('commend ********* map = $map');
      // debugPrint('commend ********* map = ${map['ext'][0]}');
      return CommendModel.fromJson(map);
    }
    return Future.error('接口请求失败');
  }
  // 读取分类
  static Future cate({Map<String, dynamic>? data, BuildContext? context}) async {
    // Map<String, dynamic> map = await HttpUtil().post(
    //   VideoApi.cate,
    //   context: context,
    //   data: data,
    //   headers: headers,
    // );
    // if (map.isNotEmpty) {
    //   return map;
    // }
    var response = await http.post(
      Uri.parse(VideoApi.cate),
      body: data,
    );
    if (response.statusCode == 200) {
      // debugPrint('cate ********* response.body = ${response.body}');
      Map<String, dynamic> map = json.decode(response.body);
      // debugPrint('cate ********* map = $map');
      return CateModel.fromJson(map);
    }
    return Future.error('接口请求失败');
  }
  // 分类数据列表
  static Future list({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    // Map<String, dynamic> map = await HttpUtil().post(
    //   VideoApi.list,
    //   context: context,
    //   data: data,
    //   headers: headers,
    // );
    // if (map.isNotEmpty) {
    //   return map;
    // }
    debugPrint(VideoApi.list);
    var response = await http.post(
      Uri.parse(VideoApi.list),
      body: data,
    );
    if (response.statusCode == 200) {
      // debugPrint('list ********* response.body = ${response.body}');
      Map<String, dynamic> map = json.decode(response.body);
      // debugPrint('list ********* map = $map');
      return ListModel.fromJson(map);
      // return map;
    }
    return Future.error('接口请求失败');
  }
  static Future listApp({Map<String, dynamic>? data, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      '${VideoApi.list}?type=app',
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      return ListAppModel.fromJson(map);
      return map;
    }

    return Future.error('接口请求失败');
  }
  // 内容详情获取
  static Future detail({String? type, String? param, Map<String, dynamic>? data, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      '${VideoApi.detail}$type/$param/',
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      // return map;
      return DetailModel.fromJson(map);
    }

    // var response = await http.post(
    //   Uri.parse(VideoApi.detail),
    //   body: data,
    // );
    // if (response.statusCode == 200) {
    //   debugPrint('detail ********* response.body = ${response.body}');
    //   Map<String, dynamic> map = json.decode(response.body);
    //   // debugPrint('detail ********* map = $map');
    //   // return ListModel.fromJson(map);
    //   return map;
    // }
    return Future.error('接口请求失败');
  }
  // 内容评论列表
  static Future comment({String? type, String? param, Map<String, dynamic>? data, BuildContext? context, int? page, int? size,}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      '${VideoApi.comment}$type/$param/?page=$page',
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      return CommentModel.fromJson(map);
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 猜你喜欢
  static Future guess({Map<String, dynamic>? data, BuildContext? context,}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.guess,
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      return GuessModel.fromJson(map);
      return map;
    }

    // var response = await http.post(
    //   Uri.parse(VideoApi.guess),
    //   body: data,
    // );
    // if (response.statusCode == 200) {
    //   debugPrint('guess ********* response.body = ${response.body}');
    //   Map<String, dynamic> map = json.decode(response.body);
    //   // debugPrint('guess ********* map = $map');
    //   return GuessModel.fromJson(map);
    //   // return map;
    // }
    return Future.error('接口请求失败');
  }
  // 用户注册
  static Future register({Map<String, dynamic>? data, BuildContext? context, required String ua}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.register,
      context: context,
      data: data,
      headers: {
        'User-Agent': ua,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    debugPrint('+++++++++ ++++++   map = $map');
    if (map.isNotEmpty) {
      return map;
      // return GuessModel.fromJson(map);
    }
    // debugPrint('+++++++++ ${Uri.parse(VideoApi.register)},  data = $data');
    // var response = await http.post(
    //   Uri.parse('${VideoApi.register}?_deb'),
    //   body: data,
    //   headers: {
    //     'User-Agent': 'sukan/10/UUID/PackageName/PLAT/PLATV',
    //     'Content-Type': 'application/x-www-form-urlencoded',
    //   },
    // );
    // // debugPrint('register ********* response.statusCode = ${response.statusCode}');
    // // debugPrint('register ********* response.body = ${response.body}');
    // if (response.statusCode == 200) {
    //   // debugPrint('register ********* response.body = ${response.body}');
    //   Map<String, dynamic> map = json.decode(response.body);
    //   // // debugPrint('register ********* map = $map');
    //   // return GuessModel.fromJson(map);
    //   return map;
    // }
    return Future.error('接口请求失败');
  }
  // 用户登录
  static Future login({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    // Map<String, dynamic> map = await HttpUtil().post(
    //   VideoApi.login,
    //   context: context,
    //   data: data,
    //   headers: headers,
    // );
    // if (map.isNotEmpty) {
    //   return map;
    // }
    var response = await http.post(
      Uri.parse(VideoApi.login),
      body: data,
    );
    if (response.statusCode == 200) {
      debugPrint('login ********* response.body = ${response.body}');
      Map<String, dynamic> map = json.decode(response.body);
      // // debugPrint('login ********* map = $map');
      // return GuessModel.fromJson(map);
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户在线
  static Future online({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.online,
      context: context,
      data: data,
      headers: headers,
    );
    if (map.isNotEmpty) {
      return UserOnlineModel.fromJson(map);
      // return map;
    }
    return Future.error('接口请求失败');
  }
  // 获取 别人的信息
  static Future othersOnline({Map<String, dynamic>? data, BuildContext? context, String? auth}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.online,
      context: context,
      data: data,
      auth: auth,
    );
    if (map.isNotEmpty) {
      return UserOnlineModel.fromJson(map);
    }
    return Future.error('接口请求失败');
  }
  // 用户修改密码
  static Future pass({Map<String, dynamic>? data, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.pass,
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      return map;
    }
    // var response = await http.post(
    //   Uri.parse(VideoApi.pass),
    //   body: data,
    // );
    // if (response.statusCode == 200) {
    //   debugPrint('login ********* response.body = ${response.body}');
    //   Map<String, dynamic> map = json.decode(response.body);
    //   // // debugPrint('login ********* map = $map');
    //   // return GuessModel.fromJson(map);
    //   return map;
    // }
    return Future.error('接口请求失败');
  }
  // 用户修改昵称
  static Future nickname({Map<String, dynamic>? data, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.nickname,
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户修改手机
  static Future phone({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.phone,
      context: context,
      data: data,
      headers: headers,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户收藏列表
  static Future fav({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.fav,
      context: context,
      data: data,
      headers: headers,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户添加收藏
  static Future favAdd({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.fav_add,
      context: context,
      data: data,
      headers: headers,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户检测是否收藏
  static Future favExist({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.fav_exist,
      context: context,
      data: data,
      headers: headers,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户删除收藏  这个是集体删除  ids=id1,id2,id3
  static Future favDel({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.fav_del,
      context: context,
      data: data,
      headers: headers,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 删除收藏
  static Future favDo({Map<String, dynamic>? data, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.fav_do,
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户签到
  static Future userSign({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.userSign,
      context: context,
      data: data,
      headers: headers,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户兑换列表
  static Future userVip({Map<String, dynamic>? data, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.userVip,
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      debugPrint('=====----=====-----======   map = $map');
      return UserVipModel.fromJson(map);
      // return map;
    }
    return Future.error('接口请求失败');
  }
  // 下单信息
  static Future userVipOrder({Map<String, dynamic>? data, BuildContext? context, String? ua}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.userVipOrder,
      context: context,
      data: data,
      userAgent: ua,
      contentType: 'application/x-www-form-urlencoded',
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 获取支付结果
  static Future userVipQuery({Map<String, dynamic>? data, BuildContext? context, String? ua}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.userVipQuery,
      context: context,
      data: data,
      userAgent: ua,
      contentType: 'application/x-www-form-urlencoded',
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户兑换物品
  static Future vipBuy({Map<String, dynamic>? data, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.vipBuy,
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户分享
  static Future share({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.share,
      context: context,
      data: data,
      headers: headers,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户分享成功
  static Future shareSucc({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.share_succ,
      context: context,
      data: data,
      headers: headers,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 用户分享说明接口(webview)
  static Future shareDoc({Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.share_doc,
      context: context,
      data: data,
      headers: headers,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 发现接口
  static Future indexShort({Map<String, dynamic>? data, BuildContext? context}) async {
    // Map<String, dynamic> map = await HttpUtil().post(
    //   VideoApi.indexShort,
    //   context: context,
    //   data: data,
    // );
    // if (map.isNotEmpty) {
    //   return ShortModel.formJson(map['ext']);
    //   // return map;
    // }
    // return Future.error('接口请求失败');
  }

  // 获取 csrf_token
  static Future csrfToken({Map<String, dynamic>? data, BuildContext? context, required String keyStr, required String ua}) async {
    Map<String, dynamic> map = await HttpUtil().get(
      '${VideoApi.csrfToken}?key=$keyStr',
      context: context,
      // data: data,
      // headers: {
      //   'User-Agent': ua,  // 'sukan/10/UUID/PackageName/PLAT/PLATV',
      //   // 'Content-Type': 'application/x-www-form-urlencoded',
      // },
      userAgent: ua,
    );
    if (map.isNotEmpty) {
      // return ShortModel.formJson(map['ext']);
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 点赞
  static Future luaApiUp({Map<String, dynamic>? data, BuildContext? context}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      VideoApi.luaApiUp,
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      // return ShortModel.formJson(map['ext']);
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 评论列表
  static Future commentVod({Map<String, dynamic>? data, BuildContext? context, String? id, int? page, int? size}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      '${VideoApi.commentVod}$id/?page=$page&size=$size',
      context: context,
      data: data,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
  // 发表评论
  static Future userCommentAdd({Map<String, dynamic>? data, BuildContext? context, String? id, String? content,}) async {
    Map<String, dynamic> map = await HttpUtil().post(
      '${VideoApi.userCommentAdd}?id=$id&content=$content',
      data: data,
      context: context,
    );
    if (map.isNotEmpty) {
      return map;
    }
    return Future.error('接口请求失败');
  }
}