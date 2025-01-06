import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.urlStr}) : super(key: key);
  final String urlStr;

  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }
}
class WebViewPageState extends State<WebViewPage> {
  // final Completer<WebViewController> _controller = Completer<WebViewController>();
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    /// android 支持HybridComposition
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );


  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '支付信息',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.translucent,
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/icon_return.png',
              color: Colors.black,
              width: 23.w,
              height: 23.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      // body: WebView(
      //   initialUrl: widget.urlStr,  // 'http://119.3.58.86:9527',  //widget.urlStr,  // 'https://www.baidu.com',  //  'http://23.225.160.21/',  //
      //   javascriptMode: JavascriptMode.unrestricted,
      //   onWebViewCreated: (WebViewController webViewController) {
      //     _controller.complete(webViewController);
      //   },
      //   onProgress: (int progress) {
      //     debugPrint('WebView is loading (progress : $progress%)');
      //   },
      //   javascriptChannels: <JavascriptChannel>{
      //     _toasterJavascriptChannel(context),
      //   },
      //   navigationDelegate: (NavigationRequest request) {
      //     if (request.url.startsWith('https://www.youtube.com/')) {
      //       debugPrint('blocking navigation to $request}');
      //       return NavigationDecision.prevent;
      //     }
      //     debugPrint('allowing navigation to $request');
      //     return NavigationDecision.navigate;
      //   },
      //   onPageStarted: (String url) {
      //     debugPrint('Page started loading: $url');
      //   },
      //   onPageFinished: (String url) {
      //     debugPrint('Page finished loading: $url');
      //   },
      //   gestureNavigationEnabled: true,
      // ),

      body: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(url: Uri.parse(widget.urlStr)),
        initialOptions: options,
      ),
    );
  }

  // JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  //   return JavascriptChannel(
  //     name: 'Toaster',
  //     onMessageReceived: (JavascriptMessage message) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(message.message)),
  //       );
  //     },
  //   );
  // }

}
