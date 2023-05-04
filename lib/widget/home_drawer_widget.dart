import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/Info_screen.dart';
import 'package:elnasser/screens/beanches/branches.dart';
import 'package:elnasser/screens/beanches/branches_bloc/branches_cubit.dart';
import 'package:elnasser/screens/contat_us/contact_us_screen.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required this.colorsValue,
  }) : super(key: key);
  final ColorsInitialValue colorsValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: SizedBox(
                      width: SizeDataConstant.customWidth(context, 2),
                      child: Image.asset(
                        ImageConstants.blueLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                      text: "helpInfo".tr().toString(),
                      style: TextStyleConstant.headerTextLargeBlack(
                          context, colorsValue)),
                  SizedBox(
                    height: 3.h,
                  ),
                  InkWell(
                    onTap: () {
                      BranchesCubit.get(context).addBranches(
                          context: context, colorsValue: colorsValue);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BranchesScreen()));
                    },
                    child: Row(
                      children: [
                        Container(
                            height: 3.h,
                            width: 3.h,
                            child: ImageView(
                              path: ImageConstants.map,
                              fit: BoxFit.cover,
                              color: ColorsConstant.getColorBackground6(
                                  colorsValue),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "branches".tr().toString(),
                            style: TextStyleConstant.bodyText(
                                context, colorsValue)),
                      ],
                    ),
                  ),
                  Divider(),

                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {
                      print(SplashCubit.get(context)
                          .theInitialModel
                          .data!
                          .info!
                          .infosAbout);
                      SplashCubit.get(context)
                                  .theInitialModel
                                  .data!
                                  .info!
                                  .infosAbout !=
                              null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoScreen(
                                        data: SplashCubit.get(context)
                                            .theInitialModel
                                            .data!
                                            .info!
                                            .infosAbout!,
                                        title: 'aboutUs',
                                        colorsValue: colorsValue,
                                      )))
                          : print("");
                    },
                    child: Row(
                      children: [
                        Container(
                            height: 3.h,
                            width: 3.h,
                            child: ImageView(
                              path: ImageConstants.aboutUs,
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "aboutUs".tr().toString(),
                            style: TextStyleConstant.bodyText(
                                context, colorsValue)),
                      ],
                    ),
                  ),
                  SplashCubit.get(context)
                              .theInitialModel
                              .data!
                              .info!
                              .infosTermsConditions !=
                          null
                      ? Column(
                          children: [
                            Divider(),
                            SizedBox(
                              height: 2.h,
                            ),
                            InkWell(
                              onTap: () {
                                SplashCubit.get(context)
                                            .theInitialModel
                                            .data!
                                            .info!
                                            .infosTermsConditions !=
                                        null
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InfoScreen(
                                                  data: SplashCubit.get(context)
                                                      .theInitialModel
                                                      .data!
                                                      .info!
                                                      .infosTermsConditions!,
                                                  title: 'termsCondition',
                                                  colorsValue: colorsValue,
                                                )))
                                    : print("");
                              },
                              child: Row(
                                children: [
                                  Container(
                                      height: 3.h,
                                      width: 3.h,
                                      child: ImageView(
                                        path: ImageConstants.terms,
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                      text: "termsCondition".tr().toString(),
                                      style: TextStyleConstant.bodyText(
                                          context, colorsValue)),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Divider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {
                      SplashCubit.get(context)
                                  .theInitialModel
                                  .data!
                                  .info!
                                  .infosPrivacyPolicy !=
                              null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoScreen(
                                        data: SplashCubit.get(context)
                                            .theInitialModel
                                            .data!
                                            .info!
                                            .infosPrivacyPolicy!,
                                        title: 'privacyPolicies',
                                        colorsValue: colorsValue,
                                      )))
                          : print("");
                    },
                    child: Row(
                      children: [
                        Container(
                            height: 3.h,
                            width: 3.h,
                            child: ImageView(
                              path: ImageConstants.privacy,
                              fit: BoxFit.cover,
                              color: ColorsConstant.getColorBackground6(
                                  colorsValue),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "privacyPolicies".tr().toString(),
                            style: TextStyleConstant.bodyText(
                                context, colorsValue)),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 2.h,
                  ),

                  InkWell(
                    onTap: () {
                      SplashCubit.get(context)
                                  .theInitialModel
                                  .data!
                                  .contactSubject !=
                              null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactUsScreen(
                                        contactSubject: SplashCubit.get(context)
                                            .theInitialModel
                                            .data!
                                            .contactSubject!,
                                        info: SplashCubit.get(context)
                                            .theInitialModel
                                            .data!
                                            .info!,
                                        title: 'contactWithUs',
                                        colorsValue: colorsValue,
                                      )))
                          : print("");
                    },
                    child: Row(
                      children: [
                        Container(
                            height: 3.h,
                            width: 3.h,
                            child: ImageView(
                              path: ImageConstants.privacy,
                              fit: BoxFit.cover,
                              color: ColorsConstant.getColorBackground6(
                                  colorsValue),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "contactWithUs".tr().toString(),
                            style: TextStyleConstant.bodyText(
                                context, colorsValue)),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 2.h,
                  ),

                  InkWell(
                    onTap: () {
                      SplashCubit.get(context)
                                  .theInitialModel
                                  .data!
                                  .info!
                                  .infosReturnExchangePolicy !=
                              null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoScreen(
                                        data: SplashCubit.get(context)
                                            .theInitialModel
                                            .data!
                                            .info!
                                            .infosReturnExchangePolicy!,
                                        title: 'returnAndExchangePolicy',
                                        colorsValue: colorsValue,
                                      )))
                          : print("");
                    },
                    child: Row(
                      children: [
                        Container(
                            height: 3.h,
                            width: 3.h,
                            child: ImageView(
                              path: ImageConstants.privacy,
                              fit: BoxFit.cover,
                              color: ColorsConstant.getColorBackground6(
                                  colorsValue),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "returnAndExchangePolicy".tr().toString(),
                            style: TextStyleConstant.bodyText(
                                context, colorsValue)),
                      ],
                    ),
                  ),
                  Divider(),

                  SizedBox(
                    height: 2.h,
                  ),
                  CustomText(
                      text: "language".tr().toString(),
                      style: TextStyleConstant.headerTextLargeBlack(
                          context, colorsValue)),

                  BlocConsumer<HomeCubit, HomeState>(
                      listener: (context, state) {
                        if (state is HomeChangeLanguage) {
                          SplashCubit.get(context).getInitial(context);
                        }
                      },
                      buildWhen: (prev, current) =>
                          current is HomeChangeLanguage,
                      builder: (context, state) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            InkWell(
                              onTap: () {
                                HomeCubit.get(context).changeLanguage(
                                    type: "english", context: context);
                              },
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: null,
                                    child: CustomText(
                                        text: "english".tr().toString(),
                                        style:
                                            HomeCubit.get(context).isEnglish ==
                                                    true
                                                ? TextStyleConstant.bodyText(
                                                    context, colorsValue)
                                                : TextStyleConstant.bodyText(
                                                    context, colorsValue)),
                                  ),
                                  Spacer(),
                                  HomeCubit.get(context).isEnglish == true
                                      ? Icon(
                                          Icons.check,
                                          color: ColorsConstant
                                              .getColorBackground3(colorsValue),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            InkWell(
                              onTap: () {
                                HomeCubit.get(context).changeLanguage(
                                    type: "arabic", context: context);
                              },
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: null,
                                    child: CustomText(
                                        text: "arabic".tr().toString(),
                                        style:
                                            HomeCubit.get(context).isArabic ==
                                                    true
                                                ? TextStyleConstant
                                                    .headerTextLargeBlack(
                                                        context, colorsValue)
                                                : TextStyleConstant
                                                    .headerTextLargeBlack(
                                                        context, colorsValue)),
                                  ),
                                  Spacer(),
                                  HomeCubit.get(context).isArabic == true
                                      ? Icon(
                                          Icons.check,
                                          color: ColorsConstant
                                              .getColorBackground3(colorsValue),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        );
                      }),

                  SizedBox(
                    height: 12.h,
                  ),
                  // CustomText(text: "followUs".tr().toString(), style: TextStyleConstant.headerTextMainColor(context, colorsValue)),
                  //
                  // SizedBox(height: 2.h,),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //
                  //     InkWell(
                  //       onTap: (){
                  //         SharedMethods.launchURL(SplashCubit.get(context).theInitialModel.data!.info!.infosFacebook!);
                  //       },
                  //       child: CircleAvatar(
                  //         radius: 25,
                  //         backgroundColor: Color(0xff3B5998),
                  //         child: Icon(
                  //           FontAwesomeIcons.facebookF,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //     Spacer(
                  //       flex: 1,
                  //     ),
                  //
                  //     InkWell(
                  //       onTap: (){
                  //         SharedMethods.launchURL(SplashCubit.get(context).theInitialModel.data!.info!.infosInstagram!);
                  //
                  //       },
                  //       child: CircleAvatar(
                  //         radius: 25,
                  //         backgroundColor: Color(0xffde5246),
                  //         child: Icon(
                  //           FontAwesomeIcons.instagram,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //     Spacer(
                  //       flex: 1,
                  //     ),
                  //
                  //     InkWell(
                  //       onTap: (){
                  //         SharedMethods.launchURL(SplashCubit.get(context).theInitialModel.data!.info!.infosTwitter!);
                  //
                  //       },
                  //       child: CircleAvatar(
                  //         radius: 25,
                  //         backgroundColor: Color(0xff3B5998),
                  //         child: Icon(
                  //           FontAwesomeIcons.twitter,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //
                  //
                  //
                  //     Spacer(
                  //       flex: 3,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
