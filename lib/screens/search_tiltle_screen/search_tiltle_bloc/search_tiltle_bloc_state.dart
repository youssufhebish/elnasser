import 'package:elnasser/models/home_model/product_class.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum SearchResultTitleStatus { initial, success, failure, refresh }

class SearchResultTitleBlocState extends Equatable {
  SearchResultTitleBlocState(
      {this.status = SearchResultTitleStatus.initial,
      this.productSearchResultTitleList = const <ProductClass>[],
      this.hasReachedMax = false,
      required this.context,
      this.pageIndex = 1});

  final SearchResultTitleStatus status;
  final List<ProductClass> productSearchResultTitleList;
  final bool hasReachedMax;
  final BuildContext context;
  int pageIndex;

  SearchResultTitleBlocState copyWith(
      {SearchResultTitleStatus? status,
      List<ProductClass>? posts,
      bool? hasReachedMax,
      int? pageIndex}) {
    return SearchResultTitleBlocState(
        status: status ?? this.status,
        productSearchResultTitleList:
            posts ?? this.productSearchResultTitleList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        context: context,
        pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${productSearchResultTitleList.length} }''';
  }

  @override
  List<Object> get props =>
      [status, productSearchResultTitleList, hasReachedMax];
}
