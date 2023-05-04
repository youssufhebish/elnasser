import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/Info_screen.dart';
import 'package:elnasser/screens/beanches/branches.dart';
import 'package:elnasser/screens/beanches/branches_bloc/branches_cubit.dart';
import 'package:elnasser/screens/contat_us/contact_us_screen.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobile_state.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/question/question_bloc/question_cubit.dart';
import 'package:elnasser/screens/question/question_screen.dart';
import 'package:elnasser/widget/circle.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class supportScreen extends StatelessWidget {
  supportScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;
  @override
  Widget build(BuildContext context) {
    print(ColorsConstant.getColorBackground3(colorsValue));
    return BlocBuilder<HomeMobileCubit, HomeMobileState>(builder: (context, state) {
      return Container(
        height: 100.h - (AppBar().preferredSize.height * (Responsive.isTablet(context) ? 2.3 : 2)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsConstant.getColorBackground3(colorsValue),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                ),
                height: 25.h,
                width: SizeDataConstant.fullWidth(context),
                child: Stack(
                  children: [
                    Positioned(
                        top: -70,
                        left: -120,
                        child: CustomPaint(
                          size: Size(
                              200 * 1.5,
                              (200 * 1.6)
                                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: circle(),
                        )),
                    Positioned(
                        bottom: -70,
                        right: 0,
                        child: CustomPaint(
                          size: Size(
                              110 * 1.5,
                              (110 * 1.6)
                                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: circle(),
                        )),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 25,
              left:
                  (MediaQuery.of(context).size.width - SizeDataConstant.customWidth(context, 3)) / (Responsive.isTablet(context) ? 2 : 2.2),
              child: Container(
                width: SizeDataConstant.customWidth(context, 3),
                child: Image.asset(
                  ImageConstants.whiteLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: (Responsive.isTablet(context) ? 160 : 80),
              left: (Responsive.isTablet(context) ? 32.5 : 15),
              child: Container(
                height: 100.h - (AppBar().preferredSize.height * 2.9),
                width: SizeDataConstant.customWidth(context, 1.08),
                child: ListView(
                  shrinkWrap: true,
                  // physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      width: SizeDataConstant.customWidth(context, 1.08),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ColorsConstant.getColorBorder1(colorsValue),
                        ),
                      ),
                      child: Center(child: BlocBuilder<HomeMobileCubit, HomeMobileState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              MenuUSerWidget(
                                title: 'branches',
                                image: ImageConstants.map,
                                colorsValue: colorsValue,
                                onTap: () {
                                  BranchesCubit.get(context).addBranches(context: context, colorsValue: colorsValue);

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BranchesScreen()));
                                },
                              ),
                              MenuUSerWidget(
                                title: 'aboutUs',
                                image: ImageConstants.aboutUs,
                                colorsValue: colorsValue,
                                onTap: () {
                                  print(SplashCubit.get(context).theInitialModel.data!.info!.infosAbout);
                                  SplashCubit.get(context).theInitialModel.data!.info!.infosAbout != null
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => InfoScreen(
                                                    data: SplashCubit.get(context).theInitialModel.data!.info!.infosAbout!,
                                                    title: 'aboutUs',
                                                    colorsValue: colorsValue,
                                                  )))
                                      : print("");
                                },
                              ),
                              MenuUSerWidget(
                                title: 'contactWithUs',
                                image: ImageConstants.contactUs,
                                colorsValue: colorsValue,
                                onTap: () {
                                  SplashCubit.get(context).theInitialModel.data!.contactSubject != null
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ContactUsScreen(
                                                    contactSubject: SplashCubit.get(context).theInitialModel.data!.contactSubject!,
                                                    info: SplashCubit.get(context).theInitialModel.data!.info!,
                                                    title: 'contactWithUs',
                                                    colorsValue: colorsValue,
                                                  )))
                                      : print("");
                                },
                              ),
                              MenuUSerWidget(
                                title: 'question',
                                image: ImageConstants.faqs,
                                colorsValue: colorsValue,
                                onTap: () {
                                  QuestionCubit.get(context).getQuestion(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QuestionScreen(
                                                title: 'question',
                                                colorsValue: colorsValue,
                                              )));
                                },
                              ),
                            ],
                          );
                        },
                      )),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: SizeDataConstant.customWidth(context, 1.08),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ColorsConstant.getColorBorder1(colorsValue),
                        ),
                      ),
                      child: Center(child: BlocBuilder<HomeMobileCubit, HomeMobileState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              MenuUSerWidget(
                                title: 'termsCondition',
                                image: ImageConstants.terms,
                                colorsValue: colorsValue,
                                onTap: () {
                                  SplashCubit.get(context).theInitialModel.data!.info!.infosTermsConditions != null
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => InfoScreen(
                                                    data: SplashCubit.get(context).theInitialModel.data!.info!.infosTermsConditions!,
                                                    title: 'termsCondition',
                                                    colorsValue: colorsValue,
                                                  )))
                                      : print("");
                                },
                              ),
                              MenuUSerWidget(
                                title: 'privacyPolicies',
                                image: ImageConstants.privacy,
                                colorsValue: colorsValue,
                                onTap: () {
                                  SplashCubit.get(context).theInitialModel.data!.info!.infosPrivacyPolicy != null
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => InfoScreen(
                                                    data: SplashCubit.get(context).theInitialModel.data!.info!.infosPrivacyPolicy!,
                                                    title: 'privacyPolicies',
                                                    colorsValue: colorsValue,
                                                  )))
                                      : print("");
                                },
                              ),
                              MenuUSerWidget(
                                title: 'returnAndExchangePolicy',
                                image: ImageConstants.aboutUs,
                                colorsValue: colorsValue,
                                onTap: () {
                                  SplashCubit.get(context).theInitialModel.data!.info!.infosReturnExchangePolicy != null
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => InfoScreen(
                                                    data: SplashCubit.get(context).theInitialModel.data!.info!.infosReturnExchangePolicy!,
                                                    title: 'returnAndExchangePolicy',
                                                    colorsValue: colorsValue,
                                                  )))
                                      : print("");
                                },
                              ),
                            ],
                          );
                        },
                      )),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: SizeDataConstant.customWidth(context, 1.08),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ColorsConstant.getColorBorder1(colorsValue),
                        ),
                      ),
                      child: Center(child: BlocBuilder<HomeMobileCubit, HomeMobileState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              BlocConsumer<HomeCubit, HomeState>(
                                builder: (context, state) {
                                  return MenuUSerWidget(
                                    title: 'language',
                                    image: ImageConstants.language,
                                    colorsValue: colorsValue,
                                    onTap: () {
                                      if (EasyLocalization.of(context)!.currentLocale!.languageCode == "en") {
                                        HomeCubit.get(context).changeLanguage(type: "arabic", context: context);
                                      } else {
                                        HomeCubit.get(context).changeLanguage(type: "english", context: context);
                                      }
                                    },
                                  );
                                },
                                listener: (context, state) async {
                                  if (state is HomeChangeLanguage) {
                                    // SplashCubit.get(context).getInitial(context);

                                  }
                                },
                              ),
                            ],
                          );
                        },
                      )),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: SizeDataConstant.customWidth(context, 1.08),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ColorsConstant.getColorBorder1(colorsValue),
                        ),
                      ),
                      child: Center(child: BlocBuilder<HomeMobileCubit, HomeMobileState>(
                        builder: (context, state) {
                          return Column(
                            children: [
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
                                  SplashCubit.get(context).theInitialModel.data!.info!.infosMessengerAccount != null
                                      ? InkWell(
                                          onTap: () {
                                            SharedMethods.launchURL(
                                                "http://m.me/${SplashCubit.get(context).theInitialModel.data!.info!.infosMessengerAccount}");
                                          },
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.blue,
                                            child: Icon(
                                              FontAwesomeIcons.facebookMessenger,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Spacer(
                                    flex: SplashCubit.get(context).theInitialModel.data!.info!.infosWhatsapp != null ? 2 : 1,
                                  ),
                                  SplashCubit.get(context).theInitialModel.data!.info!.infosWhatsapp != null
                                      ? InkWell(
                                          onTap: () {
                                            SharedMethods.launchWithURLWhats(
                                                SplashCubit.get(context).theInitialModel.data!.info!.infosWhatsapp!);
                                          },
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              FontAwesomeIcons.whatsapp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Spacer(
                                    flex: SplashCubit.get(context).theInitialModel.data!.info!.infosEmail != null ? 2 : 1,
                                  ),
                                  SplashCubit.get(context).theInitialModel.data!.info!.infosEmail != null
                                      ? InkWell(
                                          onTap: () async {
                                            final Uri params = Uri(
                                              scheme: 'mailto',
                                              path: SplashCubit.get(context).theInitialModel.data!.info!.infosEmail!,
                                              query: '',
                                            );

                                            var url = params.toString();
                                            SharedMethods.launchURL(url);
                                          },
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Color(0xff3B5998),
                                            child: Icon(
                                              Icons.email,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Spacer(
                                    flex: 3,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          );
                        },
                      )),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: SizeDataConstant.customWidth(context, 1.08),
                      child: Column(children: [
                        CustomText(
                          text: "versionNo".tr().toString(),
                          style: TextStyle(fontSize: 10),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: Responsive.isTablet(context) ? 35.h : 5.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class MenuUSerWidget extends StatelessWidget {
  MenuUSerWidget(
      {Key? key, required this.colorsValue, required this.title, required this.image, this.defaultColor = false, required this.onTap})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String image;
  final String title;
  bool? defaultColor;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeMobileCubit, HomeMobileState>(builder: (context, state) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: SizedBox(
          height: 8.h,
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Container(
                height: 6.h,
                width: 6.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: ColorsConstant.getColorBackground5(colorsValue)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ImageView(
                    path: image,
                    fit: BoxFit.contain,
                    color: defaultColor == true ? null : ColorsConstant.getColorBackground3(colorsValue),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CustomText(
                text: "$title".tr().toString(),
                style: TextStyleConstant.bodyText(context, colorsValue),
              ),
              Spacer(),
              Icon(EasyLocalization.of(context)!.currentLocale!.languageCode == "en"
                  ? Icons.keyboard_arrow_right
                  : Icons.keyboard_arrow_left),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ContactWidget extends StatelessWidget {
  ContactWidget(
      {Key? key, required this.colorsValue, required this.title, required this.icon, this.defaultColor = false, required this.onTap})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final IconData icon;
  final String title;
  bool? defaultColor;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeMobileCubit, HomeMobileState>(builder: (context, state) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: SizedBox(
          height: 8.h,
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Container(
                height: 6.h,
                width: 6.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: ColorsConstant.getColorBackground5(colorsValue)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(icon),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CustomText(
                text: "$title".tr().toString(),
                style: TextStyleConstant.bodyText(context, colorsValue),
              ),
              Spacer(),
              Icon(EasyLocalization.of(context)!.currentLocale!.languageCode == "en"
                  ? Icons.keyboard_arrow_right
                  : Icons.keyboard_arrow_left),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      );
    });
  }
}

// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(4),
// border: Border.all(
// color: ColorsConstant.getColorBorder1(colorsValue),
// ),
// ),
// child:
// Center(child: BlocBuilder<HomeMobileCubit, HomeMobileState>(
// builder: (context, state) {
// return Column(
// children: [
// HomeMobileCubit.get(context).isUserLogin == true
// ? MenuUSerWidget(
// title: 'personal',
// image: ImageConstants.personal,
// colorsValue: colorsValue,
// onTap: () {},
// )
//     : InkWell(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => LoginPage(
// theInitialModel:
// HomeMobileCubit.get(context)
//     .theInitialModel)));
// },
// child: SizedBox(
// height: 10.h,
// child: Row(
// children: [
// SizedBox(
// width: 15,
// ),
// Container(
// height: 6.h,
// width: 6.h,
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(8),
// color: ColorsConstant
//     .getColorBackground5(
// colorsValue)),
// child: Icon(
// Icons.logout,
// color: ColorsConstant
//     .getColorBackground3(colorsValue),
// ),
// ),
// SizedBox(
// width: 15,
// ),
// CustomText(
// text: "login".tr().toString(),
// style: TextStyleConstant.bodyText(
// context, colorsValue),
// ),
// Spacer(),
// Icon(Icons.keyboard_arrow_right),
// SizedBox(
// width: 15,
// ),
// ],
// ),
// ),
// ),
// MenuUSerWidget(
// title: 'order',
// image: ImageConstants.order,
// colorsValue: colorsValue,
// onTap: () {},
// ),
// MenuUSerWidget(
// title: 'favorite',
// image: ImageConstants.favorite,
// colorsValue: colorsValue,
// onTap: () {},
// ),
// MenuUSerWidget(
// title: 'address',
// image: ImageConstants.address,
// colorsValue: colorsValue,
// onTap: () {
// AddressCubit.get(context)
//     .getAddressAndPaymentMethods(context);
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => AddressScreen(
// colorsValue: colorsValue)));
// },
// ),
// MenuUSerWidget(
// title: 'wallet',
// image: ImageConstants.wallet,
// colorsValue: colorsValue,
// onTap: () {},
// ),
// ],
// );
// },
// )),
// ),
