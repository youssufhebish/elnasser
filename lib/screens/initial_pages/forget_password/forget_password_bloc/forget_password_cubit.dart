import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/models/forget_password_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/initial_pages/forget_password/forget_password_bloc/forget_password_state.dart';
import 'package:elnasser/screens/initial_pages/forget_password/forget_password_data_provider/forget_password_data_provider.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/sms_bloc/sms_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState()) {
    getData();
  }

  static ForgetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);
  TheInitialModel theInitialModel = TheInitialModel();
  getData() async {
    PreferenceUtils.getDataFromPreferences(initialData).then((value) {
      theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
      emit(ForgetPasswordSharedState());
    });
  }

  ErrorModel? errorModel;

  Future<void> changePassword(
      {required BuildContext context,
      required String phone,
      required String password}) async {
    emit(ForgetPasswordLoadingState());
    ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel();

    Loader.showLoader(context);
    forgetPasswordModel.customersCountryCode =
        SmsCubit.get(context).countryCode;
    forgetPasswordModel.customersPhone = phone;
    forgetPasswordModel.accountId = theInitialModel.data!.account!.accountsId;
    forgetPasswordModel.password = password;

    Response? response = await ForgetPasswordDataProvider.ForgetPasswordApi(
        context: context, forgetPasswordModel: forgetPasswordModel);

    print(jsonEncode(forgetPasswordModel));

    print(response!.data);

    if (response.statusCode == 200) {
      if (response.data["status"] == 200) {
        emit(ForgetPasswordSuccessState());
      } else {
        Loader.hideLoader(context);
        errorModel = ErrorModel.fromJson(response.data);
        emit(ForgetPasswordFailedState());
      }
    } else {
      Loader.hideLoader(context);

      emit(ForgetPasswordFailedState());
    }
  }
}
