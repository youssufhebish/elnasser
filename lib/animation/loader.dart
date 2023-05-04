import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader {


//  static showLoader(context) {
//    showDialog(
//        barrierDismissible: true,
//        context: context,
//        builder: (BuildContext context) {
//          return Dialog(
//              backgroundColor: ColorConstants.transparent,
//              child: Lottie.asset(LottieConstants.loader,
//                  width: MediaQuery.of(context).size.width / 2));
//        });
//  }

  static Future<void> showLoader(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Center(
                      child: Lottie.asset("animations/loader.json",
                          width: MediaQuery.of(context).size.width / 8),
                    )
                  ]));
        });
  }

  static hideLoader(context) {
    Navigator.pop(context);
  }
}
