import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/cart_model/upadate_cart_review.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class CompletePaymentDataProvider {
  static Future<Response?> getAddressAndMethods(
      {required BuildContext context}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale?.languageCode}${Commons.apiVersion}/getCstomerAddresses?accountId=${Commons.accountId}",
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> updateCart(
      {required BuildContext context,
      required UpdateCartModel updateCartModel}) async {
    Dio dio = Dio();

    var body = jsonEncode(updateCartModel);

    return await dio.post(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale?.languageCode}${Commons.apiVersion}/updateCart",
        data: body,
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> postOrder({required BuildContext context}) async {
    Dio dio = Dio();

    print(
        '${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale?.languageCode}${Commons.apiVersion}/postOrder');
    return await dio.post(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale?.languageCode}${Commons.apiVersion}/postOrder",
        data: {
          "accountId": "${Commons.accountId}",
          "device_token":
              await PreferenceUtils.getDataFromPreferences(deviceId),
        },
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
