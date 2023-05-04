import 'package:dio/dio.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/cart_model/add_coupon_model.dart';
import 'package:elnasser/models/cart_model/add_to_cart_model.dart';
import 'package:elnasser/models/cart_model/cart_model.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/screens/cart/cart_data_provider/cart_data_provider.dart';
import 'package:elnasser/screens/cart/reposiotry/cart_repository.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_cubit.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../animation/loader.dart';
import 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartStateInitial()) {}
  static AddToCartCubit get(BuildContext context) => BlocProvider.of(context);

  String? productChoiceID;
  getProductChoiceID(String id) {
    productChoiceID = id;
    print("productChoiceID$productChoiceID");
    emit(AddToCartStateGetProductChoiceId());
  }

  int productCount = 1;

  getProductCountAdd() {
    productCount++;

    emit(AddToCartStateGetAmountAdd());
  }

  getProductCountUpdatePlus(int product) {
    productCount = product + 1;

    emit(AddToCartStateGetAmountAdd());
  }

  getProductCountUpdateMinus(int product) {
    if (product > 1) {
      productCount = product - 1;
    }

    emit(AddToCartStateGetAmountMinus());
  }

  getProductCountMinus() {
    if (productCount > 1) {
      productCount--;
    }

    emit(AddToCartStateGetAmountMinus());
  }

  resetData() {
    productCount = 1;
    productChoiceID = null;
    emit(AddToCartStateResetData());
  }

  TextEditingController couponController = TextEditingController();
  AddToCartModel addToCartModel = AddToCartModel();
  CartModel cartModel = CartModel();
  ErrorModel errorModel = ErrorModel();
  Future<void> addToCartApi(
      {required BuildContext context,
      required int productId,
      required bool inCart,
      bool? add = true}) async {
    Loader.showLoader(context);

    emit(AddToCartStateLoading());

    addToCartModel.accountId = Commons.accountId;
    addToCartModel.device_token =
        await PreferenceUtils.getDataFromPreferences(deviceId);
    addToCartModel.products_choices_id = productChoiceID;
    addToCartModel.products_count = productCount;
    addToCartModel.products_id = productId;
    addToCartModel.deviceType = add == false ? "mobile" : "";

    Response? response = await CartDataProvider.addToCartApi(
        context: context, addToCartModel: addToCartModel);

    print('**************');
    print(response!.data);

    print('**************0');

    if (response.data["status"] == 422) {
      Loader.hideLoader(context);
      errorModel = ErrorModel.fromJson(response.data);
      emit(AddToCartStateNoStock());
    } else if (response.data["status"] == 200) {
      cartModel = CartModel.fromJson(response.data);
      Loader.hideLoader(context);
      ProductDetailsSliderCubit.get(context).clearData();
      productChoiceID = null;

      if (inCart == false) {
        Navigator.pop(context);
      }
      resetData();
      emit(AddToCartStateSuccess());

      // Navigator.pop(context);
    } else {
      Loader.hideLoader(context);

      emit(AddToCartStateFailed());
    }
  }

  Future<void> deleteCartApi(
      {required BuildContext context, required String productId}) async {
    Loader.showLoader(context);

    emit(CartStateDeleteLoading());

    Response? response = await CartDataProvider.deleteCartApi(
        context: context, itemId: productId);

    if (cartModel.status == 200) {
      cartModel = CartModel.fromJson(response!.data);
      Loader.hideLoader(context);
      emit(CartStateDeleteSuccess());

      // Navigator.pop(context);
    } else {
      // Loader.hideLoader(context);

      emit(CartStateDeleteFail());
    }
  }

  AddCouponModel addCouponModel = AddCouponModel();

  Future<void> AddCouponApi(
      {required BuildContext context, required String couponValue}) async {
    Loader.showLoader(context);

    emit(CartStateCouponLoading());

    addCouponModel.accountId = Commons.accountId;
    addCouponModel.device_token =
        await PreferenceUtils.getDataFromPreferences(deviceId);
    addCouponModel.coupons_code = couponValue;

    Response? response = await CartDataProvider.addCouponApi(
        context: context, addCouponModel: addCouponModel);

    print(response!.data["status"]);

    if (response.data["status"] == 200) {
      cartModel = CartModel.fromJson(response.data);
      Loader.hideLoader(context);
      emit(CartStateCouponSuccess());

      // Navigator.pop(context);
    } else if (response.data["status"] == 422) {
      Loader.hideLoader(context);

      errorModel = ErrorModel.fromJson(response.data);
      emit(CartStateCouponFailDialog());

      // Navigator.pop(context);
    } else {
      Loader.hideLoader(context);

      emit(CartStateCouponFail());
    }
  }

  Future<void> removeCoupon({required BuildContext context}) async {
    Loader.showLoader(context);

    emit(CartStateRemoveCouponLoading());

    Response? response =
        await CartDataProvider.removeCouponApi(context: context);

    print(response!.data["status"]);
    print(response.data["status"]);
    print(response.data);

    if (response.data["status"] == 200) {
      cartModel = CartModel.fromJson(response.data);
      Loader.hideLoader(context);
      emit(CartStateRemoveCouponSuccess());

      // Navigator.pop(context);
    } else if (response.data["status"] == 422) {
      Loader.hideLoader(context);

      errorModel = ErrorModel.fromJson(response.data);

      emit(CartStateRemoveCouponFail());

      // Navigator.pop(context);
    } else {
      Loader.hideLoader(context);

      emit(CartStateRemoveCouponFail());
    }
  }

  final getCartStream = BehaviorSubject<CartModel>();
  Stream<CartModel> get streamCart => getCartStream.stream;

  Future<void> getCart({required BuildContext context}) async {
    emit(CartStateLoading());

    Response? response = await CartDataProvider.getCartApi(context: context);

    if (response!.statusCode == 200) {
      cartModel = CartModel.fromJson(response.data);
      getCartStream.sink.add(cartModel);
      print(response.data);
      print("response!.data");
      print("response!.data");

      if (cartModel.data!.errors != null &&
          cartModel.data!.errors!.isNotEmpty) {
        print('errrrrrrr');
        emit(CartStateStockError());
      }

      emit(CartStateSuccess());
    } else {
      emit(CartStateFailed());
    }
  }
}
