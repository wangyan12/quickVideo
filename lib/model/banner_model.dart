
class BannerModel {
  int? err;
  String? msg;

  List<BannerExtModel>? ext;

  BannerModel({
    this.err,
    this.msg,
    this.ext,
  });
  BannerModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['ext'] != null) {
      ext = <BannerExtModel>[];
      json['ext'].forEach((v) {
        ext!.add(BannerExtModel.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['err'] = err;
    data['msg'] = msg;
    if (ext != null) {
      data['ext'] = ext!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class BannerExtModel {
  String? cover;
  String? type;
  String? param;
  String? title;

  BannerExtModel({
    this.cover,
    this.type,
    this.param,
    this.title,
  });

  BannerExtModel.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    type = json['type'];
    param = json['param'];
    title = json['title'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cover'] = cover;
    data['type'] = type;
    data['param'] = param;
    data['title'] = title;
    return data;
  }
}