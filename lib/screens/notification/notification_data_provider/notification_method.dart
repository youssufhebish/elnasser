import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/cart/cart_screen.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit.dart';
import 'package:elnasser/screens/orders_screen/order_detail_with_api.dart';
import 'package:elnasser/screens/points_screen/points_screen.dart';
import 'package:elnasser/screens/wallet/wallet.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationMethod {
  GoTo(
      {required String type,
      required BuildContext context,
      required ColorsInitialValue colorsInitialValue,
      String? orderId}) {
    switch (type) {
      case "order":
        OrderCubit.get(context)
            .getOrderDetails(context: context, orderId: orderId!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailScreenWithApi(
                      colorsValue: colorsInitialValue,
                    )));
        break;
      case "wallet":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WalletScreen(
                      colorsValue: colorsInitialValue,
                    )));
        break;
      case "point":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PointsScreen(
                      colorsValue: colorsInitialValue,
                    )));
        break;
      case "cart":
        if (SplashCubit.get(context).theInitialModel.data!.setting!.stopOrder ==
            "0") {
          DataErrorAlert.showError(
              data: SplashCubit.get(context)
                  .theInitialModel
                  .data!
                  .setting!
                  .stopOrderMsg!,
              title: "",
              colorValue: colorsInitialValue,
              context: context);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CartScreen(
                        colorsValue: colorsInitialValue,
                      )));
        }
        break;
    }
  }

  Title<Widget>(
      {required String type,
      required BuildContext context,
      required ColorsInitialValue colorValue}) {
    switch (type) {
      case "order":
        return CustomText(
            text: "orderStatus".tr().toString(),
            style: TextStyleConstant.headerText(context, colorValue));
      case "wallet":
        return CustomText(
            text: "walletChange".tr().toString(),
            style: TextStyleConstant.headerText(context, colorValue));
      case "stock":
        return CustomText(
            text: "productAvailable".tr().toString(),
            style: TextStyleConstant.headerText(context, colorValue));
      case "point":
        return CustomText(
            text: "pointChange".tr().toString(),
            style: TextStyleConstant.headerText(context, colorValue));
      case "message":
        return CustomText(
            text: "messageForYou".tr().toString(),
            style: TextStyleConstant.headerText(context, colorValue));
      case "offer":
        return CustomText(
            text: "newOffer".tr().toString(),
            style: TextStyleConstant.headerText(context, colorValue));
      case "cart":
        return CustomText(
            text: "cart".tr().toString(),
            style: TextStyleConstant.headerText(context, colorValue));
      default:
        {
          return Container();
        }
    }
  }
}
