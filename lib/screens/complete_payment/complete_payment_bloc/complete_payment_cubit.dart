import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/address_model/address_model.dart';
import 'package:elnasser/models/cart_model/upadate_cart_review.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/models/post_order_result/post_order_result.dart';
import 'package:elnasser/models/succes_login_model.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_data_provider/complete_payment_data_provider.dart';
import 'package:elnasser/screens/complete_payment/widget/address_paymnet_screen.dart';
import 'package:elnasser/screens/complete_payment/widget/chipping_methods.dart';
import 'package:elnasser/screens/complete_payment/widget/final_payment_select_method.dart';
import 'package:elnasser/screens/complete_payment/widget/review.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/online_payment.dart';
import 'package:elnasser/widget/post_order_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'complete_payment_state.dart';

class CompletePaymentCubit extends Cubit<CompletePaymentState> {
  CompletePaymentCubit(BuildContext context)
      : super(CompletePaymentStateInitial()) {
    getData();
  }

  static CompletePaymentCubit get(BuildContext context) =>
      BlocProvider.of(context);
  Customer customer = Customer();
  bool? isUserLogin = false;
  // TheInitialModel theInitialModel = TheInitialModel();
  LoginSuccessModel userModel = LoginSuccessModel();
  getData() async {
    // PreferenceUtils.getDataFromPreferences(initialData).then((value) {
    //
    //   theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
    //   emit(CompletePaymentStateShared());
    // });
    PreferenceUtils.getDataFromPreferences(userData).then((value) {
      userModel = LoginSuccessModel.fromJson(jsonDecode(value!));
      print(userModel.data!.token!.accessToken);
      emit(CompletePaymentStateShared());
    });

    PreferenceUtils.getDataFromPreferences(customerData).then((value) {
      customer = Customer.fromJson(jsonDecode(value!));
      print(userModel.data!.token!.accessToken);
      emit(CompletePaymentStateShared());
    });

    PreferenceUtils.getBoolDataFromPreferences(userIsLogin).then((value) {
      isUserLogin = value != null ? value : false;
      emit(CompletePaymentStateShared());
    });
  }

  List<String> steps = ["paymentAddress", "shipment", "review", "payment"];
  List<String> images = [
    ImageConstants.map,
    ImageConstants.shipping,
    ImageConstants.review,
    ImageConstants.wallet
  ];
  int currentStep = 0;

  List<Widget> stepsWidget(ColorsInitialValue colorsInitialValue) => [
        AddressPaymentListScreen(
          colorsValue: colorsInitialValue,
        ),
        ShippingMethods(
          colorsValue: colorsInitialValue,
        ),
        Review(
          colorsValue: colorsInitialValue,
        ),
        SelectPaymentMethod(
          colorsValue: colorsInitialValue,
        ),
      ];

  goNext(BuildContext context) {
    if (currentStep < steps.length - 1) {
      currentStep++;
    }
    print(currentStep);
    emit(CompletePaymentStateNext());
  }

  goBack() {
    if (currentStep > 0) {
      currentStep--;
    }
    emit(CompletePaymentStateBack());
  }

  /// Address

  int currentAddressIndex = 0;
  int currentShipping = -1;

  getAddress(int index) {
    currentAddressIndex = index;
    print(
        'CompletePaymentStateGetCurrentAddress>>> ${CompletePaymentStateGetCurrentAddress}');
    emit(CompletePaymentStateGetCurrentAddress());
  }

  getShipping(int index) {
    currentShipping = index;
    emit(CompletePaymentStateGetCurrentShipping());
  }

  AddressModel addressModel = AddressModel();
  Future<void> getAddressAndPaymentMethods(BuildContext context) async {
    emit(CompletePaymentStateAddressLoading());

    Response? response = await CompletePaymentDataProvider.getAddressAndMethods(
        context: context);

    if (response!.statusCode == 200 && response.data["status"] == 200) {
      addressModel = AddressModel.fromJson(response.data);

      emit(CompletePaymentStateAddressSuccess());
    } else {
      emit(CompletePaymentStateAddressFail());
    }
  }

  /// review
  TextEditingController controllerNote = TextEditingController();
  Future<void> updateCart(BuildContext context) async {
    emit(CompletePaymentStateReviewLoading());
    Loader.showLoader(context);
    UpdateCartModel updateCartModel = UpdateCartModel();
    updateCartModel.shipping_methods_id =
        addressModel.data!.shippingMethod![currentShipping].shippingMethodsId;
    updateCartModel.customer_addresses_id =
        addressModel.data!.addresses![currentAddressIndex].customerAddressesId;
    updateCartModel.payments_id =
        addressModel.data!.paymentMethods![currentPaymentMethod].paymentsId;
    updateCartModel.accountId = Commons.accountId;
    updateCartModel.notes = controllerNote.value.text;
    updateCartModel.device_token =
        await PreferenceUtils.getDataFromPreferences(deviceId);

    Response? response = await CompletePaymentDataProvider.updateCart(
        context: context, updateCartModel: updateCartModel);

    if (response!.statusCode == 200 && response.data["status"] == 200) {
      addressModel = AddressModel.fromJson(response.data);

      emit(CompletePaymentStateReviewSuccess());
      CompletePaymentCubit.get(context).getAddressAndPaymentMethods(context);
      // AddToCartCubit.get(context).getCart(context: context);
      Loader.hideLoader(context);
    } else {
      emit(CompletePaymentStateReviewFail());
      Loader.hideLoader(context);
    }
  }

  /// final payment select Methods
  bool termsValue = false;

  changeDefaultValue(bool value) {
    termsValue = value;
    emit(CompletePaymentStateCheckBox());
  }

  int currentPaymentMethod = -1;

  getCurrentPaymentMethod(int index) {
    currentPaymentMethod = index;
    emit(CompletePaymentStateGetCurrentAddress());
  }

  /// post order ///
  ErrorModel errorModel = ErrorModel();

  PostOrderResponseModel postOrderResponseModel = PostOrderResponseModel();
  Future<void> PostOrderMethods(BuildContext context) async {
    emit(CompletePaymentStatePostLoading());
    Loader.showLoader(context);
    Response? response =
        await CompletePaymentDataProvider.postOrder(context: context);

    if (response!.statusCode == 200 && response.data["status"] == 200) {
      emit(CompletePaymentStatePostSuccess());
      currentPaymentMethod = -1;
      currentStep = 0;
      currentAddressIndex = 0;
      currentShipping = -1;
      termsValue = false;
      controllerNote.clear();
      AddressCubit.get(context).getAddress(-1);

      AddToCartCubit.get(context).getCart(context: context);
      CompletePaymentCubit.get(context).getAddressAndPaymentMethods(context);
      Loader.hideLoader(context);

      postOrderResponseModel = PostOrderResponseModel.fromJson(response.data);

      if (postOrderResponseModel.data!.url == null) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostOrderResult(
                      colorsValue: SplashCubit.get(context)
                          .theInitialModel
                          .data!
                          .account!
                          .mobileAppColors!,
                      success: true,
                    )));
      } else {
        // Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OnlinePayment(
                      url: postOrderResponseModel.data!.url!,
                    )));
      }
    } else if (response.data["status"] == 422) {
      Loader.hideLoader(context);
      errorModel = ErrorModel.fromJson(response.data);
      emit(CompletePaymentStatePostNoStock());
    } else {
      print(response.data);
      emit(CompletePaymentStatePostFail());
      Loader.hideLoader(context);
    }
  }
}
