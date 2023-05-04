import 'package:elnasser/models/best_sales/best_sales_model.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum BestSalesStatus { initial, success, failure, refresh }

class BestSalesBlocState extends Equatable {
  BestSalesBlocState(
      {this.status = BestSalesStatus.initial,
      this.bestSalesList = const <ProductClass>[],
      this.hasReachedMax = false,
      required this.context,
      this.pageIndex = 1});

  final BestSalesStatus status;
  final List<ProductClass> bestSalesList;
  final bool hasReachedMax;
  final BuildContext context;
  int pageIndex;

  BestSalesBlocState copyWith({
    BestSalesStatus? status,
    List<ProductClass>? posts,
    bool? hasReachedMax,
    int? pageIndex,
  }) {
    return BestSalesBlocState(
      status: status ?? this.status,
      bestSalesList: posts ?? this.bestSalesList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      context: context,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${bestSalesList.length} }''';
  }

  @override
  List<Object> get props => [status, bestSalesList, hasReachedMax];
}
