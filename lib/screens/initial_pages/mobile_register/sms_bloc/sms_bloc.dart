import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/check_phone_number_model.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/sms_bloc/sms_state.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/sms_provider_data/sms_provider_data.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_data_provider/splash_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmsCubit extends Cubit<SmsState> {
  SmsCubit() : super(SmsStateInitial()) {
    getData();
  }

  static SmsCubit get(BuildContext context) => BlocProvider.of(context);
  TheInitialModel theInitialModel = TheInitialModel();
  getData() async {
    PreferenceUtils.getDataFromPreferences(initialData).then((value) {
      theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
      emit(SmsStateShared());
    });
  }

  ErrorModel? errorModel;

  String? countryCode = "+20";

  getCountryCode(String value) {
    countryCode = value;
    emit(SmsStateCountryCode());
  }

  /// Check if phone exists for register
  Future<void> checkPhoneNumRegister(
      {required BuildContext context, required String phone}) async {
    emit(SmsStateLoading());
    CheckPhoneNumberModel checkPhoneNumberModel = CheckPhoneNumberModel();

    Loader.showLoader(context);
    checkPhoneNumberModel.customersCountryCode = countryCode;
    checkPhoneNumberModel.customersPhone = phone;
    checkPhoneNumberModel.accountId = theInitialModel.data!.account!.accountsId;

    Response? response = await SmsProviderData.checkPhoneNumberApi(
        context: context, checkPhoneNumberModel: checkPhoneNumberModel);

    if (response?.statusCode == 200) {
      if (response!.data["status"] == 200 || response.data["status"] == 422) {
        Loader.hideLoader(context);
        errorModel = ErrorModel.fromJson(response.data);

        emit(SmsStateFailure());
      } else {
        Loader.hideLoader(context);
        emit(SmsStateSuccess());
      }
    } else {
      Loader.hideLoader(context);

      emit(SmsStateFailure());
    }
  }

  /// Check if phone exists for forget password
  Future<void> checkPhoneNumForgetPassword(
      {required BuildContext context, required String phone}) async {
    emit(SmsStateLoading());
    CheckPhoneNumberModel checkPhoneNumberModel = CheckPhoneNumberModel();

    Loader.showLoader(context);
    checkPhoneNumberModel.customersCountryCode = countryCode;
    checkPhoneNumberModel.customersPhone = phone;
    checkPhoneNumberModel.accountId = theInitialModel.data!.account!.accountsId;

    Response? response = await SmsProviderData.checkPhoneNumberApi(
        context: context, checkPhoneNumberModel: checkPhoneNumberModel);

    if (response?.statusCode == 200) {
      if (response!.data["status"] == 200) {
        Loader.hideLoader(context);

        emit(SmsStateForgetSuccess());
      } else {
        Loader.hideLoader(context);
        print(response.statusCode);
        print(response.data);
        errorModel = ErrorModel.fromJson(response.data);

        emit(SmsStateForgetFailure());
      }
    } else {
      Loader.hideLoader(context);

      emit(SmsStateForgetFailure());
    }
  }

  /// Send Sms
  Future<void> sendSms(
      {required BuildContext context, required String phone}) async {
    emit(SmsStateSendLoading());
    CheckPhoneNumberModel checkPhoneNumberModel = CheckPhoneNumberModel();

    Loader.showLoader(context);
    checkPhoneNumberModel.customersCountryCode = countryCode;
    checkPhoneNumberModel.customersPhone = phone;
    checkPhoneNumberModel.accountId = theInitialModel.data!.account!.accountsId;

    Response? response = await SmsProviderData.SendSmsApi(
        context: context, checkPhoneNumberModel: checkPhoneNumberModel);

    if (response?.statusCode == 200) {
      if (response!.data["status"] == 200) {
        Loader.hideLoader(context);
        print(response.data);
        emit(SmsStateSendSuccess());
      } else {
        Loader.hideLoader(context);
        print(response.data);
        errorModel = ErrorModel.fromJson(response.data);

        emit(SmsStateSendFailure());
      }
    } else {
      Loader.hideLoader(context);

      emit(SmsStateSendFailure());
    }
  }

  /// Check if Sms Valid
  Future<void> checkSms(
      {required BuildContext context,
      required String phone,
      required String code}) async {
    emit(SmsStateCheckCodeLoading());
    CheckPhoneNumberModel checkPhoneNumberModel = CheckPhoneNumberModel();

    Loader.showLoader(context);

    Response? response = await SmsProviderData.checkCode(
      context: context,
      phone: phone,
      code: code,
      countryCode: countryCode!,
    );

    if (response?.statusCode == 200) {
      if (response!.data["status"] == 200) {
        Loader.hideLoader(context);
        print(response.data);
        emit(SmsStateCheckCodeSuccess());
      } else {
        Loader.hideLoader(context);
        errorModel = ErrorModel.fromJson(response.data);

        emit(SmsStateCheckCodeFailure());
      }
    } else {
      Loader.hideLoader(context);

      emit(SmsStateCheckCodeFailure());
    }
  }
}
