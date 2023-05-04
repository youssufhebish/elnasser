import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/address_model/address_model.dart';
import 'package:elnasser/models/address_model/edit_address_model.dart';
import 'package:elnasser/models/address_model/submit_address_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/models/succes_login_model.dart';
import 'package:elnasser/screens/address/address_bloc/address_state.dart';
import 'package:elnasser/screens/address/address_data_provider/address_data_provider.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_geocoder/geocoder.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(BuildContext context) : super(AddressStateGetInitial()) {
    getData();
    // getLocation(context);
  }

  static AddressCubit get(BuildContext context) => BlocProvider.of(context);

  bool? isUserLogin = false;
  TheInitialModel theInitialModel = TheInitialModel();
  LoginSuccessModel userModel = LoginSuccessModel();
  Customer customer = Customer();
  getData() async {
    PreferenceUtils.getDataFromPreferences(initialData).then((value) {
      theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
      emit(AddressStateShared());
    });
    PreferenceUtils.getDataFromPreferences(userData).then((value) {
      userModel = LoginSuccessModel.fromJson(jsonDecode(value!));
      print(userModel.data!.token!.accessToken);
      emit(AddressStateShared());
    });
    PreferenceUtils.getDataFromPreferences(customerData).then((value) {
      customer = Customer.fromJson(jsonDecode(value!));
      print(userModel.data!.token!.accessToken);
      emit(AddressStateShared());
    });
    PreferenceUtils.getBoolDataFromPreferences(userIsLogin).then((value) {
      isUserLogin = value != null ? value : false;
      emit(AddressStateShared());
    });
  }

  String _address = ""; // create this variable

  // void _getPlace() async {
  //   List<Placemark> newPlace = await _geolocator.placemarkFromCoordinates(_position.latitude, _position.longitude);
  //
  //   // this is all you need
  //   Placemark placeMark  = newPlace[0];
  //   String name = placeMark.name;
  //   String subLocality = placeMark.subLocality;
  //   String locality = placeMark.locality;
  //   String administrativeArea = placeMark.administrativeArea;
  //   String postalCode = placeMark.postalCode;
  //   String country = placeMark.country;
  //   String address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
  //
  //   print(address);
  //
  //   setState(() {
  //     _address = address; // update _address
  //   });
  // }

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

    emit(AddressStateGetLocation());
  }

  var address;
  late LatLng latLngData;
  Future getTappedLocation(LatLng latLng) async {
    latLngData = latLng;
    emit(AddressStateGetLocation());
  }

  getAddressString({double? lat, double? long}) async {
    final coordinates = new Coordinates(
        lat != null ? lat : locationData.latitude!,
        long != null ? long : locationData.longitude!);
    try {
      address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    } catch (e) {
      print(e);
    }

    emit(AddressStateGetAddressString());
    setAddressValues(address!.first);
  }

  int currentAddressIndex = -1;

  getAddress(int index) {
    currentAddressIndex = index;
    emit(AddressStateGetCurrentAddress());
  }

  AddressModel addressModel = AddressModel();
  Future<void> getAddressAndPaymentMethods(BuildContext context) async {
    emit(AddressStateAddressLoading());

    Response? response =
        await AddressDataProvider.getAddressAndMethods(context: context);
    print("Addressssss");
    print(response!.data);
    if (response.statusCode == 200) {
      if (response.data["status"] == 200) {
        addressModel = AddressModel.fromJson(response.data);

        emit(AddressStateAddressSuccess());
      } else {
        emit(AddressStateAddressFail());
      }
    } else {
      emit(AddressStateAddressFail());
    }
  }

  /// Edit And Add Address ///

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerArea = TextEditingController();
  TextEditingController controllerGov = TextEditingController();
  TextEditingController controllerStreet = TextEditingController();
  TextEditingController controllerBuilding = TextEditingController();
  TextEditingController controllerFlor = TextEditingController();
  TextEditingController controllerDepartment = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  TextEditingController controllerAddressLine = TextEditingController();

  setAddressValues(Address address) {
    controllerCity.text =
        address.subAdminArea != null ? address.subAdminArea! : "";
    controllerGov.text = address.adminArea != null ? address.adminArea! : "";
    controllerAddressLine.text =
        address.addressLine != null ? address.addressLine! : "";

    print('Controller:${address.adminArea}');

    emit(AddressStateEditAddress());
  }

  bool defaultValue = false;

  changeDefaultValue(bool value) {
    defaultValue = value;
    emit(AddressStateAddressDefaultValue());
  }

  String? countryCode = "+20";

  getCountryCode(String value) {
    countryCode = value;
    emit(AddressStateAddressCountryCode());
  }

  Future<void> SubmitAddressMethod(BuildContext context) async {
    emit(AddressStateAddressSubmitLoading());
    Loader.showLoader(context);
    SubmitAddressModel submitAddressModel = SubmitAddressModel();

    submitAddressModel.addressTitle =
        "${controllerGov.text},${controllerCity.value.text},${controllerArea.value.text},${controllerStreet.value.text},${controllerBuilding.value.text},${controllerFlor.value.text},${controllerDepartment.value.text}";
    submitAddressModel.addressName = controllerName.value.text;
    submitAddressModel.addressDefault = defaultValue == true ? "1" : "0";
    submitAddressModel.addressNotes = controllerNote.value.text;
    submitAddressModel.addressGps =
        "${latLngData.latitude},${latLngData.longitude}";
    submitAddressModel.addressPhone =
        "${countryCode}${controllerPhone.value.text}";
    submitAddressModel.accountId = Commons.accountId;
    Response? response = await AddressDataProvider.AddAddressApi(
        context: context, submitAddressModel: submitAddressModel);

    if (response!.statusCode == 200 && response.data["status"] == 200) {
      emit(AddressStateAddressSubmitSuccess());
      Loader.hideLoader(context);
      // getAddressAndPaymentMethods(context);

      Navigator.pop(context);
    } else {
      emit(AddressStateAddressSubmitFail());
      Loader.hideLoader(context);
    }
  }

  Future<void> deleteAddressMethod(
      {required BuildContext context, required String addressId}) async {
    emit(AddressStateAddressDeleteLoading());
    Loader.showLoader(context);
    Response? response = await AddressDataProvider.DeleteAddressApi(
        context: context, addressId: addressId);

    if (response!.statusCode == 200 && response.data["status"] == 200) {
      emit(AddressStateAddressDeleteSuccess());
      Loader.hideLoader(context);
    } else {
      emit(AddressStateAddressDeleteFail());
      Loader.hideLoader(context);
    }
  }

  Future<void> EditAddressMethod(
      {required BuildContext context, required String addressId}) async {
    emit(AddressStateAddressEditLoading());
    EditAddressModel editAddressModel = EditAddressModel();

    editAddressModel.addressTitle =
        "${controllerGov.text},${controllerCity.value.text},${controllerArea.value.text},${controllerStreet.value.text},${controllerBuilding.value.text},${controllerFlor.value.text},${controllerDepartment.value.text}";
    editAddressModel.addressName = controllerName.value.text;
    editAddressModel.addressDefault = defaultValue == true ? "1" : "0";
    editAddressModel.addressNotes = controllerNote.value.text;
    editAddressModel.addressGps =
        "${latLngData.latitude},${latLngData.longitude}";
    editAddressModel.addressPhone =
        "${countryCode}${controllerPhone.value.text}";
    editAddressModel.addressesId = addressId;
    editAddressModel.accountId = Commons.accountId;
    Response? response = await AddressDataProvider.EditAddressApi(
        context: context, editAddressModel: editAddressModel);

    if (response!.statusCode == 200 && response.data["status"] == 200) {
      emit(AddressStateAddressEditSuccess());
      // CompletePaymentCubit.get(context).getAddressAndPaymentMethods(context);
      // getAddressAndPaymentMethods(context);

      Navigator.pop(context);
    } else {
      emit(AddressStateAddressEditFail());
    }
  }
}
