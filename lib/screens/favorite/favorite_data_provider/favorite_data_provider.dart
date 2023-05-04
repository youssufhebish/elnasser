import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class FavoriteDataProvider {
  static Future<Response?> addToFavoriteApi(
      {required BuildContext context, required String id}) async {
    Dio dio = Dio();

    return await dio.post(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/updateFavs",
        data: {"productId": "$id", "accountId": "${Commons.accountId}"},
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> getFavorite({required BuildContext context}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/customerFavs?accountId=${Commons.accountId}",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
