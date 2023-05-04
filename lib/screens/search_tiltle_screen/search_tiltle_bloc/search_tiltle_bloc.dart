import 'package:dio/dio.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/products_page_navigation_model/products_page_navigation_model.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/search_tiltle_screen/sarch_result_data_provider_title/sarch_result_data_provider_title.dart';
import 'package:elnasser/screens/search_tiltle_screen/search_tiltle_bloc/search_tiltle_bloc_event.dart';
import 'package:elnasser/screens/search_tiltle_screen/search_tiltle_bloc/search_tiltle_bloc_state.dart';

import 'package:elnasser/widget/search_widget/search_widget_bloc/search_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/throttle.dart';

class SearchResultTitleBloc
    extends Bloc<SearchResultTitleEvent, SearchResultTitleBlocState> {
  SearchResultTitleBloc(BuildContext context)
      : super(SearchResultTitleBlocState(context: context));

  @override
  Stream<Transition<SearchResultTitleEvent, SearchResultTitleBlocState>>
      transformEvents(
    Stream<SearchResultTitleEvent> events,
    TransitionFunction<SearchResultTitleEvent, SearchResultTitleBlocState>
        transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<SearchResultTitleBlocState> mapEventToState(
      SearchResultTitleEvent event) async* {
    if (event is SearchResultTitleFetch) {
      yield await _mapProductToState(state);
    }
    if (event is SearchResultTitleReset) {
      yield await Refresh(state).whenComplete(() => _fetchProductsTitle(
          pageIndex: state.pageIndex, context: state.context));
    }
  }

  Future<SearchResultTitleBlocState> Refresh(
    SearchResultTitleBlocState state,
  ) async {
    print("state");
    print(state);

    try {
      List<ProductClass>? productList = [];
      return state.copyWith(
        status: SearchResultTitleStatus.refresh,
        posts: productList,
        pageIndex: state.pageIndex,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: SearchResultTitleStatus.failure);
    }
  }

  Future<SearchResultTitleBlocState> _mapProductToState(
      SearchResultTitleBlocState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == SearchResultTitleStatus.initial) {
        final posts = await _fetchProductsTitle(
            pageIndex: state.pageIndex, context: state.context);
        return state.copyWith(
          status: SearchResultTitleStatus.success,
          pageIndex: state.pageIndex + 1,
          posts: posts,
          hasReachedMax: false,
        );
      }
      List<ProductClass>? productsList = await _fetchProductsTitle(
          pageIndex: state.pageIndex, context: state.context);
      return productsList!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: SearchResultTitleStatus.success,
              pageIndex: state.pageIndex + 1,
              posts: List.of(state.productSearchResultTitleList)
                ..addAll(productsList),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: SearchResultTitleStatus.failure);
    }
  }

  Future<List<ProductClass>?> _fetchProductsTitle(
      {required BuildContext context, int? pageIndex}) async {
    Response? response = await SearchResultDataTitleProvider.getSearchTitleData(
        context: context,
        pageIndex: pageIndex!,
        title: SearchWidgetCubit.get(context).searchText);
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
