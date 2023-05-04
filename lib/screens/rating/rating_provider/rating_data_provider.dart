import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/rating/add_rating.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class RatingDataProvider {
  static Future<Response?> getRating(
      {required BuildContext context,
      required int page,
      required String orderId}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/productRatings/$orderId?accountId=${Commons.accountId}&page=$page",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> addRating(
      {BuildContext? context, required AddRatingModel addRatingModel}) async {
    Dio dio = Dio();

    var data = jsonEncode(addRatingModel);
    print(data);

    return await dio.post(
        "${Commons.baseUrl}en${Commons.apiVersion}/productRate",
        data: addRatingModel,
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context!).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
