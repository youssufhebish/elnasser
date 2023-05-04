import 'package:dio/dio.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/models/product_details.dart';
import 'package:elnasser/screens/product_details/product_data_provider/product_details_api_suggestion.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/product_details_suggestion_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsSuggestionCubit
    extends Cubit<ProductDetailsSuggestionState> {
  ProductDetailsSuggestionCubit()
      : super(ProductDetailsSuggestionInitialState());

  static ProductDetailsSuggestionCubit get(BuildContext context) =>
      BlocProvider.of(context);

  ProductDetails productDetails = ProductDetails();

  List<int> productIds = [];

  Future<void> getProductDetails(BuildContext context) async {
    emit(ProductDetailsSuggestionInitialState());
    print(productIds);
    Response? response = await ProductDetailsApiSuggestion.getProductDetailsApi(
        context: context, productId: productIds.last);

    productDetails = ProductDetails.fromJson(response?.data);

    if (productDetails.status == 200) {
      emit(ProductDetailsSuggestionSuccessState());
    } else {
      emit(ProductDetailsSuggestionErrorState());
    }
  }
}
