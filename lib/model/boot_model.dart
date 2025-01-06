
class BootModel {
  int? err;
  String? msg;
  BootExtModel? ext;

  BootModel({
    this.err,
    this.msg,
    this.ext,
  });

  BootModel.fromJson(Map<String, dynamic> json) {
    err = json['err'] ?? 0;
    msg = json['msg'] ?? '';
    ext = json['ext'] != null ? BootExtModel.fromJson(json['ext']) : null;
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

class BootExtModel {
  BootExtIosAndroidModel? ios;
  BootExtIosAndroidModel? android;
  BootExtIosAndroidModel? dy;
  // List post;
  BootExtModel({
    this.ios,
    this.android,
    this.dy,
  });

  BootExtModel.fromJson(Map<String, dynamic> json) {
    ios = json['ios'] != null ? BootExtIosAndroidModel.fromJson(json['ios']) : null;
    android = json['android'] != null ? BootExtIosAndroidModel.fromJson(json['android']) : null;
    dy = json['dy'] != null ? BootExtIosAndroidModel.fromJson(json['dy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (ios != null) {
      data['ios'] = ios!.toJson();
    }
    if (android != null) {
      data['android'] = android!.toJson();
    }
    if (dy != null) {
      data['dy'] = dy!.toJson();
    }
    return data;
  }
}
class BootExtIosAndroidModel {
  String? app;
  String? ver;
  String? url;
  String? lockUpdate;

  String? updateMsg;
  String? api;
  String? live;
  String? splash;

  String? splashUrl;
  String? splashTime;
  String? adv;
  String? tags;
  String? vipStatus;

  BootExtIosAndroidModel({
    this.app,
    this.ver,
    this.url,
    this.lockUpdate,
    this.updateMsg,
    this.api,
    this.live,
    this.splash,
    this.splashUrl,
    this.splashTime,
    this.adv,
    this.tags,
    this.vipStatus,
  });

  BootExtIosAndroidModel.fromJson(Map<String, dynamic> json) {
    app = json['app'] ?? '';
    ver = json['ver'] ?? '';
    url = json['url'] ?? '';
    lockUpdate = json['lockUpdate'] ?? '';

    updateMsg = json['updateMsg'] ?? '';
    api = json['api'] ?? '';
    live = json['live'] ?? '';
    splash = json['splash'] ?? '';

    splashUrl = json['splashUrl'] ?? '';
    splashTime = json['splashTime'] ?? '';
    adv = json['adv'] ?? '';
    tags = json['tags'] ?? '';
    vipStatus = json['vipStatus'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['app'] = app;
    data['ver'] = ver;
    data['url'] = url;
    data['lockUpdate'] = lockUpdate;

    data['updateMsg'] = updateMsg;
    data['api'] = api;
    data['live'] = live;
    data['splash'] = splash;

    data['splashUrl'] = splashUrl;
    data['splashTime'] = splashTime;
    data['adv'] = adv;
    data['tags'] = tags;
    data['vipStatus'] = vipStatus;

    return data;
  }

}


// {
//   err: 0,
//   msg: "",
//   ext: {
//     ios: {
//       app: "视频 APP",
//       ver: "1.2",
//       url: "http://www.runoob.com/try/demo_source/mov_bbb.mp4",
//       lockUpdate: "1.1",
//       updateMsg: "需要更新，更新内容： 1. 啊啊啊啊啊 2.啊啊啊啊啊啊",
//       api: "http://222.186.46.198/api/v1/",
//       live: "http://www.runoob.com/try/demo_source/mov_bbb.mp4",
//       splash: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2590838339,504599034&fm=200&gp=0.jpg",
//       splashUrl: "http://baidu.com/",
//       splashTime: "6",
//       adv: "您的观影体验已结束，登录观看更多高清视频。 确定"
//     },
//     android: {
//       app: "视频 APP",
//       ver: "1.2",
//       url: "http://www.runoob.com/try/demo_source/mov_bbb.mp4",
//       lockUpdate: "1.1",
//       updateMsg: "需要更新，更新内容： 1. 啊啊啊啊啊 2.啊啊啊啊啊啊",
//       api: "http://222.186.46.198/api/v1/",
//       live: "http://www.runoob.com/try/demo_source/mov_bbb.mp4",
//       splash: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2590838339,504599034&fm=200&gp=0.jpg",
//       splashUrl: "http://baidu.com/",
//       splashTime: "6",
//       adv: "test"
//     },
//     POST: [ ]
//   }
// }