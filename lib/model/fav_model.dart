class FavModel {
  int? err;
  String? msg;
  FavExtModel? ext;

  FavModel({this.err, this.msg, this.ext});
  FavModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    ext = json['ext'] != null ? FavExtModel.fromJson(json['ext']) : null;
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
class FavExtModel {
  List<FavExtFavListModel>? favList;
  int? pageCount;

  FavExtModel({this.favList, this.pageCount});
  FavExtModel.fromJson(Map<String, dynamic> json) {
    if (json['favList'] != null) {
      favList = <FavExtFavListModel>[];
      json['favList'].forEach((v) {
        favList!.add(FavExtFavListModel.fromJson(v));
      });
    }
    pageCount = json['pageCount'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (favList != null) {
      data['favList'] = favList!.map((e) => e.toJson()).toList();
    }
    data['pageCount'] = pageCount;
    return data;
  }
}
class FavExtFavListModel {
  String? id;
  String? dateline;
  FavExtFavListVodModel? vod;

  FavExtFavListModel({this.id, this.dateline, this.vod});
  FavExtFavListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateline = json['dateline'];
    vod = json['vod'] != null ? FavExtFavListVodModel.fromJson(json['vod']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dateline'] = dateline;
    if (vod != null) {
      data['vod'] = vod!.toJson();
    }
    return data;
  }
}
class FavExtFavListVodModel {
  String? type;
  String? title;
  String? cover;
  dynamic time;
  String? hot;
  String? param;

  FavExtFavListVodModel({this.type, this.title, this.cover, this.time, this.hot, this.param});
  FavExtFavListVodModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    cover = json['cover'];
    time = json['time'];
    hot = json['hot'];
    param = json['param'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['cover'] = cover;
    data['time'] = time;
    data['hot'] = hot;
    data['param'] = param;
    return data;
  }
}