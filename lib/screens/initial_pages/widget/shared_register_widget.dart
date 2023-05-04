import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_ui/home_screen.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/services/google_service/faceBook_service.dart';
import 'package:elnasser/services/google_service/google_cubit.dart';
import 'package:elnasser/services/google_service/google_service.dart';
import 'package:elnasser/services/google_service/google_state.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../twitter.dart';

class SharedRegisterWidget extends StatelessWidget {
  const SharedRegisterWidget(
      {Key? key, required this.theInitialModel, required this.onPressed, required this.title, required this.buttonTitle})
      : super(key: key);
  final TheInitialModel? theInitialModel;
  final String title;
  final String buttonTitle;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: SizeDataConstant.customWidth(context, 1.1),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Divider(
                  color: ColorsConstant.getColorText3(theInitialModel!.data!.account!.mobileAppColors!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: CustomText(
                    text: "or".tr().toString(),
                    style: TextStyleConstant.optionalText(context, theInitialModel!.data!.account!.mobileAppColors!)),
              ),
              Expanded(
                flex: 1,
                child: Divider(
                  color: ColorsConstant.getColorText3(theInitialModel!.data!.account!.mobileAppColors!),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SplashCubit.get(context).theInitialModel.data!.account!.accountsSocialLoginBtns == '0'
            ? SizedBox()
            : Column(
                children: [
                  CustomText(
                      text: "connectWithYourSocialAccount".tr().toString(),
                      style: TextStyleConstant.optionalText(context, theInitialModel!.data!.account!.mobileAppColors!)),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(
                        flex: 3,
                      ),
                      BlocConsumer<GoogleServiceCubit, GoogleServiceState>(builder: (context, state) {
                        return Material(
                          child: InkWell(
                            onTap: () {
                              FaceBookLoginService().fbSignIn(context);
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xff3B5998),
                              child: Icon(
                                FontAwesomeIcons.facebookF,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }, listener: (context, state) {
                        if (state is GoogleServiceStateSuccess) {
                          HomeMobileCubit.get(context).getData(context);
                          SplashCubit.get(context).getAppData(context: context);
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => HomePageScreen(theInitialModel: theInitialModel!)));
                        }
                      }),
                      Spacer(
                        flex: 1,
                      ),
                      BlocConsumer<GoogleServiceCubit, GoogleServiceState>(builder: (context, state) {
                        return Material(
                          child: InkWell(
                            onTap: () {
                              GoogleSignService().signinWithGoogle(context);
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xffde5246),
                              child: Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }, listener: (context, state) {
                        if (state is GoogleServiceStateSuccess) {
                          HomeMobileCubit.get(context).getData(context);
                          SplashCubit.get(context).getAppData(context: context);
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => HomePageScreen(theInitialModel: theInitialModel!)));
                        }
                      }),
                      Spacer(
                        flex: 1,
                      ),
                      BlocConsumer<GoogleServiceCubit, GoogleServiceState>(builder: (context, state) {
                        return Material(
                          child: InkWell(
                            onTap: () {
                              // TwitterService().siginInTwitter(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TwitterLoginScreen(
                                            oauthCallbackHandler: "https://polaris-max.com/twitter-login.html",
                                            consumerKey: 'oNEAxoM6Qd02KSAwh4GmzHKXe',
                                            consumerSecret: 'bLB7vSPbObseqbjm5b2lJpbnoWtgjIF0fMPjoicp4g01WpI74o',
                                          )));
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xff3B5998),
                              child: Icon(
                                FontAwesomeIcons.twitter,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }, listener: (context, state) {
                        if (state is GoogleServiceStateSuccess) {
                          HomeMobileCubit.get(context).getData(context);
                          SplashCubit.get(context).getAppData(context: context);
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => HomePageScreen(theInitialModel: theInitialModel!)));
                        }
                      }),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ],
              ),
        SizedBox(
          height: 3.h,
        ),
        CustomText(
            text: title.tr().toString(), style: TextStyleConstant.optionalText(context, theInitialModel!.data!.account!.mobileAppColors!)),
        SizedBox(
          height: 1.h,
        ),
        AppButton(
          color: ColorsConstant.getColorBackground3(theInitialModel!.data!.account!.mobileAppColors!),
          textStyle: TextStyleConstant.backGroundText(context, theInitialModel!.data!.account!.mobileAppColors!),
          title: buttonTitle.tr().toString(),
          colorsInitialValue: theInitialModel!.data!.account!.mobileAppColors!,
          onPressed: onPressed,
          widthRatio: 1.1,
          heightRatio: 7,
          withBorder: true,
        ),
        SizedBox(
          height: 5.h,
        )
      ],
    );
  }
}
