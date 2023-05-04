import 'package:dio/dio.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/products_page_navigation_model/products_page_navigation_model.dart';
import 'package:elnasser/screens/new_arrival_screen/new_arrival_data_provider/new_arrival_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'new_arrival_event.dart';
import 'new_arrival_state.dart';

class NewArrivalBloc extends Bloc<NewArrivalEvent, NewArrivalBlocState> {
  NewArrivalBloc(BuildContext context)
      : super(NewArrivalBlocState(context: context));

  @override
  Stream<Transition<NewArrivalEvent, NewArrivalBlocState>> transformEvents(
    Stream<NewArrivalEvent> events,
    TransitionFunction<NewArrivalEvent, NewArrivalBlocState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<NewArrivalBlocState> mapEventToState(NewArrivalEvent event) async* {
    if (event is NewArrivalFetch) {
      yield await _mapPostFetchedToState(state);
    }
    if (event is NewArrivalReset) {
      yield await Refresh(state).whenComplete(() =>
          _fetchProducts(pageIndex: state.pageIndex, context: state.context));
    }
  }

  Future<NewArrivalBlocState> Refresh(
    NewArrivalBlocState state,
  ) async {
    print("state");
    print(state);

    try {
      List<ProductClass>? offerList = [];
      return state.copyWith(
        status: NewArrivalStatus.refresh,
        posts: offerList,
        pageIndex: state.pageIndex,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: NewArrivalStatus.failure);
    }
  }

  Future<NewArrivalBlocState> _mapPostFetchedToState(
      NewArrivalBlocState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == NewArrivalStatus.initial) {
        final posts = await _fetchProducts(
            pageIndex: state.pageIndex, context: state.context);
        return state.copyWith(
          status: NewArrivalStatus.success,
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
              status: NewArrivalStatus.success,
              pageIndex: state.pageIndex + 1,
              posts: List.of(state.bestSalesList)..addAll(offerList),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: NewArrivalStatus.failure);
    }
  }

  Future<List<ProductClass>?> _fetchProducts(
      {required BuildContext context, int? pageIndex}) async {
    Response? response = await ProductPagePaginationDataProvider.getNewArrival(
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
