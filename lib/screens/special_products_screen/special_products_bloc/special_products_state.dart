import 'package:elnasser/models/home_model/product_class.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum SpecialProductsStatus { initial, success, failure, refresh }

class SpecialProductsBlocState extends Equatable {
  SpecialProductsBlocState({
    this.status = SpecialProductsStatus.initial,
    this.specialProductList = const <ProductClass>[],
    this.hasReachedMax = false,
    required this.context,
    this.pageIndex = 1,
  });

  final SpecialProductsStatus status;
  final List<ProductClass> specialProductList;
  final bool hasReachedMax;
  final BuildContext context;
  int pageIndex;

  SpecialProductsBlocState copyWith(
      {SpecialProductsStatus? status,
      List<ProductClass>? posts,
      bool? hasReachedMax,
      int? pageIndex}) {
    return SpecialProductsBlocState(
        status: status ?? this.status,
        specialProductList: posts ?? this.specialProductList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        context: context,
        pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${specialProductList.length} }''';
  }

  @override
  List<Object> get props => [status, specialProductList, hasReachedMax];
}
