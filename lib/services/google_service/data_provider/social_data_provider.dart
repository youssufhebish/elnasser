import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/socila_login_model.dart';
import 'package:flutter/material.dart';

class SocialLoginDataProvider {
  static Future<Response?> loginSocialApi(
      {required BuildContext context,
      required SocilaLoginModel loginModel}) async {
    Dio dio = Dio();

    var data = jsonEncode(loginModel);
    print(data);

    return await dio.post(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale?.languageCode}${Commons.apiVersion}/socialLogin",
        data: loginModel,
        options: Options());
  }
}
