class CateModel {
  int? err;
  String? msg;
  List<CateExtModel>? ext;

  CateModel({this.err, this.msg, this.ext});
  CateModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['ext'] != null) {
      ext = <CateExtModel>[];
      json['ext'].forEach((v) {
        ext!.add(CateExtModel.fromJson(v));
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
class CateExtModel {
  String? type;
  String? name;
  String? cid;
  String? isVert;
  int? isHide;

  CateExtModel({this.type, this.name, this.cid, this.isVert, this.isHide,});
  CateExtModel.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? '';
    name = json['name'] ?? '';
    cid = json['cid'] ?? '';
    isVert = json['isvert'] ?? 0;
    isHide = json['ishide'] ?? 0;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['cid'] = cid;
    data['isvert'] = isVert;
    data['ishide'] = isHide;
    return data;
  }
}