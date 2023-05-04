import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/home_model/home_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/models/succes_login_model.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobile_state.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_data_provider/home_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMobileCubit extends Cubit<HomeMobileState> {
  HomeMobileCubit(BuildContext context) : super(HomeMobileLoadingState()) {
    getData(context);
  }
  static HomeMobileCubit get(BuildContext context) => BlocProvider.of(context);
  bool? isUserLogin = false;
  // TheInitialModel theInitialModel = TheInitialModel();
  LoginSuccessModel userModel = LoginSuccessModel();
  Customer customer = Customer();
  getData(BuildContext context) async {
    // PreferenceUtils.getDataFromPreferences(initialData).then((value) {
    //  if(value!=null){
    //    theInitialModel = TheInitialModel.fromJson(jsonDecode(value));
    //  }
    //   emit(HomeMobilePreference());
    // });
    PreferenceUtils.getDataFromPreferences(userData).then((value) {
      if (value != null && value.isNotEmpty) {
        userModel = LoginSuccessModel.fromJson(jsonDecode(value));
      }
      emit(HomeMobilePreference());
    });
    PreferenceUtils.getDataFromPreferences(customerData).then((value) {
      if (value != null && value.isNotEmpty) {
        customer = Customer.fromJson(jsonDecode(value));
      }
      emit(HomeMobilePreference());
    });
    PreferenceUtils.getBoolDataFromPreferences(userIsLogin).then((value) {
      isUserLogin = value != null ? value : false;
      emit(HomeMobilePreference());
    });
  }

  logOut() {
    PreferenceUtils.storeBoolDataToPreferences(userIsLogin, false);
    PreferenceUtils.getBoolDataFromPreferences(userIsLogin).then((value) {
      isUserLogin = value;
      emit(HomeMobilePreference());
    });
    PreferenceUtils.storeDataToPreferences(userData, null);
    PreferenceUtils.getDataFromPreferences(userData).then((value) {
      userModel = LoginSuccessModel();
      emit(HomeMobilePreference());
    });
    emit(HomeMobileLogOut());
  }

  HomeModel homeModel = HomeModel();
  Future<void> getMobileHome(BuildContext context) async {
    emit(HomeMobileLoadingState());

    Response? response = await HomeApiService.getHome(
        context: context, isUserLogin: isUserLogin, userModel: userModel);

    homeModel = HomeModel.fromJson(response!.data);

    if (response.statusCode == 200) {
      emit(HomeMobileSuccessState());
    } else {
      emit(HomeMobileErrorState());
    }
  }
}
