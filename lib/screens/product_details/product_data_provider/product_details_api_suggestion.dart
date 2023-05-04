import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:flutter/material.dart';

class ProductDetailsApiSuggestion {
  static Future<Response?> getProductDetailsApi(
      {required BuildContext context, int? productId}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale!.languageCode}${Commons.apiVersion}/productMobile/$productId?accountId=${Commons.accountId}",
        options: Options());
  }
}
