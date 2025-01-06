class UserOnlineModel {
  int? err;
  String? msg;
  UserOnlineExtModel? ext;
  UserOnlineModel({
    this.err,
    this.msg,
    this.ext,
  });
  UserOnlineModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    ext = json['ext'] != null ? UserOnlineExtModel.fromJson(json['ext']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['err'] = err;
    data['msg'] = msg;
    data['ext'] = ext != null ? ext!.toJson() : null;
    return data;
  }
}
class UserOnlineExtModel {
  String? auth;
  UserOnlineExtUserModel? user;
  int? expiretime;
  UserOnlineExtModel({
    this.auth,
    this.user,
    this.expiretime,
  });
  UserOnlineExtModel.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    user = json['user'] != null ? UserOnlineExtUserModel.fromJson(json['user']) : null;
    expiretime = json['expiretime'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth'] = auth;
    data['user'] = user != null ? user!.toJson() : null;
    data['expiretime'] = expiretime;
    return data;
  }
}
class UserOnlineExtUserModel {
  String? username;
  String? nickname;
  String? phone;
  String? credit;

  String? vip;
  String? expiretime;
  String? downloads;
  String? vods;

  String? lefts;
  String? cardid;
  int? commends;
  String? avatar;
  UserOnlineExtUserModel({
    this.username,
    this.nickname,
    this.phone,
    this.credit,
    this.vip,
    this.expiretime,
    this.downloads,
    this.vods,
    this.lefts,
    this.cardid,
    this.commends,
    this.avatar,
  });
  UserOnlineExtUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    nickname = json['nickname'];
    phone = json['phone'];
    credit = json['credit'];
    vip = json['vip'];
    expiretime = json['expiretime'];
    downloads = json['downloads'];
    vods = json['vods'];
    lefts = json['lefts'];
    cardid = json['cardid'];
    commends = json['commends'];
    avatar = json['avatar'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['nickname'] = nickname;
    data['phone'] = phone;
    data['credit'] = credit;
    data['vip'] = vip;
    data['expiretime'] = expiretime;
    data['downloads'] = downloads;
    data['vods'] = vods;
    data['lefts'] = lefts;
    data['cardid'] = cardid;
    data['commends'] = commends;
    data['avatar'] = avatar;
    return data;
  }
}