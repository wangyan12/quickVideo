class CommendModel {
  String? msg;
  int? err;
  List<CommendExtModel>? ext;

  CommendModel({this.msg, this.err, this.ext});
  CommendModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    err = json['err'];
    if (json['ext'] != null) {
      ext = <CommendExtModel>[];
      json['ext'].forEach((v) {
        ext!.add(CommendExtModel.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['err'] = err;
    if (ext != null) {
      data['ext'] = ext!.map((e) => e.toJson()).toList();
    }
    return data;
  }

}
class CommendExtModel {
  String? type;
  String? title;
  String? more;
  String? page;
  List<CommendExtTypeListModel>? typeList;

  CommendExtModel({this.type, this.title, this.more, this.page, this.typeList,});
  CommendExtModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    more = json['more'];
    page = json['page'];
    String typeListStr = '${json['type']}List';
    if (json[typeListStr] != null) {
      typeList = <CommendExtTypeListModel>[];
      json[typeListStr].forEach((v) {
        typeList!.add(CommendExtTypeListModel.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['more'] = more;
    data['page'] = page;
    if (typeList != null) {
      String typeListStr = '${type}List';
      data[typeListStr] = typeList!.map((e) => e.toJson()).toList();
    }
    return data;
  }

}

class CommendExtTypeListModel {
  String? type;
  String? title;
  String? cover;
  dynamic isvert;
  int? time;
  dynamic hot;
  String? param;

  CommendExtTypeListModel({
    this.type,
    this.title,
    this.cover,
    this.isvert,
    this.time,
    this.hot,
    this.param,
  });
  CommendExtTypeListModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    cover = json['cover'];
    isvert = json['isvert'];
    time = json['time'];
    hot = json['hot'];
    param = json['param'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['cover'] = cover;
    data['isvert'] = isvert;
    data['time'] = time;
    data['hot'] = hot;
    data['param'] = param;
    return data;
  }
}