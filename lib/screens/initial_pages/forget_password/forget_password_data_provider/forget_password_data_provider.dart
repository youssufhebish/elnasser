import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/forget_password_model.dart';
import 'package:flutter/material.dart';

class ForgetPasswordDataProvider {
  static Future<Response?> ForgetPasswordApi(
      {required BuildContext context,
      required ForgetPasswordModel forgetPasswordModel}) async {
    Dio dio = Dio();
    var data = jsonEncode(forgetPasswordModel);
    print(data);
    return await dio.post(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/forgotPasswordMobile",
        data: data,
        options: Options());
  }
}
