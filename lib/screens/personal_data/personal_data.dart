import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/succes_login_model.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_cubit.dart';
import 'package:elnasser/screens/Favorite/favorite_screen.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/address/address_screen.dart';
import 'package:elnasser/screens/contat_us/contact_us_bloc/contact_us_cubit.dart';
import 'package:elnasser/screens/edit_user/edit_user_bloc/edit_user_cubit.dart';
import 'package:elnasser/screens/edit_user/edit_user_screen.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/login/login_screen.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/mobile_register.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/orders_screen/Order_screen.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_bloc.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_bloc_state.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_event.dart';
import 'package:elnasser/screens/points_screen/point_bloc/point_cubit.dart';
import 'package:elnasser/screens/points_screen/points_screen.dart';
import 'package:elnasser/screens/wallet/wallet.dart';
import 'package:elnasser/screens/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:elnasser/screens/wallet/wallet_bloc/wallet_bloc_state.dart';
import 'package:elnasser/screens/wallet/wallet_bloc/wallet_event.dart';
import 'package:elnasser/services/google_service/faceBook_service.dart';
import 'package:elnasser/services/google_service/google_service.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/circle.dart';
import 'package:elnasser/screens/contat_us/contact_us_screen.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../Info_screen.dart';

class PersonalDataScreen extends StatelessWidget {
  PersonalDataScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeMobileCubit, HomeMobileState>(
        builder: (context, state) {
      return Stack(
        children: [
          Container(
            height: 100.h - (AppBar().preferredSize.height * 2.8),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: ColorsConstant.getColorBackground3(colorsValue),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
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
            top: 30,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              height: 30.h,
              width: SizeDataConstant.fullWidth(context),
              child: Column(
                children: [
                  HomeMobileCubit.get(context).isUserLogin == true
                      ? Row(
                          children: [
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  FaceBookLoginService().signOut();
                                  GoogleSignService().signOut();
                                  DataErrorAlert.LogOutDialog(
                                      context: context,
                                      colorValue: colorsValue);
                                },
                                icon: RotatedBox(
                                  quarterTurns: EasyLocalization.of(context)!
                                              .currentLocale!
                                              .languageCode ==
                                          "en"
                                      ? 0
                                      : 2,
                                  child: Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        )
                      : Container(
                          height: 1.h,
                        ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: SizeDataConstant.customWidth(context, 1.6),
                    child: CustomText(
                      maxLie: 2,
                      textAlign: TextAlign.center,
                      text: HomeMobileCubit.get(context).isUserLogin == true
                          ? "${HomeMobileCubit.get(context).userModel.data!.customer!.customersName}"
                          : "signTitle".tr().toString(),
                      style: TextStyleConstant.bodyTextWhiteBoldName(
                          context, colorsValue),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  HomeMobileCubit.get(context).isUserLogin == true
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          // child: Row(
                          //   children: [
                          //     Expanded(
                          //         child: AppButton(onPressed: () {
                          //           Navigator.push(context, MaterialPageRoute(builder: (context)=>MobileRegister(theInitialModel: HomeMobileCubit.get(context).theInitialModel,)));
                          //
                          //
                          //         }, title: 'createAccount'.tr().toString(), textStyle: TextStyleConstant.stepMain(context, colorsValue),withBorder: true, color: ColorsConstant.getColorBackground3(colorsValue), colorsInitialValue: colorsValue,)
                          //     ),  SizedBox(width: 8.0,),Expanded(
                          //         child: AppButton(onPressed: () {
                          //           Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(theInitialModel: HomeMobileCubit.get(context).theInitialModel,)));
                          //         }, title: 'login'.tr().toString(), textStyle: TextStyleConstant.buttonText(context, colorsValue),withBorder: false, color: ColorsConstant.getColorBackground2(colorsValue), colorsInitialValue: colorsValue,)
                          //     ),
                          //   ],
                          // ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 45,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MobileRegister(
                                                  theInitialModel:
                                                      SplashCubit.get(context)
                                                          .theInitialModel,
                                                  close: false,
                                                )));
                                  },
                                  child: CustomText(
                                    text: 'createAccount'.tr().toString(),
                                    style: TextStyleConstant.whiteText(
                                        context, colorsValue),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: BorderSide(
                                          color: Colors.white, width: 1)),
                                ),
                              )),
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 45,
                                child: MaterialButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage(
                                                  theInitialModel:
                                                      SplashCubit.get(context)
                                                          .theInitialModel,
                                                  close: false,
                                                )));
                                  },
                                  child: CustomText(
                                    text: 'login'.tr().toString(),
                                    style:
                                        TextStyleConstant.buttonTextMainColor(
                                            context, colorsValue),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: BorderSide(
                                          color: Colors.white, width: 1)),
                                ),
                              )),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            top: HomeMobileCubit.get(context).isUserLogin == true ? 18.h : 26.h,
            left: 15,
            child: Container(
              height: 100.h - (AppBar().preferredSize.height * 4.3),
              width: SizeDataConstant.customWidth(context, 1.08),
              child: ListView(
                shrinkWrap: true,
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
                    child: Center(
                        child: BlocBuilder<HomeMobileCubit, HomeMobileState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            MenuUSerWidget(
                              title: 'profile',
                              image: ImageConstants.personal,
                              colorsValue: colorsValue,
                              onTap: () {
                                if (HomeMobileCubit.get(context).isUserLogin ==
                                    true) {
                                  EditUserCubit.get(context).getData(context);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateUser(
                                              theInitialModel:
                                                  SplashCubit.get(context)
                                                      .theInitialModel)));
                                } else {
                                  DataErrorAlert.showLogin(
                                    colorValue: colorsValue,
                                    context: context,
                                    title: 'YouNeedToLogin'.tr().toString(),
                                    data: 'pleaseLoginFirst'.tr().toString(),
                                  );
                                }
                              },
                            ),
                            MenuUSerWidget(
                              title: 'order',
                              image: ImageConstants.order,
                              colorsValue: colorsValue,
                              onTap: () {
                                if (HomeMobileCubit.get(context).isUserLogin ==
                                    true) {
                                  context
                                      .read<OrderBloc>()
                                      .emit(OrderBlocState(context: context));
                                  // context.read<OrderBloc>().add(OrderReset());
                                  context.read<OrderBloc>().add(OrderFetch());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrderScreen(
                                              colorsValue: colorsValue)));
                                } else {
                                  DataErrorAlert.showLogin(
                                    colorValue: colorsValue,
                                    context: context,
                                    title: 'YouNeedToLogin'.tr().toString(),
                                    data: 'pleaseLoginFirst'.tr().toString(),
                                  );
                                }
                              },
                            ),
                            MenuUSerWidget(
                              title: 'favorite',
                              image: ImageConstants.favorite,
                              colorsValue: colorsValue,
                              onTap: () {
                                if (HomeMobileCubit.get(context).isUserLogin ==
                                    true) {
                                  FavoriteCubit.get(context)
                                      .getFavorite(context: context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FavoriteScreen(
                                              colorsValue: colorsValue)));
                                } else {
                                  DataErrorAlert.showLogin(
                                    colorValue: colorsValue,
                                    context: context,
                                    title: 'YouNeedToLogin'.tr().toString(),
                                    data: 'pleaseLoginFirst'.tr().toString(),
                                  );
                                }
                              },
                            ),
                            MenuUSerWidget(
                              title: 'address',
                              image: ImageConstants.address,
                              colorsValue: colorsValue,
                              onTap: () {
                                if (HomeMobileCubit.get(context).isUserLogin ==
                                    true) {
                                  EditUserCubit.get(context).getData(context);
                                  AddressCubit.get(context)
                                      .getAddressAndPaymentMethods(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddressScreen(
                                              colorsValue: colorsValue)));
                                } else {
                                  DataErrorAlert.showLogin(
                                    colorValue: colorsValue,
                                    context: context,
                                    title: 'YouNeedToLogin'.tr().toString(),
                                    data: 'pleaseLoginFirst'.tr().toString(),
                                  );
                                }
                              },
                            ),
                            MenuUSerWidget(
                              title: 'wallet',
                              image: ImageConstants.wallet,
                              colorsValue: colorsValue,
                              onTap: () {
                                if (HomeMobileCubit.get(context).isUserLogin ==
                                    true) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WalletScreen(
                                              colorsValue: colorsValue)));
                                } else {
                                  DataErrorAlert.showLogin(
                                    colorValue: colorsValue,
                                    context: context,
                                    title: 'YouNeedToLogin'.tr().toString(),
                                    data: 'pleaseLoginFirst'.tr().toString(),
                                  );
                                }
                              },
                            ),
                            MenuUSerWidget(
                              title: 'points',
                              image: ImageConstants.point,
                              colorsValue: colorsValue,
                              onTap: () {
                                if (HomeMobileCubit.get(context).isUserLogin ==
                                    true) {
                                  PointCubit.get(context).getPoints(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PointsScreen(
                                              colorsValue: colorsValue)));
                                } else {
                                  DataErrorAlert.showLogin(
                                    colorValue: colorsValue,
                                    context: context,
                                    title: 'YouNeedToLogin'.tr().toString(),
                                    data: 'pleaseLoginFirst'.tr().toString(),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: Responsive.isTablet(context) ? 30.h : 0,
                            ),
                          ],
                        );
                      },
                    )),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 8.h,
                  )
                ],
              ),
            ),
          ),

          /// welcome
          // Container(
          //   height: 10.h,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(
          //       color: ColorsConstant.getColorBorder1(colorsValue),
          //     ),
          //   ),
          //   child:
          //       Center(child: BlocBuilder<HomeMobileCubit, HomeMobileState>(
          //     builder: (context, state) {
          //       return CustomText(
          //         text: HomeMobileCubit.get(context).isUserLogin == true
          //             ? "${HomeMobileCubit.get(context).userModel.data!.customer!.customersName}"
          //             : "welcome".tr().toString(),
          //         style: TextStyleConstant.headerTextLargeBlack(
          //             context, colorsValue),
          //       );
          //     },
          //   )),
          // ),

          /// LogOut
          // BlocBuilder<HomeMobileCubit, HomeMobileState>(
          //     builder: (context, state) {
          //   return HomeMobileCubit.get(context).isUserLogin == true
          //       ? AppButton(
          //           colorsInitialValue: colorsValue,
          //           color: ColorsConstant.getColorBackground5(colorsValue),
          //           textStyle: TextStyleConstant.bodyTextLogOut(
          //               context, colorsValue),
          //           title: "logOut".tr().toString(),
          //           onPressed: () {
          //             // HomeMobileCubit.get(context).logOut();
          //             DataErrorAlert.LogOutDialog(
          //                 context: context, colorValue: colorsValue);
          //           })
          //       : Container();
          // })
        ],
      );
    });
  }
}

class MenuUSerWidget extends StatelessWidget {
  const MenuUSerWidget(
      {Key? key,
      required this.colorsValue,
      required this.title,
      required this.image,
      required this.onTap})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String image;
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeMobileCubit, HomeMobileState>(
        builder: (context, state) {
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsConstant.getColorBackground5(colorsValue)),
                child: ImageView(path: image),
              ),
              SizedBox(
                width: 15,
              ),
              CustomText(
                text: "$title".tr().toString(),
                style: TextStyleConstant.bodyText(context, colorsValue),
              ),
              Spacer(),
              Icon(EasyLocalization.of(context)!.currentLocale!.languageCode ==
                      "en"
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
