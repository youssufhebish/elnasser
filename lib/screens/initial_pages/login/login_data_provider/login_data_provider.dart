import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginDataProvider {
  static Future<Response?> loginApi(
      {required BuildContext context, required LoginModel loginModel}) async {
    Dio dio = Dio();

    var data = jsonEncode(loginModel);
    print(data);

    return await dio.post(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale?.languageCode}${Commons.apiVersion}/login",
        data: loginModel,
        options: Options());
  }
}
