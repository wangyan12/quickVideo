class ListModel {
  int? err;
  String? msg;
  ListExtModel? ext;
  ListModel({this.err, this.msg, this.ext});
  ListModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['ext'] != null) {
      ext = ListExtModel.fromJson(json['ext']);
    }
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
class ListExtModel {
  String? layout;
  List<ListExtVodListModel>? vodList;
  int? pageSize;
  int? page;
  int? pageCount;
  ListExtModel({this.layout, this.vodList, this.pageSize, this.page, this.pageCount});
  ListExtModel.fromJson(Map<String, dynamic> json) {
    layout = json['layout'];
    if (json['vodList'] != null) {
      vodList = <ListExtVodListModel>[];
      json['vodList'].forEach((v) {
        vodList!.add(ListExtVodListModel.fromJson(v));
      });
    }
    pageSize = json['pageSize'];
    page = json['page'];
    pageCount = json['pageCount'];
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
    return data;
  }

}
class ListExtVodListModel {
  String? type;
  String? title;
  String? cover;
  int? isVert;
  int? time;
  int? hot;
  String? param;

  ListExtVodListModel({this.type, this.title, this.cover, this.isVert, this.time, this.hot, this.param});
  ListExtVodListModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    cover = json['cover'];
    isVert = json['isvert'];
    time = json['time'];
    hot = json['hot'];
    param = json['param'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['cover'] = cover;
    data['isvert'] = isVert;
    data['time'] = time;
    data['hot'] = hot;
    data['param'] = param;
    return data;
  }
}