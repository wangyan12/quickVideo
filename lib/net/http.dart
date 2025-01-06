import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shipin/net/http_options.dart';
import 'package:shipin/storage.dart';


class HttpUtil {
  // Dio dio = Dio();
  Dio? dio;

  static const String TYPE_GET = "get";
  static const String TYPE_POST = "post";
  static const String TYPE_UP  = "type_up";
  static const String TYPE_DOWNLOAD = 'type_download';

  static HttpUtil get instance => _getInstance();
  static HttpUtil? _instance;

  factory HttpUtil() => _getInstance();
  // 初始化
  HttpUtil._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        // baseUrll: HttpOptions.BASE_URL,
        connectTimeout: HttpOptions.CONNECT_TIMEOUT,
        receiveTimeout: HttpOptions.RECEIVE_TIMEOUT,
        headers: {},
        contentType: "multipart/form-data",
      );

      dio = Dio(options);
    }
  }

  /// 单例模式
  static HttpUtil _getInstance() {
    _instance ??= HttpUtil._internal();

    return _instance!;
  }

//get方法返回一个map的future类型
  Future get(String url, {Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context, String? userAgent,}) async {
    return _request(url, TYPE_GET, data: data, context: context, headers: headers, userAgent: userAgent);
  }

  //post方法
  Future post(String url, {Map<String, dynamic>? data, Map<String, dynamic>? headers, BuildContext? context, String? sign, String? auth, String? contentType, String? userAgent,}) async {
    return _request(url, TYPE_POST, data: data, context: context, headers: headers, sign: sign, auth: auth, contentType: contentType, userAgent: userAgent);
  }
  Future download(
      String url,
      {Map<String, dynamic>? data,
        BuildContext? context,
        Function(int count, int total)? progressCallback,
        savePath
      }) {
    return _request(
      url,
      TYPE_DOWNLOAD,
      context: context,
      progressCallback: progressCallback,
      savePath: savePath,
    );
  }

  /// 发起请求
  Future _request(
      String url,
      String type, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? headers,
        FormData? formData,
        BuildContext? context,
        String? sign,
        Function(int count, int total)? progressCallback,
        savePath,
        String? auth,
        String? contentType,
        String? userAgent,
      }) async {
    try {
      Response? response;
      // debugPrint('=======-------- headers = $headers,  ${dio!.options.headers}');
      // debugPrint('=======--------   ${StorageUtil().whetherToLogin()}');

      // if (headers != null) {
      //   dio!.options.headers['User-Agent'] = headers['User-Agent'];
      //   dio!.options.headers['content-type'] = 'text/plain';
      // } else {
      //   dio!.options.headers.remove('User-Agent');
      //   dio!.options.headers['content-type'] = 'multipart/form-data';
      // }
      if (contentType != null) {
        dio!.options.headers['Content-Type'] = contentType;
      } else {
        dio!.options.headers['Content-Type'] = 'multipart/form-data';
      }
      if (userAgent != null) {
        dio!.options.headers['User-Agent'] = userAgent;
      } else {
        dio!.options.headers.remove('User-Agent');
      }

      if (auth != null) {
        dio!.options.headers['cookie'] = 'auth=${Uri.encodeComponent(auth)}';
      } else if (StorageUtil().whetherToLogin()) {
        dio!.options.headers['cookie'] = 'auth=${Uri.encodeComponent(StorageUtil().getString(StorageUtil.userAuth))}'; // ${StorageUtil().getString(StorageUtil.userAuth)}
      } else {
        dio!.options.headers.remove('cookie');
      }
      // debugPrint('=======--------  headers = ${dio!.options.headers}');
      data ??= <String, dynamic>{};

      debugPrint("http参数开始：");
      debugPrint(url);
      debugPrint("$data");
      if (type == TYPE_GET) {
        response = await dio!.get(url, queryParameters: data, onReceiveProgress: (int count, int total) {
          debugPrint('++++++----*****++++++++--------- count = $count, total = $total');
        });
      } else if (type == TYPE_POST) {
        var aa = FormData.fromMap(data);
        response = await dio!.post(url, data: aa);
      } else if(type == TYPE_UP) {
        response = await dio!.post(url, data: formData);
      } else if (type == TYPE_DOWNLOAD) {
        response = await dio!.download(
          url,
          savePath,
          onReceiveProgress: (count, total) {
            progressCallback!.call(count, total);
          },
        );
      }

      debugPrint("$response");
      // debugPrint("http参数结束：1 ${response!.statusCode}");
      // debugPrint("http参数结束：2 ${response.data}");
      // debugPrint("http参数结束：3 ${response.headers}");
      // debugPrint("http参数结束：4 ${response.requestOptions}");
      // debugPrint("http参数结束：5 ${response.statusMessage}");
      // debugPrint("http参数结束：6 ${response.extra}");
      // debugPrint("http参数结束：7 ${response.redirects}");
      // debugPrint("http参数结束：8 ${response.isRedirect}");
      // debugPrint("http参数结束：9 ${response.toString()}");
      if (type == TYPE_DOWNLOAD) {
        return response;
      } else {
        if (response!.statusCode != 200) {
          var errorMsg = "网络请求错误，状态码:${response.statusCode}";
          debugPrint(errorMsg);
          return Future.error(errorMsg);
        } else {
          //后面这部分可以根据业务更为具体的封装了一个统一的返回json的处理
          int code = response.data['err'];
          String message = response.data['msg'].toString();
          if (code == 999) {
            // CacheUtil.remove("authModel");
            // jump(context, "hongtang://wechat_login");
            return Future.error(response.data['msg'].toString());
          }
          if (code == 0 || code == 1) {
            debugPrint("接口请求完成");
            return response.data;
          }
          debugPrint("接口请求失败");
          return Future.error(message);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
}



// // http 请求单例类
// class HttpRequest {
//   // 工厂构造方法
//   factory HttpRequest() => _instance;
//
//   // 初始化一个单例实例
//   static final HttpRequest _instance = HttpRequest._internal();
//
//   // dio 实例
//   Dio dio;
//
//   // 内部构造方法
//   HttpRequest._internal() {
//     if (dio == null) {
//       // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
//       BaseOptions baseOptions = BaseOptions(
//         baseUrl: HttpOptions.BASE_URL,
//         connectTimeout: HttpOptions.CONNECT_TIMEOUT,
//         receiveTimeout: HttpOptions.RECEIVE_TIMEOUT,
//         headers: {},
//
//         /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
//         /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
//         /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
//         /// 就会自动编码请求体.
//         contentType: "application/json; charset=utf-8",
//       );
//       // 没有实例 则创建之
//       dio = Dio(baseOptions);
//       // // 添加拦截器
//       // dio.interceptors.add(HttpInterceptor());
//     }
//
//     // if (!Global.isRelease && HttpOptions.OPEN_LOG) {
//     //   // 添加log拦截器
//     //   dio.interceptors
//     //   // .add(LogInterceptor(responseHeader: false, responseBody: true));
//     //       .add(MyLogInterceptor());
//     // }
//     //
//     // // 在调试模式下抓包调试、使用代理
//     // if (!Global.isRelease && PROXY_ENABLE) {
//     //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//     //       (client) {
//     //     client.findProxy = (uri) {
//     //       return "PROXY $PROXY_IP:$PROXY_PORT";
//     //     };
//     //     //代理工具会提供一个抓包的自签名证书，避免证书校验
//     //     client.badCertificateCallback =
//     //         (X509Certificate cert, String host, int port) => true;
//     //
//     //     return client;
//     //   };
//     // }
//   }
//
//   /// 初始化公共属性 如果需要覆盖原配置项 就调用它
//   ///
//   /// [baseUrl] 地址前缀
//   /// [connectTimeout] 连接超时赶时间
//   /// [receiveTimeout] 接收超时赶时间
//   /// [headers] 请求头
//   /// [interceptors] 基础拦截器
//   void init({
//     String baseUrl,
//     int connectTimeout,
//     int receiveTimeout,
//     Map<String, dynamic> headers,
//     List<Interceptor> interceptors,
//   }) {
//     dio.options.baseUrl = baseUrl;
//     dio.options.connectTimeout = connectTimeout;
//     dio.options.receiveTimeout = receiveTimeout;
//     dio.options.headers = headers;
//     if (interceptors != null && interceptors.isNotEmpty) {
//       dio.interceptors..addAll(interceptors);
//     }
//   }
//
//   /// 设置请求头
//   void setHeaders(Map<String, dynamic> headers) {
//     dio.options.headers.addAll(headers);
//   }
//
//   CancelToken _cancelToken = new CancelToken();
//
//   /*
//    * 取消请求
//    *
//    * 同一个cancel token 可以用于多个请求
//    * 当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
//    * 所以参数可选
//    */
//   void cancelRequests({CancelToken token}) {
//     token ?? _cancelToken.cancel("cancelled");
//   }
//
//   /// 设置鉴权请求头
//   Options setAuthorizationHeader(Options requestOptions) {
//     String _token = Global.profile?.token;
//     if (_token != null) {
//       requestOptions.headers == null ? requestOptions.headers = {
//         "token": _token,
//       } : requestOptions.headers['token'] = _token;
//     }
//     return requestOptions;
//   }
//
//   /// restful get 操作
//   Future get(
//       String path, {
//         @required BuildContext context,
//         dynamic params,
//         Options options,
//         bool displayError,
//         bool isAutoCloseLoading,
//         CancelToken cancelToken,
//       }) async {
//     Options requestOptions = setAuthorizationHeader(options ?? Options());
//
//     requestOptions.extra = {
//       "context": context,
//       "displayError": displayError,
//       "isAutoCloseLoading": isAutoCloseLoading,
//     };
//
//     Response response = await dio.get(
//       path,
//       queryParameters: params,
//       options: requestOptions,
//       cancelToken: cancelToken ?? _cancelToken,
//     );
//     return authFail(context, response);
//   }
//
//   /// restful post 操作
//   Future post(
//       String path, {
//         @required BuildContext context,
//         dynamic data,
//         Options options,
//         bool displayError,
//         bool isAutoCloseLoading,
//         CancelToken cancelToken,
//       }) async {
//     Options requestOptions = setAuthorizationHeader(options ?? Options());
//
//     requestOptions.extra = {
//       "context": context,
//       "displayError": displayError,
//       "isAutoCloseLoading": isAutoCloseLoading,
//     };
//
//     Response response = await dio.post(
//       path,
//       data: data,
//       options: requestOptions,
//       cancelToken: cancelToken ?? _cancelToken,
//     );
//
//     return authFail(context, response);
//   }
//
//   /// restful post form 表单提交操作
//   Future postForm(
//       String path, {
//         @required BuildContext context,
//         Map<String, dynamic> params,
//         Options options,
//         bool displayError,
//         bool isAutoCloseLoading = true,
//         CancelToken cancelToken,
//       }) async {
//     Options requestOptions = setAuthorizationHeader(options ?? Options());
//
//     requestOptions.extra = {
//       "context": context,
//       "displayError": displayError,
//       "isAutoCloseLoading": isAutoCloseLoading,
//     };
//
//     Response response = await dio.post(
//       path,
//       data: FormData.fromMap(params),
//       options: requestOptions,
//       cancelToken: cancelToken ?? _cancelToken,
//     );
//     return authFail(context, response);
//   }
// }
//
// // 登录失效的操作
// authFail(context, response) async {
//   switch (response.data['code']) {
//     case 4001:
//     // 请先登录
//       eventBus.fire(
//         ResponseShow('fail'),
//       );
//       dynamic refresh = await logout(context);
//       if (refresh == true) {
//         eventBus.fire(
//           AfterLoginRefresh(true),
//         );
//       }
//       break;
//     default:
//       return response.data;
//   }
// }