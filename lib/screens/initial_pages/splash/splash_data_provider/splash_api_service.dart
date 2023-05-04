import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class SplashApiService {
  static Future<Response?> getInitialApi(
      {required BuildContext context}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale!.languageCode}${Commons.apiVersion}/initial?accountId=${Commons.accountId}",
        options: Options(headers: {
          // "Authorization": HomeMobileCubit.get(context).isUserLogin == true ?"Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}":""
        }));
  }
}
