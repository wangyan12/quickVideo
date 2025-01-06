
class GuessModel {
  int? err;
  String? msg;
  GuessExtModel? ext;

  GuessModel({this.err, this.msg, this.ext});
  GuessModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    ext = json['ext'] != null ? GuessExtModel.fromJson(json['ext']) : null;
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
class GuessExtModel {
  String? layout;
  List<GuessExtVodListModel>? vodList;
  int? pageSize;
  int? page;
  int? pageCount;
  dynamic ad;

  GuessExtModel({this.layout, this.vodList, this.pageSize, this.page, this.pageCount, this.ad,});
  GuessExtModel.fromJson(Map<String, dynamic> json) {
    layout = json['layout'];
    if (json['vodList'] != null) {
      vodList = <GuessExtVodListModel>[];
      json['vodList'].forEach((v) {
        vodList!.add(GuessExtVodListModel.fromJson(v));
      });
    }
    pageSize = json['pageSize'];
    page = json['page'];
    pageCount = json['pageCount'];
    ad = json['ad'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['layout'] = layout;
    if (vodList != null) {
      data['vodList'] = vodList!.map((e) => e.toJson()).toList();
    }
    data['pageSize'] = pageSize;
    data['page'] = page;
    data['pageCount'] = pageCount;
    data['ad'] = ad;
    return data;
  }
}
class GuessExtVodListModel {
  String? type;
  String? title;
  String? cover;
  int? isVert;
  int? time;
  int? hot;
  String? param;

  GuessExtVodListModel({this.type, this.title, this.cover, this.isVert, this.time, this.hot, this.param});
  GuessExtVodListModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    cover = json['cover'];
    isVert = json['isVert'];
    time = json['time'];
    hot = json['hot'];
    param = json['param'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['cover'] = cover;
    data['isVert'] = isVert;
    data['time'] = time;
    data['hot'] = hot;
    data['param'] = param;
    return data;
  }
}