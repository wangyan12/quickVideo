class VideoApi {
  static const testUrl = 'http://23.224.93.3/';  // 'http://192.151.194.22/';  // 'http://23.224.136.22/';  //
  static const formalUrl = '';


  static const sign     = '${testUrl}api/v1/sign/';  // 测试签名接口
  static const boot     = '${testUrl}api/v1/boot/';  // 启动参数
  static const banner   = '${testUrl}api/v1/index/banner/';  // 首页横幅列表
  static const commend  = '${testUrl}api/v1/index/commend/';  // 首页推荐列表
  static const cate     = '${testUrl}api/v1/index/cate/';  // 读取分类
  static const list     = '${testUrl}api/v1/index/list/';  // 分类数据列表
  static const detail   = '${testUrl}api/v1/detail/';  // 内容详情获取 api/v1/detail/:type/:id
  static const comment  = '${testUrl}api/v1/comment/';  // 内容评论列表 api/v1/comment/:type/:id
  static const guess    = '${testUrl}api/v1/index/guess/';  // 猜你喜欢

  static const register = '${testUrl}api/v1/user/register/';  // 用户注册
  static const login    = '${testUrl}api/v1/user/login/';  // 用户登录
  static const online   = '${testUrl}api/v1/user/online/';  // 用户在线
  static const pass     = '${testUrl}api/v1/user/pass/';  // 用户修改密码
  static const nickname = '${testUrl}api/v1/user/nickname/';  // 用户修改昵称
  static const phone    = '${testUrl}api/v1/user/phone/';  // 用户修改手机
  static const fav      = '${testUrl}api/v1/user/fav/';  // 用户收藏列表
  static const fav_add  = '${testUrl}api/v1/user/fav_add/';  // 用户添加收藏
  static const fav_exist = '${testUrl}api/v1/user/fav_exist/';  // 用户检测是否收藏
  static const fav_del  = '${testUrl}api/v1/user/fav_del/';  // 用户删除收藏 这个是集体删除  ids=id1,id2,id3
  static const fav_do = '${testUrl}api/v1/user/fav_do/';     // 删除收藏

  static const userSign = '${testUrl}api/v1/user/sign/';  // 用户签到
  static const userVip  = '${testUrl}api/v1/user/vip/';  // 用户兑换列表
  static const userVipOrder = '${testUrl}api/v1/user/vip_order/';  // 下单信息
  static const userVipQuery = '${testUrl}api/v1/user/vip_query/';  // 获取支付结果
  static const vipBuy   = '${testUrl}api/v1/user/vip_buy/';  // 用户兑换物品
  static const share    = '${testUrl}api/v1/user/share/';  // 用户分享
  static const share_succ = '${testUrl}api/v1/user/share_succ/';  // 用户分享成功
  static const share_doc = '${testUrl}api/v1/user/share_doc/';  // 用户分享说明接口(webview)

  static const indexShort = '${testUrl}api/v1/index/short/';    // 发现接口
  static const csrfToken = '${testUrl}__csrf'; // 'http://23.224.136.22/__csrf';   // 获取token   __csrf?key=随机8位长度的字符
  static const luaApiUp = '${testUrl}lua/api-up';  // 点赞
  static const commentVod = '${testUrl}api/v1/comment/vod/';  // 评论列表
  static const userCommentAdd = '${testUrl}api/v1/user/comment_add/';  // 发表评论


}