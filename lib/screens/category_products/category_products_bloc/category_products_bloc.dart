import 'package:dio/dio.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/products_page_navigation_model/products_page_navigation_model.dart';
import 'package:elnasser/screens/category_products/category_products_data_provider/category_products_data_provider.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/throttle.dart';

import 'category_products_bloc_event.dart';
import 'category_products_bloc_state.dart';
import 'category_products_cubit.dart';

class CategoryProductsBloc
    extends Bloc<CategoryProductsEvent, CategoryProductsBlocState> {
  CategoryProductsBloc(BuildContext context)
      : super(CategoryProductsBlocState(context: context));

  @override
  Stream<Transition<CategoryProductsEvent, CategoryProductsBlocState>>
      transformEvents(
    Stream<CategoryProductsEvent> events,
    TransitionFunction<CategoryProductsEvent, CategoryProductsBlocState>
        transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 0)),
      transitionFn,
    );
  }

  @override
  Stream<CategoryProductsBlocState> mapEventToState(
      CategoryProductsEvent event) async* {
    if (event is CategoryProductsFetch) {
      yield await _mapPostFetchedToState(state);
    }
    if (event is CategoryProductsReset) {
      yield await Refresh(state).whenComplete(() => _fetchProductsFilter(
          pageIndex: state.pageIndex, context: state.context));
    }
  }
  // int pageIndex =0;

  Future<CategoryProductsBlocState> Refresh(
    CategoryProductsBlocState state,
  ) async {
    print("state");
    print(state);

    try {
      // pageIndex= 0;

      List<ProductClass>? productList = [];
      return state.copyWith(
        pageIndex: 1,
        status: CategoryProductsStatus.refresh,
        posts: productList,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: CategoryProductsStatus.failure);
    }
  }

  int time = DateTime.now().millisecond;
  Future<CategoryProductsBlocState> _mapPostFetchedToState(
      CategoryProductsBlocState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == CategoryProductsStatus.initial) {
        final posts = await _fetchProductsFilter(
            pageIndex: state.pageIndex, context: state.context);
        return state.copyWith(
          status: CategoryProductsStatus.success,
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
              pageIndex: state.pageIndex + 1,
              status: CategoryProductsStatus.success,
              posts: List.of(state.categoryProductsList)..addAll(productsList),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: CategoryProductsStatus.failure);
    }
  }

  Future<List<ProductClass>?> _fetchProductsFilter(
      {required BuildContext context, required int pageIndex}) async {
    print('getting category Product');

    Response? response = await CategoryProductsDataProvider.getProducts(
        context: context,
        pageIndex: pageIndex,
        categoryId: CategoryProductsCubit.get(context).catID!);
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
