import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/contact_us_model.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/models/rating/get_rating.dart';
import 'package:elnasser/screens/contat_us/contact_us_data_provider/contact_us_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contat_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsStateInitial()) {
    getData();
  }

  static ContactUsCubit get(BuildContext context) => BlocProvider.of(context);

  Customer customer = Customer();
  bool? isUserLogin = false;

  getData() {
    PreferenceUtils.getDataFromPreferences(customerData).then((value) {
      if (value != null && value.isNotEmpty) {
        customer = Customer.fromJson(jsonDecode(value));
      }
      emit(ContactUsStateShared());
    });

    PreferenceUtils.getBoolDataFromPreferences(userIsLogin).then((value) {
      isUserLogin = value != null ? value : false;
      emit(ContactUsStateShared());
    });
  }

  String? countryCode = "+20";

  getCountryCode(String value) {
    countryCode = value;
    emit(ContactUsStateCountryCode());
  }

  int? suggestionId;

  getID(int? value) {
    suggestionId = value;
    emit(ContactUsStateSuggestionId());
  }

  ErrorModel errorModel = ErrorModel();
  Response? response;
  Future<void> submitLogin(
      {required BuildContext context,
      String? name,
      String? phone,
      required String message}) async {
    emit(ContactUsStateLoading());
    ContactUsModel contactUsModel = ContactUsModel();
    contactUsModel.accountId = Commons.accountId;
    contactUsModel.customersPhone =
        phone!.isEmpty ? customer.customersPhone : phone;
    contactUsModel.name = name!.isEmpty ? customer.customersName : name;
    contactUsModel.suggestion = message;
    contactUsModel.suggestionId = "$suggestionId";

    Loader.showLoader(context);
    response = await ConTactUsDataProvider.sendSuggestion(
        context: context, contactUsModel: contactUsModel);

    if (response!.statusCode == 200) {
      if (response!.data["status"] == 200) {
        print(response!.data);
        Loader.hideLoader(context);

        emit(ContactUsStateSuccess());
      } else {
        errorModel = ErrorModel.fromJson(response!.data);

        Loader.hideLoader(context);
        emit(ContactUsStateFail());
      }
    } else {
      Loader.hideLoader(context);
      emit(ContactUsStateFail());
    }
  }
}
