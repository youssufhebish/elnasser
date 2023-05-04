import 'package:dio/dio.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/products_page_navigation_model/products_page_navigation_model.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/search_result_filter/sarch_result_data_provider/sarch_result_data_provider.dart';

import 'package:elnasser/widget/search_widget/search_widget_bloc/search_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/throttle.dart';

import 'search_result_bloc_filter_state.dart';
import 'search_result_filter_event.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultBlocState> {
  SearchResultBloc(BuildContext context)
      : super(SearchResultBlocState(context: context));

  @override
  Stream<Transition<SearchResultEvent, SearchResultBlocState>> transformEvents(
    Stream<SearchResultEvent> events,
    TransitionFunction<SearchResultEvent, SearchResultBlocState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<SearchResultBlocState> mapEventToState(
      SearchResultEvent event) async* {
    if (event is SearchResultFetchFilter) {
      yield await _mapPostFetchedToState(state);
    }
    if (event is SearchResultReset) {
      yield await Refresh(state).whenComplete(() => _fetchProductsFilter(
          pageIndex: state.pageIndex, context: state.context));
    }
  }

  Future<SearchResultBlocState> Refresh(
    SearchResultBlocState state,
  ) async {
    print("state");
    print(state);

    try {
      List<ProductClass>? productList = [];
      return state.copyWith(
        status: SearchResultStatus.refresh,
        posts: productList,
        pageIndex: 1,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: SearchResultStatus.failure);
    }
  }

  Future<SearchResultBlocState> _mapPostFetchedToState(
      SearchResultBlocState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == SearchResultStatus.initial) {
        final posts = await _fetchProductsFilter(
            pageIndex: state.pageIndex, context: state.context);
        return state.copyWith(
          status: SearchResultStatus.success,
          posts: posts,
          pageIndex: state.pageIndex + 1,
          hasReachedMax: false,
        );
      }
      List<ProductClass>? productsList = await _fetchProductsFilter(
          pageIndex: state.pageIndex, context: state.context);
      return productsList!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: SearchResultStatus.success,
              pageIndex: state.pageIndex + 1,
              posts: List.of(state.prdouctSearchResultList)
                ..addAll(productsList),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: SearchResultStatus.failure);
    }
  }

  Future<List<ProductClass>?> _fetchProductsFilter(
      {required BuildContext context, int? pageIndex}) async {
    print('SortBy :${FilterCubit.get(context).sortBy}');
    Response? response = await SearchResultDataProvider.getFilterData(
        context: context,
        pageIndex: pageIndex!,
        maxPrice: FilterCubit.get(context).maxPrice,
        brandsIds: FilterCubit.get(context).brandIds,
        sortBy: FilterCubit.get(context).sortBy,
        categoryIds: FilterCubit.get(context).categoriesIds,
        minPrice: FilterCubit.get(context).minPrice,
        sizesIds: FilterCubit.get(context).sizesIds,
        attributeIds: FilterCubit.get(context).attributesIds,
        offersIds: FilterCubit.get(context).offersIds);

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
