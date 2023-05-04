import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/models/order_model/order_model_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum OrderBlocStatus { initial, success, failure, refresh }

class OrderBlocState extends Equatable {
  OrderBlocState({
    this.status = OrderBlocStatus.initial,
    this.orderList = const <Order>[],
    this.hasReachedMax = false,
    required this.context,
    this.pageIndex = 1,
  });

  final OrderBlocStatus status;
  final List<Order> orderList;
  final bool hasReachedMax;
  final BuildContext context;
  int pageIndex;

  OrderBlocState copyWith(
      {OrderBlocStatus? status,
      List<Order>? posts,
      bool? hasReachedMax,
      int? pageIndex}) {
    return OrderBlocState(
        status: status ?? this.status,
        orderList: posts ?? this.orderList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        context: context,
        pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${orderList.length} }''';
  }

  @override
  List<Object> get props => [status, orderList, hasReachedMax];
}
