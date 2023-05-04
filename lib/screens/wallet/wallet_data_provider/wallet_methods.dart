import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/image_constants.dart';

class WalletMethods {
  String? getType(String type) {
    switch (type) {
      case "order":
        return "payAnOrder";
      case "admin":
        return "depositAyAdmin";
      case "admin_withdraw":
        return "deductionByAdmin";
      case "coupon":
        return "depositFromCoupon";
      case "clients_coupon":
        return "depositFromCoupon";
    }
  }

  Color? getColor(String type) {
    switch (type) {
      case "order":
        return Color(0xffFFC633);
      case "admin":
        return Color(0xff38D79F);
      case "admin_withdraw":
        return Color(0xffFF6E66);
      case "coupon":
        return Color(0xff38D79F);
      case "clients_coupon":
        return Color(0xff38D79F);
    }
  }

  String? getImage(String type) {
    switch (type) {
      case "order":
        return ImageConstants.payOrder;
      case "admin":
        return ImageConstants.walletPay;
      case "admin_withdraw":
        return ImageConstants.walletPay;
      case "coupon":
        return ImageConstants.gift;
      case "clients_coupon":
        return ImageConstants.gift;
    }
  }

  String convertDate(String date) {
    DateTime localDate = DateTime.parse(date).toLocal();
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse("$localDate").toLocal();
    var inputDate = DateTime.parse(parseDate.toString()).toLocal();
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate).toLocale();
    return "$outputDate";
  }
}
