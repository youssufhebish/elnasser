import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/order_model/order_model_detail.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/initial_pages/login/login_screen.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit.dart';
import 'package:elnasser/screens/rate_order/rate_order.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

class DataErrorAlert {
  static showError({required String title, required String data, required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        context: context,
        // title: title,
        desc: data,
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.whiteText(context, colorValue)),
            onPressed: () {
              Navigator.pop(context);
            },
            color: ColorsConstant.getColorBackground3(colorValue),
          )
        ]).show();
  }

  static showLogin({required String title, required String data, required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        context: context,
        title: data,
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.headerText(context, colorValue)),
        buttons: [
          DialogButton(
            child: CustomText(text: "cancel".tr().toString(), style: TextStyleConstant.whiteText(context, colorValue)),
            onPressed: () {
              Navigator.pop(context);
            },
            color: ColorsConstant.getColorBackground3(colorValue),
          ),
          DialogButton(
            child: CustomText(text: "login".tr().toString(), style: TextStyleConstant.whiteText(context, colorValue)),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(
                            theInitialModel: SplashCubit.get(context).theInitialModel,
                            close: false,
                          )));
            },
            color: ColorsConstant.getColorBackground3(colorValue),
          ),
        ]).show();
  }

  static LocationError(
      {required String title, required String data, required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        context: context,
        title: data,
        closeFunction: () {
          Navigator.pop(context);
        },
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            titleStyle: TextStyleConstant.errorText(context, colorValue!),
            descStyle: TextStyleConstant.headerText(context, colorValue)),
        buttons: [
          DialogButton(
            child: CustomText(text: "cancel".tr().toString(), style: TextStyleConstant.whiteText(context, colorValue)),
            onPressed: () {
              Navigator.pop(context);
            },
            color: ColorsConstant.getColorBackground3(colorValue),
          ),
          DialogButton(
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.whiteText(context, colorValue)),
            onPressed: () async {
              if (Platform.isAndroid) {
                final AndroidIntent intent = AndroidIntent(
                  action: 'action_application_details_settings',
                  data: Platform.isAndroid
                      ? 'package:com.namaait.alnasser'
                      : 'package:com.namaait.alnasser.eg', // replace com.example.app with your applicationId
                );
                await intent.launch();
              }
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: ColorsConstant.getColorBackground3(colorValue),
          ),
        ]).show();
  }

  static LogOutDialog({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: RotatedBox(
            quarterTurns: EasyLocalization.of(context)!.currentLocale!.languageCode == "en" ? 0 : 2,
            child: Icon(
              Icons.logout,
              color: Colors.red,
            )),
        context: context,
        title: "signOut".tr().toString(),
        desc: "signOutQuestion".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "notNow".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "yesNow".tr().toString(), style: TextStyleConstant.errorText(context, colorValue)),
            onPressed: () async {
              HomeMobileCubit.get(context).logOut();

              Navigator.of(context, rootNavigator: true).pop();
              HomeMobileCubit.get(context).getData(context);
              HomeMobileCubit.get(context).getMobileHome(context);
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static ReorderSuccess({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.of(context).pop();
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context, rootNavigator: true).pop();
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Color(0xff43DC2D), shape: BoxShape.circle),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            )),
        context: context,
        desc: "reOrderSuccess".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: true,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static upDateSuccess({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Color(0xff43DC2D), shape: BoxShape.circle),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            )),
        context: context,
        desc: "dataUpdated".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static rateSuccess({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Color(0xff43DC2D), shape: BoxShape.circle),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            )),
        context: context,
        desc: "rateSuccess".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static SuggestionSuccess({required ColorsInitialValue? colorValue, required String data, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Color(0xff43DC2D), shape: BoxShape.circle),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            )),
        context: context,
        desc: data,
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static CancelOrderSuccess({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Color(0xff43DC2D), shape: BoxShape.circle),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            )),
        context: context,
        desc: "cancelOrderSuccess".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static refundSuccess({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Color(0xff43DC2D), shape: BoxShape.circle),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            )),
        context: context,
        desc: "success".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static selectLocation({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            )),
        context: context,
        desc: "pleaseSelectLocation".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static OrderReasonRefund(
      {required ColorsInitialValue? colorValue,
      required String id,
      required BuildContext context,
      required TextEditingController controller}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        content: AppTextFiled(
          validationWidget: Container(),
          controller: controller,
          password: false,
          labelText: 'refundReason',
          hintText: 'refundReason',
          node: null,
          inputType: TextInputType.text,
          nextNode: null,
          colorsInitialValue: colorValue!,
          validation: null,
        ),
        context: context,
        desc: "refundReason".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "refund".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {},
            color: Colors.white,
          ),
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "cancel".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static cartWillBeDeleted({required ColorsInitialValue? colorValue, required String ordersId, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        context: context,
        desc: "theItemInCartWillBeDeleted".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              ///  re order
              ///
              OrderCubit.get(context).ReOrderMethod(context: context, orderId: "${ordersId}");
            },
            color: Colors.white,
          ),
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "cancel".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static deleteAddress({required ColorsInitialValue? colorValue, required BuildContext context, required String id}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: ImageView(
          path: ImageConstants.delete,
          color: ColorsConstant.getColorText3(colorValue!),
        ),
        context: context,
        desc: "deleteAddress".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            titleStyle: TextStyleConstant.headerText(context, colorValue),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "no".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "yes".tr().toString(), style: TextStyleConstant.errorText(context, colorValue)),
            onPressed: () async {
              AddressCubit.get(context).deleteAddressMethod(context: context, addressId: id).whenComplete(() => Navigator.pop(context));
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static NoStock({required ColorsInitialValue? colorValue, String? desc, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            )),
        context: context,
        desc: desc,
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static RateMessage({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Color(0xffFFFFFF), shape: BoxShape.circle),
            child: Icon(
              FontAwesomeIcons.smile,
              color: Colors.amberAccent,
              size: 40,
            )),
        context: context,
        desc: "youNeedToBuyTheProductToRate".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static MissingRateMessageProduct({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Color(0xffFFFFFF), shape: BoxShape.circle),
            child: Icon(
              FontAwesomeIcons.smile,
              color: Colors.amberAccent,
              size: 40,
            )),
        context: context,
        desc: "missingRate".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static MissingRateMessageOrder({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Color(0xffFFFFFF), shape: BoxShape.circle),
            child: Icon(
              FontAwesomeIcons.smile,
              color: Colors.amberAccent,
              size: 40,
            )),
        context: context,
        desc: "pleaseCompleteOrderRate".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static RateOrder({required ColorsInitialValue? colorValue, required Order orderDetailsModel, required BuildContext context}) {
    Alert(
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        closeFunction: () {
          Navigator.pop(context);
        },
        image: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(color: Color(0xffFFFFFF), shape: BoxShape.circle),
            child: Icon(
              FontAwesomeIcons.smile,
              color: Colors.amberAccent,
              size: 40,
            )),
        context: context,
        desc: "pleaseCompleteOrderRate".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            isOverlayTapDismiss: false,
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "ok".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RatingOrder(
                            colorsValue: colorValue,
                            orderModelDetail: orderDetailsModel,
                            edit: false,
                          )));
            },
            color: Colors.white,
          ),
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "cancel".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }

  static ExitApp({required ColorsInitialValue? colorValue, required BuildContext context}) {
    Alert(
        closeFunction: () {
          Navigator.pop(context);
        },
        image: RotatedBox(
            quarterTurns: EasyLocalization.of(context)!.currentLocale!.languageCode == "en" ? 0 : 2,
            child: Icon(
              Icons.logout,
              color: Colors.red,
            )),
        context: context,
        closeIcon: Icon(
          Icons.close,
          size: 30,
        ),
        title: "exitApp".tr().toString(),
        desc: "areYouSure".tr().toString(),
        style: AlertStyle(
            overlayColor: Colors.grey.withOpacity(.8),
            titleStyle: TextStyleConstant.headerText(context, colorValue!),
            descStyle: TextStyleConstant.bodyText(context, colorValue)),
        buttons: [
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "notNow".tr().toString(), style: TextStyleConstant.lightText(context, colorValue)),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          DialogButton(
            border: Border.all(color: ColorsConstant.getColorBorder1(colorValue)),
            child: CustomText(text: "yesNow".tr().toString(), style: TextStyleConstant.errorText(context, colorValue)),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              SystemNavigator.pop();
            },
            color: Colors.white,
          ),
        ]).show();
  }
}
