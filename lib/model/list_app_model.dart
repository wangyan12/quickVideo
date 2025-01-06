class ListAppModel {
  int? err;
  String? msg;
  ListAppExtModel? ext;
  ListAppModel({
    this.err,
    this.msg,
    this.ext,
  });
  ListAppModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['ext'] != null) {
      ext = ListAppExtModel.formJson(json['ext']);
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
class ListAppExtModel{
  String? layout;
  List<ListAppExtAppListModel>? appList;
  int? pageSize;
  int? page;
  int? pageCount;
  ListAppExtModel({
    this.layout,
    this.appList,
    this.pageSize,
    this.page,
    this.pageCount,
  });
  ListAppExtModel.formJson(Map<String, dynamic> json) {
    layout = json['layout'];
    if (json['appList'] != null) {
      appList = <ListAppExtAppListModel>[];
      json['appList'].forEach((v) {
        appList!.add(ListAppExtAppListModel.fromJson(v));
      });
    }
    pageSize = json['pageSize'];
    page = json['page'];
    pageCount = json['pageCount'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['layout'] = layout;
    if (appList != null) {
      data['appList'] = appList!.map((e) => e.toJson()).toList();
    }
    data['pageSize'] = pageSize;
    data['page'] = page;
    data['pageCount'] = pageCount;
    return data;
  }
}
class ListAppExtAppListModel {
  String? icon;
  String? title;
  String? time;
  String? hot;
  String? intro;
  String? ios;
  String? android;
  ListAppExtAppListModel({
    this.icon,
    this.title,
    this.time,
    this.hot,
    this.intro,
    this.ios,
    this.android,
  });
  ListAppExtAppListModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    time = json['time'];
    hot = json['hot'];
    intro = json['intro'];
    ios = json['ios'];
    android = json['android'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['title'] = title;
    data['time'] = time;
    data['hot'] = hot;
    data['intro'] = intro;
    data['ios'] = ios;
    data['android'] = android;
    return data;
  }
}