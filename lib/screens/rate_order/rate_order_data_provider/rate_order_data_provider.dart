import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/rate_order/rate_order_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class RateOrderDataProvider {
  static Future<Response?> AddOrderRate(
      {required BuildContext context,
      required RateOrderModel rateOrderModel}) async {
    Dio dio = Dio();
    var body = jsonEncode(rateOrderModel);

    print("bodybodybody");
    print(body);
    print("bodybodybody");
    return await dio.post(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/OrderRate",
        data: body,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
