import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/contact_us_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class ConTactUsDataProvider {
  static Future<Response?> sendSuggestion(
      {required BuildContext context,
      required ContactUsModel contactUsModel}) async {
    Dio dio = Dio();

    var data = jsonEncode(contactUsModel);
    print(data);

    return await dio.post(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale?.languageCode}${Commons.apiVersion}/postContact",
        data: contactUsModel,
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
