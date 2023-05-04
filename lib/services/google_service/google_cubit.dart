import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/models/social_model_response_model.dart';
import 'package:elnasser/models/socila_login_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/models/succes_login_model.dart';
import 'package:elnasser/services/google_service/google_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_provider/social_data_provider.dart';

class GoogleServiceCubit extends Cubit<GoogleServiceState> {
  GoogleServiceCubit() : super(GoogleServiceStateInitial()) {
    getData();
  }
  static GoogleServiceCubit get(BuildContext context) =>
      BlocProvider.of(context);

  TheInitialModel theInitialModel = TheInitialModel();
  getData() async {
    PreferenceUtils.getDataFromPreferences(initialData).then((value) {
      theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
      emit(GoogleServiceStateShared());
    });
  }

  LoginSuccessModel? loginSuccessModel;
  ErrorModel? errorModel;

  Future<void> submitLogin(
      {required BuildContext context,
      required String name,
      String? email,
      String? provider,
      String? providerId,
      required User user}) async {
    emit(GoogleServiceStateLoading());
    SocialResponseModel socialResponseModel = SocialResponseModel();
    socialResponseModel.uid = user.uid;
    socialResponseModel.email = user.email;
    socialResponseModel.displayName = user.displayName;
    socialResponseModel.phoneNumber = user.phoneNumber;
    socialResponseModel.photoURL = user.photoURL;
    socialResponseModel.emailVerified = user.emailVerified;
    socialResponseModel.isAnonymous = user.isAnonymous;
    socialResponseModel.creationTime = "${user.metadata.creationTime}";
    socialResponseModel.lastSignInTime = "${user.metadata.lastSignInTime}";
    socialResponseModel.providerId = user.providerData.first.providerId;
    socialResponseModel.userId = user.providerData.first.uid;

    SocilaLoginModel socialLogin = SocilaLoginModel();
    socialLogin.accountId = Commons.accountId;
    socialLogin.customersName = name;
    socialLogin.customersEmail = email;

    socialLogin.provider = provider;
    socialLogin.providerId = providerId;
    socialLogin.deviceType = "phone";
    socialLogin.socialResponseModel = jsonEncode(socialResponseModel);
    socialLogin.deviceToken = await FirebaseMessaging.instance.getToken();

    Response? response = await SocialLoginDataProvider.loginSocialApi(
        context: context, loginModel: socialLogin);

    if (response!.statusCode == 200) {
      if (response.data["status"] == 200) {
        loginSuccessModel = LoginSuccessModel.fromJson(response.data);
        print(response.data);
        PreferenceUtils.storeDataToPreferences(
            userData, jsonEncode(response.data));
        PreferenceUtils.storeDataToPreferences(
            customerData, jsonEncode(response.data["data"]["customer"]));
        PreferenceUtils.storeBoolDataToPreferences(userIsLogin, true);
        emit(GoogleServiceStateSuccess());
      } else {
        errorModel = ErrorModel.fromJson(response.data);
        emit(GoogleServiceStateFailed());
      }
    } else {
      emit(GoogleServiceStateFailed());
    }
  }
}
