import 'package:dio/dio.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/products_page_navigation_model/products_page_navigation_model.dart';
import 'package:elnasser/screens/special_products_screen/special_products_data_provider/special_products_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';

import 'special_products_event.dart';
import 'special_products_state.dart';

class SpecialProductsBloc
    extends Bloc<SpecialProductsEvent, SpecialProductsBlocState> {
  SpecialProductsBloc(BuildContext context)
      : super(SpecialProductsBlocState(context: context));

  @override
  Stream<Transition<SpecialProductsEvent, SpecialProductsBlocState>>
      transformEvents(
    Stream<SpecialProductsEvent> events,
    TransitionFunction<SpecialProductsEvent, SpecialProductsBlocState>
        transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<SpecialProductsBlocState> mapEventToState(
      SpecialProductsEvent event) async* {
    if (event is SpecialProductsFetch) {
      yield await _mapPostFetchedToState(state);
    }
    if (event is SpecialProductsReset) {
      yield await Refresh(state).whenComplete(() =>
          _fetchProducts(pageIndex: state.pageIndex, context: state.context));
    }
  }

  Future<SpecialProductsBlocState> Refresh(
    SpecialProductsBlocState state,
  ) async {
    print("state");
    print(state);

    try {
      List<ProductClass>? offerList = [];
      return state.copyWith(
        status: SpecialProductsStatus.refresh,
        posts: offerList,
        pageIndex: state.pageIndex,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: SpecialProductsStatus.failure);
    }
  }

  Future<SpecialProductsBlocState> _mapPostFetchedToState(
      SpecialProductsBlocState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == SpecialProductsStatus.initial) {
        final posts = await _fetchProducts(
            pageIndex: state.pageIndex, context: state.context);
        return state.copyWith(
            status: SpecialProductsStatus.success,
            posts: posts,
            hasReachedMax: false,
            pageIndex: state.pageIndex + 1);
      }
      List<ProductClass>? productsList = await _fetchProducts(
          pageIndex: state.pageIndex, context: state.context);
      return productsList!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: SpecialProductsStatus.success,
              pageIndex: state.pageIndex + 1,
              posts: List.of(state.specialProductList)..addAll(productsList),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: SpecialProductsStatus.failure);
    }
  }

  Future<List<ProductClass>?> _fetchProducts(
      {required BuildContext context, int? pageIndex}) async {
    Response? response = await SpecialProductsDataProvider.getSpecialProducts(
        context: context, pageIndex: pageIndex!);

    if (response!.statusCode == 200) {
      print('ddd');
      print(response.data);
      if (response.data["status"] == 200) {
        ResultDataModel newArrivalModel =
            ResultDataModel.fromJson(response.data);
        List<ProductClass> product = [];
        newArrivalModel.data!.products!.forEach((element) {
          product.add(element);
        });

        return product;
      }
    } else {
      print(response.data);
    }
  }
}
