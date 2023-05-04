import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/branches_model/branches_model.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/beanches/branches_bloc/branches_state.dart';
import 'package:elnasser/screens/beanches/branches_data_provider/beanches_data_provider.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as des;
import 'package:location/location.dart';
import 'dart:math';

import '../branches_widget/branches_widget.dart';

class BranchesCubit extends Cubit<BranchesState> {
  BranchesCubit() : super(BranchesStateInitial()) {
    getData();
  }

  static BranchesCubit get(BuildContext context) => BlocProvider.of(context);

  // Completer<GoogleMapController> controller = Completer();
  /// get Location //
  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData locationData;
  getLocationService(BuildContext context) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        DataErrorAlert.LocationError(
            title: "",
            data: "pleaseAllowLocationPermission".tr().toString(),
            colorValue: SplashCubit.get(context)
                .theInitialModel
                .data!
                .account!
                .mobileAppColors,
            context: context);
      }
    }

    locationData = await location.getLocation();
    print(locationData.longitude);
    emit(BranchesStateGetLocation());
  }

  /// done ///
  /////
  /// get nearest point ///
  ///   List<LatLng> nearestPointList = [];
  List<double> meterList = [];
  double minDistance = 99999999999;
  double meter = 0;
  final des.Distance distance = des.Distance();
  List<LatLng> nearestPointList = [];

  getNearestPoint(BuildContext context) async {
    getLocationService(context);

    await Future.delayed(Duration(milliseconds: 400));

    branchesModel.data!.branches!.forEach((element) {
      meter = distance(
          des.LatLng(locationData.latitude!, locationData.longitude!),
          des.LatLng(double.parse('${element.branchesGps!.split(",")[0]}'),
              double.parse('${element.branchesGps!.split(",")[1]}')));
      if (minDistance >= meter) {
        nearestPointList.add(LatLng(
            double.parse('${element.branchesGps!.split(",")[0]}'),
            double.parse('${element.branchesGps!.split(",")[1]}')));
        meterList.add(meter);

        minDistance = meter;
      }
    });
    print("nearestPointList.last");
    print(meterList.toSet());
    print(nearestPointList.last);
    newCameraPosition(
        nearestPointList.last.latitude, nearestPointList.last.longitude);
    value = null;
    emit(BranchesStateNearest());
  }

  ///

  bool? isUserLogin = false;
  TheInitialModel theInitialModel = TheInitialModel();
  getData() async {
    PreferenceUtils.getDataFromPreferences(initialData).then((value) {
      theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
      emit(BranchesStateShared());
    });

    PreferenceUtils.getBoolDataFromPreferences(userIsLogin).then((value) {
      isUserLogin = value != null ? value : false;
      emit(BranchesStateShared());
    });
  }

  List<Marker> branches = [];
  BranchesModel branchesModel = BranchesModel();
  addBranches(
      {required BuildContext context,
      required ColorsInitialValue colorsValue}) async {
    emit(BranchesStateBranchesLoading());
    Response? response =
        await BranchesDataProvider.getBranchesApi(context: context);
    if (response!.statusCode == 200 && response.data["status"] == 200) {
      branches.clear();

      branchesModel = BranchesModel.fromJson(response.data);

      branchesModel.data != null
          ? branchesModel.data!.branches!.forEach((element) {
              print(element.branchesGps);
              element.branchesGps != null
                  ? branches.add(Marker(
                      onTap: () async {
                        showDraggableSheet().showSheet(
                            context: context,
                            branch: element,
                            colorsValue: colorsValue);
                      },
                      markerId: MarkerId("${element.branchesId}"),
                      position: LatLng(
                          double.parse("${element.branchesGps!.split(",")[0]}"),
                          double.parse(
                              "${element.branchesGps!.split(",")[1]}")),
                      infoWindow: InfoWindow(title: element.branchesTitle)))
                  : print("");
            })
          : print("");

      emit(BranchesStateBranchesSuccess());
    } else {
      emit(BranchesStateBranchesFail());
    }
  }

  CityModel? value;
  getCityBranchesLatLong(int cityId) {
    Branch branch = Branch();
    branch = branchesModel.data!.branches!
        .firstWhere((element) => int.parse("${element.fkCitiesId}") == cityId);
    print(branch.branchesGps);
    newCameraPosition(double.parse("${branch.branchesGps!.split(",")[0]}"),
        double.parse("${branch.branchesGps!.split(",")[1]}"));
    emit(BranchesStateGetCity());
  }

  GoogleMapController? mapController;
  getController(GoogleMapController controller, BuildContext context) {
    mapController = controller;
    getLocationService(context);
    emit(BranchesStateGetController());
  }

  newCameraPosition(double lat, double lng) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 270.0,
          target: LatLng(lat, lng),
          tilt: 30.0,
          zoom: 12.0,
        ),
      ),
    );
  }
}

class showDraggableSheet {
  showSheet(
      {required BuildContext context,
      required Branch branch,
      required ColorsInitialValue colorsValue}) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8), topLeft: Radius.circular(8))),
        context: context,
        builder: (context) => BranchesWidget(
              branch: branch,
              colorsValue: colorsValue,
            ));
  }
}
