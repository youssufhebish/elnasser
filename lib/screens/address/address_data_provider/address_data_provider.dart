import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/address_model/edit_address_model.dart';
import 'package:elnasser/models/address_model/submit_address_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class AddressDataProvider {
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

  static Future<Response?> AddAddressApi(
      {required BuildContext context,
      required SubmitAddressModel submitAddressModel}) async {
    Dio dio = Dio();

    var body = jsonEncode(submitAddressModel);

    return await dio.post(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale?.languageCode}${Commons.apiVersion}/storeCutomerAddress",
        data: body,
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> EditAddressApi(
      {required BuildContext context,
      required EditAddressModel editAddressModel}) async {
    Dio dio = Dio();

    var body = jsonEncode(editAddressModel);
    print("body");
    print(body);
    return await dio.post(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale?.languageCode}${Commons.apiVersion}/updateCutomerAddress",
        data: body,
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> DeleteAddressApi(
      {required BuildContext context, required String addressId}) async {
    Dio dio = Dio();

    return await dio.post(
        "${Commons.baseUrl}${EasyLocalization.of(context)!.currentLocale?.languageCode}${Commons.apiVersion}/deleteCutomerAddress",
        data: {
          "accountId": "${Commons.accountId}",
          "addresses_id": "$addressId"
        },
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
