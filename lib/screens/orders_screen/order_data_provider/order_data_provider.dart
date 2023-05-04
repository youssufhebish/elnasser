import 'package:dio/dio.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class OrderDataProvider {
  static Future<Response?> getOrders({required BuildContext context}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/getOrders?accountId=${Commons.accountId}",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> getOrderDetails(
      {required BuildContext context, required String orderId}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/getOrder?accountId=${Commons.accountId}&orderId=$orderId",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> ReOrder(
      {required BuildContext context, required String orderId}) async {
    Dio dio = Dio();

    return await dio.post(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/reOrder",
        data: {
          "accountId": "${Commons.accountId}",
          "device_token":
              "${await PreferenceUtils.getDataFromPreferences(deviceId)}",
          "orderId": "${orderId}"
        },
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> CancelOrder(
      {required BuildContext context, required String orderId}) async {
    Dio dio = Dio();

    return await dio.post(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/cancelOrder?accountId=${Commons.accountId}&orderId=$orderId",
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> RefundOrder(
      {required BuildContext context,
      required String orderId,
      required String note,
      required ids}) async {
    Dio dio = Dio();

    return await dio.post(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/postReturnOrder",
        data: {
          "accountId": "${Commons.accountId}",
          "order_return_requests_reason": "$note",
          "orders_id": "${orderId}",
          "FK_items_ids": "${ids}"
        },
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
