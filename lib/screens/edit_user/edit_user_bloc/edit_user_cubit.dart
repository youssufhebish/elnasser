import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/edit_model.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/models/register_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/models/succes_login_model.dart';
import 'package:elnasser/screens/edit_user/edit_user_data_provider/edit_user_data_provider.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_user_state.dart';

class EditUserCubit extends Cubit<EditUserState> {
  EditUserCubit(BuildContext context) : super(EditUserStateInitial()) {
    getData(context);
  }

  static EditUserCubit get(BuildContext context) => BlocProvider.of(context);
  bool? isUserLogin = false;
  TheInitialModel theInitialModel = TheInitialModel();
  LoginSuccessModel userModel = LoginSuccessModel();
  Customer customer = Customer();
  getData(BuildContext context) async {
    PreferenceUtils.getDataFromPreferences(initialData).then((value) {
      theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
      emit(EditUserStateShared());
    });
    PreferenceUtils.getDataFromPreferences(userData).then((value) {
      if (value!.isNotEmpty) {
        userModel = LoginSuccessModel.fromJson(jsonDecode(value));
      }
      emit(EditUserStateShared());
    });
    PreferenceUtils.getDataFromPreferences(customerData).then((value) {
      customer = Customer.fromJson(jsonDecode(value!));
      print(userModel.data!.token!.accessToken);
      emit(EditUserStateShared());
    });
    PreferenceUtils.getBoolDataFromPreferences(userIsLogin).then((value) {
      isUserLogin = value != null ? value : false;
      emit(EditUserStateShared());
    });
  }

  String? gander;
  ErrorModel errorModel = ErrorModel();
  getGander(String value) {
    gander = value;
    print(gander);
    emit(EditUserStateGander());
  }

  LoginSuccessModel? loginSuccessModel;
  Future<void> editUserMethod(
      {required BuildContext context,
      required String? email,
      required String name,
      required String phone,
      required String countryCode,
      String? dateOfBirth}) async {
    emit(EditUserStateUpdateLoading());
    EditModel editModel = EditModel();
    editModel.accountId = theInitialModel.data!.account!.accountsId;
    editModel.customersPhone = phone;
    editModel.customersCountryCode = countryCode;
    editModel.customersName = name;
    editModel.customersEmail = email;
    editModel.customersGender =
        gander != null ? gander : customer.customersGender;
    editModel.customersBirthday = dateOfBirth;

    Loader.showLoader(context);
    Response? response = await EditUserDataProvider.editUserApi(
        context: context, registerModel: editModel);

    print("EditData");
    print(response!.data);
    print("Edit");

    if (response.statusCode == 200) {
      if (response.data["status"] == 200) {
        PreferenceUtils.storeDataToPreferences(
            customerData, jsonEncode(response.data["data"]["customer"]));

        PreferenceUtils.storeBoolDataToPreferences(userIsLogin, true);

        emit(EditUserStateUpdateSuccess());
        Loader.hideLoader(context);
      } else {
        errorModel = ErrorModel.fromJson(response.data);
        Loader.hideLoader(context);
        emit(EditUserStateUpdateFail());
      }
    } else {
      Loader.hideLoader(context);
      emit(EditUserStateUpdateFail());
    }
  }

  Future<void> changePassword(
      {required BuildContext context,
      required String oldPassword,
      required String newPassword}) async {
    emit(EditUserStateChangeLoading());

    Loader.showLoader(context);

    Response? response = await EditUserDataProvider.changePassword(
        context: context, oldPassword: oldPassword, newPassword: newPassword);

    if (response?.statusCode == 200) {
      if (response!.data["status"] == 200) {
        Loader.hideLoader(context);
        print("response.data Change password");
        print(response.data);
        print("response.data Change password");
        PreferenceUtils.storeDataToPreferences(
            userData, jsonEncode(response.data));
        PreferenceUtils.storeDataToPreferences(
            customerData, jsonEncode(response.data["data"]["customer"]));
        PreferenceUtils.storeBoolDataToPreferences(userIsLogin, true);
        // HomeMobileCubit.get(context).getData(context);
        emit(EditUserStateChangeSuccess());
      } else {
        Loader.hideLoader(context);
        print(response.data);
        errorModel = ErrorModel.fromJson(response.data);
        emit(EditUserStateChangeFail());
      }
    } else {
      Loader.hideLoader(context);

      emit(EditUserStateChangeFail());
    }
  }
}
