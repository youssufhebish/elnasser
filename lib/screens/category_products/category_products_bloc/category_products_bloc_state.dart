import 'package:elnasser/models/home_model/product_class.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum CategoryProductsStatus { initial, success, failure, refresh }

class CategoryProductsBlocState extends Equatable {
  CategoryProductsBlocState({
    this.status = CategoryProductsStatus.initial,
    this.categoryProductsList = const <ProductClass>[],
    this.hasReachedMax = false,
    required this.context,
    this.pageIndex = 1,
  });

  final CategoryProductsStatus status;
  final List<ProductClass> categoryProductsList;
  final bool hasReachedMax;
  final BuildContext context;
  int pageIndex;

  CategoryProductsBlocState copyWith({
    CategoryProductsStatus? status,
    List<ProductClass>? posts,
    bool? hasReachedMax,
    int? pageIndex,
  }) {
    return CategoryProductsBlocState(
      status: status ?? this.status,
      categoryProductsList: posts ?? this.categoryProductsList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      context: context,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${categoryProductsList.length} },pageIndex:$pageIndex''';
  }

  @override
  List<Object> get props =>
      [status, categoryProductsList, hasReachedMax, pageIndex];
}
