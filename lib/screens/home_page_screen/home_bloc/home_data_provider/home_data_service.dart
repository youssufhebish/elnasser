import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/succes_login_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class HomeApiService {
  static Future<Response?> getHome(
      {required BuildContext context,
      required LoginSuccessModel userModel,
      required isUserLogin}) async {
    Dio dio = Dio();

    print('Userrrrr');
    print(isUserLogin == true
        ? "Bearer ${userModel.data!.token!.accessToken}"
        : "");
    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/home?accountId=${Commons.accountId}",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": isUserLogin == true
              ? "Bearer ${userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
