class CommentModel {
  int? err;
  String? msg;
  CommentExtModel? ext;

  CommentModel({this.err, this.msg, this.ext});
  CommentModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    ext = json['ext'] != null ? CommentExtModel.fromJson(json['ext']) : null;
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
class CommentExtModel {
  List<CommentExtListModel>? list;
  int? pageSize;
  int? page;
  int? pageCount;

  CommentExtModel({this.list, this.pageSize, this.page, this.pageCount});
  CommentExtModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CommentExtListModel>[];
      json['list'].forEach((v) {
        list!.add(CommentExtListModel.fromJson(v));
      });
    }
    pageSize = json['pageSize'];
    page = json['page'];
    pageCount = json['pageCount'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((e) => e.toJson()).toList();
    }
    data['pageSize'] = pageSize;
    data['page'] = page;
    data['pageCount'] = pageCount;
    return data;
  }
}
class CommentExtListModel {
  String? id;
  String? avatar;
  String? content;
  int? ups;
  int? time;

  CommentExtListModel({this.id, this.avatar, this.content, this.ups, this.time});
  CommentExtListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    content = json['content'];
    ups = json['ups'];
    time = json['time'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['content'] = content;
    data['ups'] = ups;
    data['time'] = time;
    return data;
  }
}