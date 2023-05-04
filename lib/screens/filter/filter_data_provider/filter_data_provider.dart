import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class FilterDataProvider {
  static Future<Response?> getFilter({required BuildContext context}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/filterData?accountId=${Commons.accountId}",
        options: Options(headers: {
          "Accept": "application/json",
          // "Authorization": HomeMobileCubit.get(context).isUserLogin == true ?"Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}":""
        }));
  }
}
