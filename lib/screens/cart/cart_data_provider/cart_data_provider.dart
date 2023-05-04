import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/cart_model/add_coupon_model.dart';
import 'package:elnasser/models/cart_model/add_to_cart_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class CartDataProvider {
  static Future<Response?> addToCartApi(
      {required BuildContext context,
      required AddToCartModel addToCartModel}) async {
    Dio dio = Dio();
    var body = jsonEncode(addToCartModel);

    return await dio.post(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/addToCart",
        data: body,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> addCouponApi(
      {required BuildContext context,
      required AddCouponModel addCouponModel}) async {
    Dio dio = Dio();
    var body = jsonEncode(addCouponModel);

    print(body);

    return await dio.post(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/addCoupon",
        data: body,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> removeCouponApi(
      {required BuildContext context}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/removeCoupon?accountId=${Commons.accountId}&device_token=${await PreferenceUtils.getDataFromPreferences(deviceId)}",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> getCartApi({required BuildContext context}) async {
    Dio dio = Dio();
    print(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/getCart?accountId=${Commons.accountId}&device_token=${await PreferenceUtils.getDataFromPreferences(deviceId)}");
    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/getCart?accountId=${Commons.accountId}&device_token=${await PreferenceUtils.getDataFromPreferences(deviceId)}",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": HomeMobileCubit.get(context).isUserLogin == true
                ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
                : ""
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
  }

  static Future<Response?> deleteCartApi(
      {required BuildContext context, required String itemId}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/deleteFromCart?accountId=${Commons.accountId}&device_token=${await PreferenceUtils.getDataFromPreferences(deviceId)}&carts_items_id=$itemId",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
