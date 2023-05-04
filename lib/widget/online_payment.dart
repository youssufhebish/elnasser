import 'dart:async';
import 'dart:io';

import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/post_order_result.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnlinePayment extends StatefulWidget {
  const OnlinePayment({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<OnlinePayment> createState() => _OnlinePaymentState();
}

class _OnlinePaymentState extends State<OnlinePayment> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  String? orderId;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            body: WebView(
          initialUrl: '${widget.url}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          // javascriptChannels: <JavascriptChannel>{
          //   _toasterJavascriptChannel(context),
          // },
          // navigationDelegate: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     print('blocking navigation to $request}');
          //     return NavigationDecision.prevent;
          //   }
          //   print('allowing navigation to $request');
          //   return NavigationDecision.navigate;
          // },
          onPageStarted: (String url) {
            if (url.contains("orderId=")) {
              url.split("orderId=").last.split("&").first;
              print(url.split("orderId="));
              print(url.split("orderId=").last.split("&").first);
              orderId = url.split("orderId=").last.split("&").first;
              print("/$orderId\/");
            }
            if (url.contains("paymentResult/0")) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostOrderResult(
                            colorsValue: SplashCubit.get(context)
                                .theInitialModel
                                .data!
                                .account!
                                .mobileAppColors!,
                            success: false,
                            orderId: orderId!,
                          )));
            } else if (url.contains("paymentResult/1")) {
              {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostOrderResult(
                              colorsValue: SplashCubit.get(context)
                                  .theInitialModel
                                  .data!
                                  .account!
                                  .mobileAppColors!,
                              success: true,
                            )));
              }
            }
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        )),
      ),
    );
  }
}
