class DetailModel {
  int? err;
  String? msg;
  DetailExtModel? ext;

  DetailModel({this.err, this.msg, this.ext});
  DetailModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    ext = json['ext'] != null ? DetailExtModel.fromJson(json['ext']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['err'] = err;
    data['msg'] = msg;
    if (ext != null) {
      data['ext'] = ext!.toJson();
    }
    return data;
  }
}
class DetailExtModel {
  String? id;
  String? title;
  String? poster;
  int? playDef;
  List<DetailExtPlayUrlsModel>? playUrls;
  String? content;
  String? time;
  String? clicks;
  int? ups;
  int? shares;
  int? comments;
  String? uid;
  int? isvert;
  String? auth;
  String? downApp;

  DetailExtModel({
    this.id,
    this.title,
    this.poster,
    this.playDef,
    this.playUrls,
    this.content,
    this.time,
    this.clicks,
    this.ups,
    this.shares,
    this.comments,
    this.uid,
    this.isvert,
    this.auth,
    this.downApp
  });
  DetailExtModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    poster = json['poster'];
    playDef = json['playDef'];
    // playUrls = json['playUrls'];
    if (json['playUrls'] != null) {
      playUrls = <DetailExtPlayUrlsModel>[];
      json['playUrls'].forEach((v) {
        playUrls!.add(DetailExtPlayUrlsModel.fromJson(v));
      });
    }
    content = json['content'];
    time = json['time'];
    clicks = json['clicks'];
    ups = json['ups'];
    shares = json['shares'];
    comments = json['comments'];
    uid = json['uid'];
    isvert = json['isvert'];
    auth = json['auth'];
    downApp = json['downApp'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['poster'] = poster;
    data['playDef'] = playDef;
    if (playUrls != null) {
      data['playUrls'] = playUrls!.map((e) => e.toJson()).toList();
    }
    data['content'] = content;
    data['time'] = time;
    data['clicks'] = clicks;
    data['ups'] = ups;
    data['shares'] = shares;
    data['comments'] = comments;
    data['uid'] = uid;
    data['isvert'] = isvert;
    data['auth'] = auth;
    data['downApp'] = downApp;
    return data;
  }
}
class DetailExtPlayUrlsModel {
  String? title;
  String? url;

  DetailExtPlayUrlsModel({this.title, this.url});
  DetailExtPlayUrlsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['url'] = url;
    return data;
  }
}