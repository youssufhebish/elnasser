import 'package:elnasser/models/home_model/product_class.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum OfferStatus { initial, success, failure, refresh }

class OfferBlocState extends Equatable {
  OfferBlocState({
    this.status = OfferStatus.initial,
    this.productOfferList = const <ProductClass>[],
    this.hasReachedMax = false,
    required this.context,
    this.pageIndex = 1,
  });

  final OfferStatus status;
  final List<ProductClass> productOfferList;
  final bool hasReachedMax;
  final BuildContext context;
  int pageIndex;

  OfferBlocState copyWith({
    OfferStatus? status,
    List<ProductClass>? posts,
    bool? hasReachedMax,
    int? pagIndex,
  }) {
    return OfferBlocState(
        status: status ?? this.status,
        productOfferList: posts ?? this.productOfferList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        context: context,
        pageIndex: pagIndex ?? this.pageIndex);
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${productOfferList.length} }''';
  }

  @override
  List<Object> get props => [status, productOfferList, hasReachedMax];
}
