import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class ProductPagePaginationDataProvider {
  static Future<Response?> getNewArrival(
      {required BuildContext context, required int pageIndex}) async {
    Dio dio = Dio();
    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/products?accountId=${Commons.accountId}&page=$pageIndex&orderBy=recently",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
