import 'package:easy_localization/easy_localization.dart';

import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NoInterNetWidget extends StatelessWidget {
  NoInterNetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Container(
                  height: 18.h,
                  width: 18.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffEBEFF0)),
                  child: Center(
                      child: ImageView(
                    path: ImageConstants.connectionError,
                    fit: BoxFit.fill,
                    width: 10.h,
                    height: 10.h,
                  )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Center(
                  child: CustomText(
                text: "connectionError".tr().toString(),
                style: TextStyleConstant.headerNoInterNetText(context),
              )),
              SizedBox(
                height: 2.h,
              ),
              Center(
                  child: CustomText(
                text: "ConnectionErrorDesc".tr().toString(),
                style: TextStyleConstant.lightNoInterNetText(context),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: AppButtonNoInterNet(
                    color: Color(0xff0060AF),
                    textStyle: TextStyleConstant.buttonTextNoInterNet(context),
                    title: "tryAgain".tr().toString(),
                    onPressed: () {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WebSiteStop extends StatelessWidget {
  const WebSiteStop({Key? key, required this.mesg}) : super(key: key);
  final String mesg;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Container(
                  height: 18.h,
                  width: 18.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffEBEFF0)),
                  child: Center(
                      child: ImageView(
                    path: ImageConstants.connectionError,
                    fit: BoxFit.fill,
                    width: 10.h,
                    height: 10.h,
                  )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // Center(child: CustomText(text:"connectionError".tr().toString(),style: TextStyleConstant.headerNoInterNetText(context),)),
              SizedBox(
                height: 2.h,
              ),
              Center(
                  child: CustomText(
                text: mesg,
                style: TextStyleConstant.lightNoInterNetText(context),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
