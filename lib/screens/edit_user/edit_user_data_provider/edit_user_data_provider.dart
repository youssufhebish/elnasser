import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/edit_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class EditUserDataProvider {
  static Future<Response?> editUserApi(
      {BuildContext? context, required EditModel registerModel}) async {
    Dio dio = Dio();

    var data = jsonEncode(registerModel);
    print(data);

    return await dio.post(
        "${Commons.baseUrl}${Commons.getLanguage(context!)}${Commons.apiVersion}/customerUpdate",
        data: registerModel,
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> changePassword(
      {required BuildContext context,
      required String oldPassword,
      required String newPassword}) async {
    Dio dio = Dio();
    return await dio.post(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/changePassword",
        data: {
          "accountId": "${Commons.accountId}",
          "old_password": "$oldPassword",
          "new_password": "$newPassword"
        },
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
