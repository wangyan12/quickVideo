class UserVipModel {
  int? err;
  String? msg;
  UserVipExtModel? ext;

  UserVipModel({this.err, this.msg, this.ext});
  UserVipModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    ext = json['ext'] != null ? UserVipExtModel.fromJson(json['ext']) : null;
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
class UserVipExtModel {
  List<UserVipExtListModel>? list;

  UserVipExtModel({this.list});
  UserVipExtModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <UserVipExtListModel>[];
      json['list'].forEach((v) {
        list!.add(UserVipExtListModel.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
class UserVipExtListModel {
  String? name;
  String? tip;
  String? id;
  String? icon;
  List<UserVipExtListListModel>? list;
  UserVipExtListModel({this.name, this.tip, this.id, this.icon});
  UserVipExtListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tip = json['tip'];
    id = json['id'];
    icon = json['icon'];
    if (json['list'] != null) {
      list = <UserVipExtListListModel>[];
      json['list'].forEach((v) {
        list!.add(UserVipExtListListModel.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['tip'] = tip;
    data['id'] = id;
    data['icon'] = icon;
    if (list != null) {
      data['list'] = list!.map((e) => e.toJson()).toList();
    }
    return data;
  }

}
class UserVipExtListListModel {
  String? type;
  String? name;
  String? badge;
  int? money;
  int? org;
  int? id;
  int? day;
  List<String>? tips;
  UserVipExtListListModel({this.type, this.name, this.badge, this.money, this.org, this.id, this.day, this.tips,});

  UserVipExtListListModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    badge = json['badge'];
    money = json['money'];
    org = json['org'];
    id = json['id'];
    day = json['day'];
    if (json['tips'] != null) {
      tips = <String>[];
      json['tips'].forEach((v) {
        tips!.add(v);
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['badge'] = badge;
    data['money'] = money;
    data['ory'] = org;
    data['id'] = id;
    data['day'] = day;
    if (tips != null) {
      data['tips'] = tips!.map((e) => e).toList();
    }
    return data;
  }

}

// class UserVipExtListModel {
//   String? name;
//   int? days;
//   int? credit;
//   int? vods;
//   String? desc;
//   String? id;
//   String? icon;
//
//   UserVipExtListModel({
//     this.name,
//     this.days,
//     this.credit,
//     this.vods,
//     this.desc,
//     this.id,
//     this.icon,
//   });
//   UserVipExtListModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     days = json['days'];
//     credit = json['credit'];
//     vods = json['vods'];
//     desc = json['desc'];
//     id = json['id'];
//     icon = json['icon'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['days'] = days;
//     data['credit'] = credit;
//     data['vods'] = vods;
//     data['desc'] = desc;
//     data['id'] = id;
//     data['icon'] = icon;
//     return data;
//   }
// }
