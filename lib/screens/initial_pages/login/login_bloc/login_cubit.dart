import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/models/login_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/models/succes_login_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/login/login_bloc/login_state.dart';
import 'package:elnasser/screens/initial_pages/login/login_data_provider/login_data_provider.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginStateInitial()) {
    getData();
  }
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  TheInitialModel theInitialModel = TheInitialModel();
  getData() async {
    PreferenceUtils.getDataFromPreferences(initialData).then((value) {
      theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
      emit(LoginStateShared());
    });
  }

  ErrorModel? errorModel;

  String? countryCode = "+20";

  getCountryCode(String value) {
    countryCode = value;
    emit(LoginStateCountryCode());
  }

  LoginSuccessModel? loginSuccessModel;
  Future<void> submitLogin(
      {required BuildContext context,
      required String phone,
      required String password}) async {
    emit(LoginStateLoading());
    LoginModel loginModel = LoginModel();
    loginModel.accountId = theInitialModel.data!.account!.accountsId;
    loginModel.customersPhone = phone;
    loginModel.customersCountryCode = countryCode;

    loginModel.password = password;
    loginModel.deviceToken = await FirebaseMessaging.instance.getToken();

    Loader.showLoader(context);
    Response? response = await LoginDataProvider.loginApi(
        context: context, loginModel: loginModel);

    if (response!.statusCode == 200) {
      if (response.data["status"] == 200) {
        loginSuccessModel = LoginSuccessModel.fromJson(response.data);
        print(response.data);
        PreferenceUtils.storeDataToPreferences(
            userData, jsonEncode(response.data));
        PreferenceUtils.storeDataToPreferences(
            customerData, jsonEncode(response.data["data"]["customer"]));
        PreferenceUtils.storeBoolDataToPreferences(userIsLogin, true);
        HomeMobileCubit.get(context).getData(context);
        Loader.hideLoader(context);
        emit(LoginStateSuccess());
      } else {
        errorModel = ErrorModel.fromJson(response.data);
        Loader.hideLoader(context);
        emit(LoginStateFailed());
      }
    } else {
      Loader.hideLoader(context);
      emit(LoginStateFailed());
    }
  }
}
