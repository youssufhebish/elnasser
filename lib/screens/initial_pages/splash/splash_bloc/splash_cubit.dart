import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_cubit.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/beanches/branches_bloc/branches_cubit.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/categories/category_bloc/category_cubit.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_data_provider/splash_api_service.dart';
import 'package:elnasser/screens/notification/notification_bloc/notification_cubit.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_bloc.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_bloc_state.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_event.dart';
import 'package:elnasser/screens/points_screen/point_bloc/point_cubit.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(BuildContext context) : super(SplashInitial()) {
    // getInitial(context);
  }

  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  TheInitialModel theInitialModel = TheInitialModel();

  Future<void> getInitial(BuildContext context) async {
    emit(SplashLoading());

    Response? response = await SplashApiService.getInitialApi(context: context);

    theInitialModel = TheInitialModel.fromJson(response?.data);

    print("Geting the initial ");
    print(theInitialModel.data!.setting!.settingsCurrency);
    print("Geting the initial ");

    if (theInitialModel.status == 200) {
      PreferenceUtils.storeDataToPreferences(
          initialData, jsonEncode(response?.data));

      emit(SplashSuccess());
    } else {
      emit(SplashFailure());
    }
  }

  getAppData({required BuildContext context}) async {
    HomeMobileCubit.get(context).getData(context);
    FilterCubit.get(context).getFilter(context);
    await Future.delayed(Duration(milliseconds: 50));
    HomeMobileCubit.get(context).getMobileHome(context);
    CategoryListCubit.get(context).getCategoriesList(context);

    emit(SplashGetAppData());
  }

//// language

}
