import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/models/register_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/models/succes_login_model.dart';
import 'package:elnasser/screens/initial_pages/register/register_bloc/register_state.dart';
import 'package:elnasser/screens/initial_pages/register/register_data_provider/register_data_provider.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterStateInitial()) {
    getData();
  }
  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  TheInitialModel theInitialModel = TheInitialModel();
  getData() async {
    PreferenceUtils.getDataFromPreferences(initialData).then((value) {
      theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
      emit(RegisterStateShared());
    });
  }

  ErrorModel? errorModel;

  String? gander;

  getGander(String value) {
    gander = value;
    print(gander);
    emit(RegisterStateGander());
  }

  LoginSuccessModel? loginSuccessModel;
  Future<void> submitRegister(
      {required BuildContext context,
      required String email,
      required String name,
      required String phone,
      required String countryCode,
      String? dateOfBirth,
      required String password}) async {
    emit(RegisterStateLoading());
    RegisterModel registerModel = RegisterModel();
    registerModel.accountId = theInitialModel.data!.account!.accountsId;
    registerModel.customersPhone = phone;
    registerModel.customersCountryCode = countryCode;
    registerModel.customersName = name;
    registerModel.customersEmail = email;
    registerModel.password = password;
    registerModel.customersGender = gander;
    registerModel.customersBirthday = dateOfBirth;
    registerModel.deviceToken = await FirebaseMessaging.instance.getToken();

    Loader.showLoader(context);
    Response? response = await RegisterDataProvider.registerApi(
        context: context, registerModel: registerModel);

    if (response!.statusCode == 200) {
      if (response.data["status"] == 200) {
        loginSuccessModel = LoginSuccessModel.fromJson(response.data);
        print(response.data);
        PreferenceUtils.storeDataToPreferences(
            userData, jsonEncode(response.data));
        PreferenceUtils.storeDataToPreferences(
            customerData, jsonEncode(response.data["data"]["customer"]));
        PreferenceUtils.storeBoolDataToPreferences(userIsLogin, true);
        Loader.hideLoader(context);
        emit(RegisterStateSuccess());
      } else {
        errorModel = ErrorModel.fromJson(response.data);
        Loader.hideLoader(context);
        emit(RegisterStateFailed());
      }
    } else {
      Loader.hideLoader(context);
      emit(RegisterStateFailed());
    }
  }
}
