import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/point_model/point_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/models/succes_login_model.dart';
import 'package:elnasser/screens/points_screen/point_bloc/point_state.dart';
import 'package:elnasser/screens/points_screen/point_methods/point_data_provider.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class PointCubit extends Cubit<PointState> {
  PointCubit() : super(PointStateInitial()) {
    getData();
  }
  static PointCubit get(BuildContext context) => BlocProvider.of(context);

  bool? isUserLogin = false;
  TheInitialModel theInitialModel = TheInitialModel();
  LoginSuccessModel userModel = LoginSuccessModel();
  Customer customer = Customer();
  getData() async {
    PreferenceUtils.getDataFromPreferences(userData).then((value) {
      if (value!.isNotEmpty) {
        userModel = LoginSuccessModel.fromJson(jsonDecode(value));
      }
      emit(PointStateShared());
    });
    PreferenceUtils.getDataFromPreferences(customerData).then((value) {
      customer = Customer.fromJson(jsonDecode(value!));
      print(userModel.data!.token!.accessToken);
      emit(PointStateShared());
    });

    PreferenceUtils.getBoolDataFromPreferences(userIsLogin).then((value) {
      isUserLogin = value != null ? value : false;
      emit(PointStateShared());
    });
  }

  pointsModel pointModel = pointsModel();

  // List<Level> nextPointLevel =[];
  Future<void> getPoints(BuildContext context) async {
    emit(PointStateLoading());

    Response? response = await PointDataProvider.getPoints(context: context);

    pointModel = pointsModel.fromJson(response?.data);
    print(pointModel.status);

    if (pointModel.status == 200) {
      // pointModel.data!.pointLevels!.forEach((element) {  nextPointLevel.add(element);});

      // PointCubit.get(context).nextPointLevel.removeWhere((element) => (element.pointsLevelsId == PointCubit.get(context).pointModel.data!.customerLevel!.pointsLevelsId));
      emit(PointStateSuccess());
      // AddToCartCubit.get(context).getCart(context: context);

    } else {
      emit(PointStateFailed());
    }
  }

  List<Widget> points = [
    ImageView(
      path: ImageConstants.bronzePoint,
      width: 8.h,
      height: 8.h,
    ),
    ImageView(
      path: ImageConstants.silverPoint,
      width: 8.h,
      height: 8.h,
    ),
    ImageView(
      path: ImageConstants.goldPoint,
      width: 8.h,
      height: 8.h,
    )
  ];
}
