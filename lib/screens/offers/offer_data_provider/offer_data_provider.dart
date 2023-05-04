import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:flutter/material.dart';

class OfferDataProvider {
  static Future<Response?> getOffer(
      {required BuildContext context, required String pageIndex}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + EasyLocalization.of(context)!.currentLocale!.languageCode + Commons.apiVersion}/products?accountId=${Commons.accountId}&page=$pageIndex&is_offers=1",
        options: Options(headers: {"Accept": "application/json"}));
  }
}
