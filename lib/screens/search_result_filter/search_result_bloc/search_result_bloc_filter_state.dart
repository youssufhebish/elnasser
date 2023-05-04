import 'package:elnasser/models/home_model/product_class.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum SearchResultStatus { initial, success, failure, refresh }

class SearchResultBlocState extends Equatable {
  SearchResultBlocState({
    this.status = SearchResultStatus.initial,
    this.prdouctSearchResultList = const <ProductClass>[],
    this.hasReachedMax = false,
    required this.context,
    this.pageIndex = 1,
  });

  final SearchResultStatus status;
  final List<ProductClass> prdouctSearchResultList;
  final bool hasReachedMax;
  final BuildContext context;
  int pageIndex;

  SearchResultBlocState copyWith(
      {SearchResultStatus? status,
      List<ProductClass>? posts,
      bool? hasReachedMax,
      int? pageIndex}) {
    return SearchResultBlocState(
        status: status ?? this.status,
        prdouctSearchResultList: posts ?? this.prdouctSearchResultList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        context: context,
        pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${prdouctSearchResultList.length} }''';
  }

  @override
  List<Object> get props => [status, prdouctSearchResultList, hasReachedMax];
}
