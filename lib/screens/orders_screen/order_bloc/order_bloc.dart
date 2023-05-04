import 'package:dio/dio.dart';
import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/models/order_model/order_model_detail.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_bloc_state.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_event.dart';
import 'package:elnasser/screens/orders_screen/order_data_provider/order_data_provider.dart';
import 'package:elnasser/screens/search_result_filter/search_result_bloc/search_result_bloc_filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/throttle.dart';

class OrderBloc extends Bloc<OrderEvent, OrderBlocState> {
  OrderBloc(BuildContext context) : super(OrderBlocState(context: context));

  @override
  Stream<Transition<OrderEvent, OrderBlocState>> transformEvents(
    Stream<OrderEvent> events,
    TransitionFunction<OrderEvent, OrderBlocState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<OrderBlocState> mapEventToState(OrderEvent event) async* {
    if (event is OrderFetch) {
      yield await _mapPostFetchedToState(state);
    }
    if (event is OrderReset) {
      yield await Refresh(state).whenComplete(() =>
          _fetchOrder(pageIndex: state.pageIndex, context: state.context));
    }
  }

  Future<OrderBlocState> Refresh(
    OrderBlocState state,
  ) async {
    print("state");
    print(state);

    try {
      List<Order>? productList = [];
      return state.copyWith(
        status: OrderBlocStatus.refresh,
        posts: productList,
        pageIndex: state.pageIndex,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: OrderBlocStatus.failure);
    }
  }

  Future<OrderBlocState> _mapPostFetchedToState(OrderBlocState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == OrderBlocStatus.initial) {
        final posts = await _fetchOrder(
            pageIndex: state.pageIndex, context: state.context);
        return state.copyWith(
          status: OrderBlocStatus.success,
          pageIndex: state.pageIndex + 1,
          posts: posts,
          hasReachedMax: false,
        );
      }
      List<Order>? productsList =
          await _fetchOrder(pageIndex: state.pageIndex, context: state.context);
      return productsList!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              pageIndex: state.pageIndex + 1,
              status: OrderBlocStatus.success,
              posts: List.of(state.orderList)..addAll(productsList),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: OrderBlocStatus.failure);
    }
  }

  Future<List<Order>?> _fetchOrder(
      {required BuildContext context, int? pageIndex}) async {
    Response? response = await OrderDataProvider.getOrders(context: context);
    if (response!.statusCode == 200) {
      if (response.data["status"] == 200) {
        OrderModel productModel = OrderModel.fromJson(response.data);
        List<Order> orders = [];

        productModel.data!.orders!.forEach((element) {
          orders.add(element);
          if (element.ordersId == 1302) {
            // print('1320');
            // print(element.productRating!.length);
          }
        });
        print(orders.length);

        return orders;
      }
    } else {
      print(response.data);
    }
  }
}
