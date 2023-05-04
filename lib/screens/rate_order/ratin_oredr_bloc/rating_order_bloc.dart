import 'dart:math';

import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/models/rate_order/rate_order_model.dart';
import 'package:elnasser/models/rating/get_rating.dart';
import 'package:elnasser/screens/rate_order/rate_order_data_provider/rate_order_data_provider.dart';
import 'package:elnasser/screens/rate_order/ratin_oredr_bloc/rating_order_state.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingOrderCubit extends Cubit<RatingOrderState> {
  RatingOrderCubit() : super(RatingOrderStateInitial());

  static RatingOrderCubit get(BuildContext context) => BlocProvider.of(context);

  List<TextEditingController> controller = [];
  TextEditingController rateNote = TextEditingController();
  List<TextEditingController> generateController(int length) {
    // _controller.clear();
    controller = List.generate(length, (index) => TextEditingController());
    emit(RatingOrderStateGenerateControllers());
    return controller;
  }

  List<bool> showProductRating = [];

  List<bool> RateProduct(int length) {
    showProductRating = List.generate(length, (index) => false);

    quality = List.generate(length, (index) => 0.0);
    price = List.generate(length, (index) => 0.0);
    size = List.generate(length, (index) => 0.0);
    match = List.generate(length, (index) => 0.0);
    print('/////33333/////33333');
    print(quality);
    print(price);
    print(match);
    emit(RatingOrderStateGenerateProductList());
    return showProductRating;
  }

  List<double> quality = [];
  List<double> price = [];
  List<double> size = [];
  List<double> match = [];

  double shoppingRate = 0;
  double deliveryRate = 0;

  getEditData(
      {required List<OrderItemModel> items,
      required List<RatingProduct> productRating,
      required OrderDetailsRating orderDetailsRating}) {
    showProductRating = List.generate(items.length, (index) => false);
    shoppingRate = double.parse("${orderDetailsRating.ratingsService}");
    deliveryRate = double.parse("${orderDetailsRating.ratingsDelivery}");
    List<int> ids = [];
    quality.clear();
    size.clear();
    match.clear();
    price.clear();

    productRating.forEach((element) {
      ids.add(int.parse("${element.productsId}"));
    });
    // items.forEach((itemElement) {
    //   print(ids.contains(itemElement.product!.productsId));
    //
    //  if(ids.contains(itemElement.fkProductsId)){
    //     quality.add(double.parse("${productRating[items.indexOf(itemElement)].ratingsQuality??"0"}"));
    //     size.add(double.parse(productRating[items.indexOf(itemElement)].ratingsSize!));
    //     price.add(double.parse(productRating[items.indexOf(itemElement)].ratingsPrice!));
    //     match.add(double.parse(productRating[items.indexOf(itemElement)].ratingsMatchPicture!));
    //   }else{
    //     quality.add(0.0);
    //     size.add(0.0);
    //     price.add(0.0);
    //     match.add(0.0);
    //   }
    //
    //
    //
    // });

    items.forEach((itemElement) {
      print(ids.contains(int.parse(itemElement.fkProductsId!)));
      productRating.forEach((element) {
        if (int.parse("${element.productsId}") ==
            int.parse(itemElement.fkProductsId!)) {
          print(element);
          element.ratingsQuality != null
              ? quality.add(double.parse("${element.ratingsQuality!}"))
              : null;
          element.ratingsSize != null
              ? size.add(double.parse(element.ratingsSize!))
              : null;
          element.ratingsPrice != null
              ? price.add(double.parse(element.ratingsPrice!))
              : null;
          element.ratingsMatchPicture != null
              ? match.add(double.parse(element.ratingsMatchPicture!))
              : null;
          // element.ratingsText!= null ? controller.add(element.)

        } else {
          quality.add(0.0);
          size.add(0.0);
          price.add(0.0);
          match.add(0.0);
          print(false);
        }
      });
      rateNote.text = orderDetailsRating.ratingsText ?? "";
    });

    emit(RatingOrderStateEdit());
  }

  generaeLists(int length) {
    print(length);
    for (int i = 0; i < length; i++) {
      quality.add(0.0);
      size.add(0.0);
      price.add(0.0);
      match.add(0.0);
    }
    emit(RatingOrderStateGetDeliveryRate());
  }

  getDeliveryRate(double rate) {
    deliveryRate = rate;
    emit(RatingOrderStateGetDeliveryRate());
  }

  getShoppingRate(double rate) {
    shoppingRate = rate;
    emit(RatingOrderStateGetShoppingRate());
  }

  getSize(double sizeValue, int index) {
    size.isNotEmpty ? size[index] = sizeValue : size.add(sizeValue);
    emit(RatingOrderStateGetSize());
  }

  getQuality(double qualityValue, int index) {
    print(quality);
    quality.isNotEmpty
        ? quality[index] = qualityValue
        : quality.add(qualityValue);
    emit(RatingOrderStateGetQuality());
  }

  getPrice(double priceValue, int index) {
    price.isNotEmpty ? price[index] = priceValue : price.add(priceValue);
    emit(RatingOrderStateGetPrice());
  }

  getMatch(double matchValue, int index) {
    match.isNotEmpty ? match[index] = matchValue : match.add(matchValue);
    emit(RatingOrderStateGetMatch());
  }

  RateOrderModel rateOrderModel = RateOrderModel();
  Future<void> submitRate(
      {required List<OrderItemModel> items,
      required BuildContext context,
      required ColorsInitialValue? colorValue,
      required int orderId}) async {
    emit(RatingOrderStateSubmitLoading());

    Loader.showLoader(context);

    List<int> productsRating = [];
    List<int> ids = [];
    List<String> notes = [];
    showProductRating.forEach((element) =>
        element == true ? productsRating.add(1) : productsRating.add(0));
    items.forEach((element) => ids.add(element.product!.productsId!));
    controller.forEach((element) => notes.add(element.text));
    List<bool> submit = [];
    emit(RatingOrderStateGenerateLists());
    productsRating.forEach((element) {
      if (element == 1) {
        print(element);
        print(productsRating[0]);
        print(productsRating.indexOf(element));
        if (quality.isNotEmpty &&
            size.isNotEmpty &&
            match.isNotEmpty &&
            price.isNotEmpty) {
          if (quality[productsRating.indexOf(element)] == 0.0 ||
              size[productsRating.indexOf(element)] == 0.0 ||
              price[productsRating.indexOf(element)] == 0.0 ||
              match[productsRating.indexOf(element)] == 0.0) {
            submit.add(false);
            Loader.hideLoader(context);
            DataErrorAlert.MissingRateMessageProduct(
                colorValue: colorValue, context: context);
          } else {
            submit.add(true);
          }
        } else {
          submit.add(false);
          Loader.hideLoader(context);
          DataErrorAlert.MissingRateMessageProduct(
              colorValue: colorValue, context: context);
        }
      }
    });

    if (!submit.contains(false)) {
      rateOrderModel.productsRating = productsRating;
      rateOrderModel.productsId = ids;
      rateOrderModel.ordersId = orderId;
      rateOrderModel.accountId = int.parse("${Commons.accountId}");
      rateOrderModel.productRatingsText = notes;
      rateOrderModel.ratingsDelivery = deliveryRate;
      rateOrderModel.ratingsService = shoppingRate;
      rateOrderModel.ratingsMatchPicture = match;
      rateOrderModel.ratingsPrice = price;
      rateOrderModel.ratingsQuality = quality;
      rateOrderModel.ratingsSize = size;
      rateOrderModel.ratingsText = rateNote.text;

      Response? response = await RateOrderDataProvider.AddOrderRate(
          context: context, rateOrderModel: rateOrderModel);
      print("response!.data");
      print(response!.data);
      print("response!.data");
      if (response.statusCode == 200) {
        shoppingRate = 0;
        deliveryRate = 0;
        quality.clear();
        size.clear();
        match.clear();
        price.clear();
        notes.clear();
        rateNote.clear();
        Loader.hideLoader(context);
        emit(RatingOrderStateSubmitSuccess());
      } else {
        Loader.hideLoader(context);
        emit(RatingOrderStateSubmitFail());
      }
    }
  }

  clearData() {
    shoppingRate = 0;
    deliveryRate = 0;
    quality.clear();
    size.clear();
    match.clear();
    price.clear();
    controller.clear();
    rateNote.clear();
    emit(RatingOrderStateSubmitClear());
  }
}
