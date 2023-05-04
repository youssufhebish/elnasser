import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/models/best_sales/best_sales_model.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/screens/best_sales/best_sale_data_provider/best_sale_data_provider.dart';
import 'package:elnasser/screens/best_sales/best_sales_bloc/best_sales_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'best_sales_status.dart';

class BestSalesBloc extends Bloc<BestSaleEvent, BestSalesBlocState> {
  BestSalesBloc(BuildContext context)
      : super(BestSalesBlocState(context: context));

  @override
  Stream<Transition<BestSaleEvent, BestSalesBlocState>> transformEvents(
    Stream<BestSaleEvent> events,
    TransitionFunction<BestSaleEvent, BestSalesBlocState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<BestSalesBlocState> mapEventToState(BestSaleEvent event) async* {
    if (event is BestSalesFetch) {
      yield await _mapPostFetchedToState(state);
    }
    if (event is BestSalesReset) {
      yield await Refresh(state).whenComplete(() =>
          _fetchProducts(pageIndex: state.pageIndex, context: state.context));
    }
  }

  Future<BestSalesBlocState> Refresh(
    BestSalesBlocState state,
  ) async {
    try {
      List<ProductClass>? offerList = [];
      return state.copyWith(
        status: BestSalesStatus.refresh,
        posts: offerList,
        pageIndex: state.pageIndex,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: BestSalesStatus.failure);
    }
  }

  Future<BestSalesBlocState> _mapPostFetchedToState(
      BestSalesBlocState state) async {
    print('PagIndex:${state.pageIndex}');
    if (state.hasReachedMax) return state;
    try {
      print("state");
      print(state.status);
      if (state.status == BestSalesStatus.initial) {
        final posts = await _fetchProducts(
            pageIndex: state.pageIndex, context: state.context);
        return state.copyWith(
          status: BestSalesStatus.success,
          pageIndex: state.pageIndex + 1,
          posts: posts,
          hasReachedMax: false,
        );
      }
      List<ProductClass>? offerList = await _fetchProducts(
          pageIndex: state.pageIndex, context: state.context);
      return offerList!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: BestSalesStatus.success,
              pageIndex: state.pageIndex + 1,
              posts: List.of(state.bestSalesList)..addAll(offerList),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: BestSalesStatus.failure);
    }
  }

  Future<List<ProductClass>?> _fetchProducts(
      {required BuildContext context, int? pageIndex}) async {
    Response? response = await BestSaleDataProvider.getBestSales(
        context: context, pageIndex: pageIndex!);

    print('Rsponse Response');
    print(response!.data);
    if (response.statusCode == 200) {
      if (response.data["status"] == 200) {
        BestSalesModel bestSaleModel = BestSalesModel.fromJson(response.data);
        List<ProductClass> product = [];
        bestSaleModel.data!.bestSales!.forEach((element) {
          product.add(element);
        });

        return product;
      }
    } else {
      print(response.data);
    }
  }
}
