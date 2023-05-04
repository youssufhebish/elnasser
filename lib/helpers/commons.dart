import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Commons {
  final zero = Duration();
  // static String baseUrl = "https://polaris-max.nmait.net/";
  static String baseUrl = "https://polaris-max.com/system/";
  static String paymentMethodsFolder = "uploads/payments/";
  static String apiVersion = "/api/v002";

  //static String accountId = "19";
  static String accountId = "20";

  static getLanguage(BuildContext context) => EasyLocalization.of(context)!.currentLocale!.languageCode;
}
