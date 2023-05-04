import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class SearchResultDataProvider {
  static Future<Response?> getFilterData(
      {required BuildContext context,
      required int pageIndex,
      String? maxPrice,
      String? minPrice,
      String? sortBy,
      String? brandsIds,
      String? sizesIds,
      String? categoryIds,
      String? offersIds,
      String? attributeIds}) async {
    print(sortBy);
    print(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/products?accountId=${Commons.accountId}&page=$pageIndex&min_price=$minPrice&max_price=$maxPrice&categories=$categoryIds&choices=$sizesIds&attributes=$attributeIds&orderBy=$sortBy&brands=$brandsIds&offers=$offersIds");
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/products?accountId=${Commons.accountId}&page=$pageIndex&min_price=$minPrice&max_price=$maxPrice&categories=$categoryIds&choices=$sizesIds&attributes=$attributeIds&orderBy=$sortBy&brands=$brandsIds&offers=$offersIds",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> getSearchTitleData(
      {required BuildContext context,
      required int pageIndex,
      String? title}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/products?accountId=${Commons.accountId}&page=$pageIndex&title=$title",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
