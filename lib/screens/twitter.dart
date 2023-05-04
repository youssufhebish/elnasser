import 'dart:async';

import 'package:elnasser/services/google_service/twiter_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oauth1/oauth1.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TwitterLoginScreen extends StatefulWidget {
  final twitterPlatform = Platform(
    'https://api.twitter.com/oauth/request_token', // temporary credentials request
    'https://api.twitter.com/oauth/authorize', // resource owner authorization
    'https://api.twitter.com/oauth/access_token', // token credentials request
    SignatureMethods.hmacSha1, // signature method
  );

  final ClientCredentials clientCredentials;
  final String oauthCallbackHandler;

  TwitterLoginScreen({
    required final String consumerKey,
    required final String consumerSecret,
    required this.oauthCallbackHandler,
  }) : clientCredentials = ClientCredentials(consumerKey, consumerSecret);

  @override
  _TwitterLoginScreenState createState() => _TwitterLoginScreenState();
}

class _TwitterLoginScreenState extends State<TwitterLoginScreen> {
  Authorization? _oauth;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();

    // Initialize Twitter OAuth
    _oauth = Authorization(widget.clientCredentials, widget.twitterPlatform);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _twitterLogInStart(WebViewController webViewController) async {
    print(SignatureMethods.hmacSha1);
    assert(null != _oauth);
    // Step 1 - Request Token
    final requestTokenResponse = await _oauth!.requestTemporaryCredentials(widget.oauthCallbackHandler);
    // Step 2 - Redirect to Authorization Page
    final authorizationPage = _oauth!.getResourceOwnerAuthorizationURI(requestTokenResponse.credentials.token);
    webViewController.loadUrl(authorizationPage);
  }

  Future<void> _twitterLogInFinish(String oauthToken, String oauthVerifier) async {
    // Step 3 - Request Access Token
    final tokenCredentialsResponse = await _oauth!.requestTokenCredentials(Credentials(oauthToken, ''), oauthVerifier);

    final result = TwitterAuthProvider.credential(
      accessToken: tokenCredentialsResponse.credentials.token,
      secret: tokenCredentialsResponse.credentials.tokenSecret,
    );

    print('************************************************************');
    print(result.accessToken);
    print(result.idToken);
    print(result.secret);
    print(SignatureMethods.hmacSha1.name);

    TwitterService().signInWithTwitter(context: context, accessToken: result.accessToken!, secret: result.secret!);
    print('************************************************************');

    // Navigator.pop(context, result);
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: WebView(
          initialUrl: 'https://twitter.com',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            _twitterLogInStart(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            if (url.startsWith(widget.oauthCallbackHandler)) {
              final queryParameters = Uri.parse(url).queryParameters;
              final oauthToken = queryParameters['oauth_token'];
              final oauthVerifier = queryParameters['oauth_verifier'];
              if (null != oauthToken && null != oauthVerifier) {
                _twitterLogInFinish(oauthToken, oauthVerifier);
              }
            }
          },
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
}
