// 请求配置
class HttpOptions {
  // 连接服务器超时时间，单位是毫秒
  static const int CONNECT_TIMEOUT = 30000;
  // 接收超时时间，单位是毫秒
  static const int RECEIVE_TIMEOUT = 300000;
  // 地址前缀
  static const String BASE_URL = 'http://222.186.46.198';
  // static const String BASE_URL = 'https://www.lincoln1818.com/u-api';

  // log打印
  static const bool OPEN_LOG = true;
}
