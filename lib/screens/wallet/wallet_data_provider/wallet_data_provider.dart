import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class WalletDataProvider {
  static Future<Response?> getWallet(
      {required BuildContext context,
      required int pageIndex,
      String? title}) async {
    Dio dio = Dio();
    print(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/getCustomerWallet?accountId=${Commons.accountId}&page=$pageIndex");
    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/getCustomerWallet?accountId=${Commons.accountId}&page=$pageIndex",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
