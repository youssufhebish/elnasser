import 'package:elnasser/models/home_model/product_class.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum NewArrivalStatus { initial, success, failure, refresh }

class NewArrivalBlocState extends Equatable {
  NewArrivalBlocState(
      {this.status = NewArrivalStatus.initial,
      this.bestSalesList = const <ProductClass>[],
      this.hasReachedMax = false,
      required this.context,
      this.pageIndex = 1});

  final NewArrivalStatus status;
  final List<ProductClass> bestSalesList;
  final bool hasReachedMax;
  final BuildContext context;
  int pageIndex;

  NewArrivalBlocState copyWith({
    NewArrivalStatus? status,
    List<ProductClass>? posts,
    bool? hasReachedMax,
    int? pageIndex,
  }) {
    return NewArrivalBlocState(
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
