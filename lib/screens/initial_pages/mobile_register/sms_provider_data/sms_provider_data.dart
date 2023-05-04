import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/check_phone_number_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';

class SmsProviderData {
  static Future<Response?> checkPhoneNumberApi(
      {required BuildContext context,
      required CheckPhoneNumberModel checkPhoneNumberModel}) async {
    Dio dio = Dio();
    var data = jsonEncode(checkPhoneNumberModel);
    print(data);
    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/checkPhoneNumber?accountId=${Commons.accountId}&phone=${checkPhoneNumberModel.customersPhone}&customers_country_code=${checkPhoneNumberModel.customersCountryCode}",
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }

  static Future<Response?> SendSmsApi(
      {required BuildContext context,
      required CheckPhoneNumberModel checkPhoneNumberModel}) async {
    Dio dio = Dio();
    var data = jsonEncode(checkPhoneNumberModel);
    print(data);
    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/sendSMS?accountId=${Commons.accountId}&phone=${checkPhoneNumberModel.customersCountryCode}${checkPhoneNumberModel.customersPhone}",
        options: Options(headers: {}));
  }

  static Future<Response?> checkCode(
      {required BuildContext context,
      required String countryCode,
      required String phone,
      required String code}) async {
    Dio dio = Dio();

    return await dio.get(
        "${Commons.baseUrl + Commons.getLanguage(context) + Commons.apiVersion}/checkVerifyCode?accountId=${Commons.accountId}&phone=${countryCode + phone}&verify_code=$code",
        options: Options(headers: {
          "Authorization": HomeMobileCubit.get(context).isUserLogin == true
              ? "Bearer ${HomeMobileCubit.get(context).userModel.data!.token!.accessToken}"
              : ""
        }));
  }
}
