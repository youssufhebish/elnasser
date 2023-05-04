import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/models/order_model/order_model_detail.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/categories/category_data_provider/category_data_provider.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_bloc_state.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit_state.dart';
import 'package:elnasser/screens/orders_screen/order_data_provider/order_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_bloc.dart';
import 'order_event.dart';

class OrderCubit extends Cubit<OrderCubitState> {
  OrderCubit() : super(OrderCubitStateInitial());

  static OrderCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> ReOrderMethod(
      {required BuildContext context, required String orderId}) async {
    Response? response =
        await OrderDataProvider.ReOrder(context: context, orderId: orderId);

    if (response!.data["status"] == 200) {
      print("Responseeeeee");
      print(response.data);
      emit(OrderCubitStateReorderSuccess());
    } else {
      emit(OrderCubitStateReorderFailed());
    }
  }

  Future<void> CancelOrderMethod(
      {required BuildContext context, required String orderId}) async {
    emit(OrderCubitStateCancelOrderLoading());
    Response? response =
        await OrderDataProvider.CancelOrder(context: context, orderId: orderId);
    print(response!.data);
    if (response.data["status"] == 200) {
      emit(OrderCubitStateCancelOrderSuccess());
    } else {
      emit(OrderCubitStateCancelOrderFailed());
    }
  }

  OrderModelDetail orderModelDetail = OrderModelDetail();
  Future<void> getOrderDetails(
      {required BuildContext context, required String orderId}) async {
    emit(OrderCubitStateLoading());

    Response? response = await OrderDataProvider.getOrderDetails(
        context: context, orderId: orderId);

    orderModelDetail = OrderModelDetail.fromJson(response!.data);
    print('///////');
    print(response.data);
    print(orderModelDetail.data!.shippingStatus);
    print('///////');

    if (orderModelDetail.status == 200) {
      emit(OrderCubitStateSuccess());
    } else {
      print(response.data);
      emit(OrderCubitStateFailed());
    }
  }

  List<int> ids = [];
  String itemsIds = "";
  getRefundedIds(List<OrderItemModel> item) {
    item.forEach((element) {
      if (element.checked == true) {
        if (!ids.contains(element.ordersItemsId!)) {
          ids.add(element.ordersItemsId!);
        }
      } else {
        ids.removeWhere((id) => element.ordersItemsId! == id);
      }
    });
    itemsIds = "";
    ids.forEach((element) {
      itemsIds += ",${element}";
    });
    itemsIds.replaceFirst(",", "");
    print(itemsIds.replaceFirst(",", ""));
    emit(OrderCubitStateRefundOrderGetIds());
  }

  ErrorModel errorModel = ErrorModel();
  Future<void> RefundApi(
      {required BuildContext context,
      required String orderId,
      required String note}) async {
    emit(OrderCubitStateRefundOrderLoading());

    Response? response = await OrderDataProvider.RefundOrder(
        context: context,
        orderId: orderId,
        note: note,
        ids: itemsIds.replaceFirst(",", ""));

    if (response!.data["status"] == 200) {
      context.read<OrderBloc>().emit(OrderBlocState(context: context));

      context.read<OrderBloc>().add(OrderFetch());
      ids.clear();
      itemsIds = "";

      emit(OrderCubitStateRefundOrderSuccess());
    } else if (response.data["status"] == 422) {
      errorModel = ErrorModel.fromJson(response.data);
      print(response.data);
      emit(OrderCubitStateRefundOrderFailed());
    } else {
      print(response.data);
      emit(OrderCubitStateRefundOrderFailed());
    }
  }
}
