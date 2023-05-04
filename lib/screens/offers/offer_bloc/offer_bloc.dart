import 'package:dio/dio.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/products_page_navigation_model/products_page_navigation_model.dart';
import 'package:elnasser/screens/offers/offer_data_provider/offer_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/throttle.dart';

import 'offer_bloc_state.dart';
import 'offer_event.dart';

class OfferBloc extends Bloc<OfferEvent, OfferBlocState> {
  OfferBloc(BuildContext context) : super(OfferBlocState(context: context));

  @override
  Stream<Transition<OfferEvent, OfferBlocState>> transformEvents(
    Stream<OfferEvent> events,
    TransitionFunction<OfferEvent, OfferBlocState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<OfferBlocState> mapEventToState(OfferEvent event) async* {
    if (event is OfferFetch) {
      yield await _mapPostFetchedToState(state);
    }
    if (event is OfferReset) {
      yield await Refresh(state).whenComplete(() =>
          _fetchProducts(pageIndex: state.pageIndex, context: state.context));
    }
  }

  Future<OfferBlocState> Refresh(
    OfferBlocState state,
  ) async {
    print("state");
    print(state);

    try {
      List<ProductClass>? productList = [];
      return state.copyWith(
        status: OfferStatus.refresh,
        pagIndex: state.pageIndex,
        posts: productList,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: OfferStatus.failure);
    }
  }

  Future<OfferBlocState> _mapPostFetchedToState(OfferBlocState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == OfferStatus.initial) {
        final posts = await _fetchProducts(
            pageIndex: state.pageIndex, context: state.context);
        return state.copyWith(
          status: OfferStatus.success,
          pagIndex: state.pageIndex + 1,
          posts: posts,
          hasReachedMax: false,
        );
      }
      List<ProductClass>? productsList = await _fetchProducts(
          pageIndex: state.pageIndex, context: state.context);
      return productsList!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: OfferStatus.success,
              pagIndex: state.pageIndex + 1,
              posts: List.of(state.productOfferList)..addAll(productsList),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: OfferStatus.failure);
    }
  }

  Future<List<ProductClass>?> _fetchProducts(
      {required BuildContext context, int? pageIndex}) async {
    Response? response = await OfferDataProvider.getOffer(
        context: context, pageIndex: "$pageIndex");
    if (response!.statusCode == 200) {
      if (response.data["status"] == 200) {
        ResultDataModel productModel = ResultDataModel.fromJson(response.data);
        List<ProductClass> product = [];
        productModel.data!.products!.forEach((element) {
          product.add(element);
        });
        print(product.length);

        return product;
      }
    } else {
      print(response.data);
    }
  }
}
