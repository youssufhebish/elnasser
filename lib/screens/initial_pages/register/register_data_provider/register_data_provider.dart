import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/register_model.dart';
import 'package:flutter/material.dart';

class RegisterDataProvider {
  static Future<Response?> registerApi(
      {BuildContext? context, required RegisterModel registerModel}) async {
    Dio dio = Dio();

    var data = jsonEncode(registerModel);
    print(data);

    return await dio.post("${Commons.baseUrl}en${Commons.apiVersion}/register",
        data: registerModel, options: Options());
  }
}
