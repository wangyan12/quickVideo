class ShareSuccModel {
  int? err;
  String? msg;
  List? ext;

  ShareSuccModel({this.err, this.msg, this.ext});
  ShareSuccModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    ext = [];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['err'] = err;
    data['msg'] = msg;
    if (ext != null) {
      data['ext'] = [];
    }
    return data;
  }
}