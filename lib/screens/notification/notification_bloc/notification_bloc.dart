import 'package:dio/dio.dart';
import 'package:elnasser/models/notification_model.dart';

import 'package:elnasser/screens/notification/notification_bloc/notificationEvent.dart';
import 'package:elnasser/screens/notification/notification_bloc/notificationState.dart';
import 'package:elnasser/screens/notification/notification_data_provider/notification_data_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/throttle.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationBlocState> {
  NotificationBloc(BuildContext context)
      : super(NotificationBlocState(context: context));

  @override
  Stream<Transition<NotificationEvent, NotificationBlocState>> transformEvents(
    Stream<NotificationEvent> events,
    TransitionFunction<NotificationEvent, NotificationBlocState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<NotificationBlocState> mapEventToState(
      NotificationEvent event) async* {
    if (event is NotificationFetch) {
      yield await _mapPostFetchedToState(state);
    }
    if (event is NotificationReset) {
      yield await Refresh(state).whenComplete(() => _fetchProductsFilter(
          pageIndex: state.pageIndex, context: state.context));
    }
  }

  Future<NotificationBlocState> Refresh(
    NotificationBlocState state,
  ) async {
    print("state");
    print(state);

    try {
      List<NotificationClassModel>? productList = [];
      return state.copyWith(
        status: NotificationStatus.refresh,
        posts: productList,
        pageIndex: state.pageIndex,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: NotificationStatus.failure);
    }
  }

  Future<NotificationBlocState> _mapPostFetchedToState(
      NotificationBlocState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == NotificationStatus.initial) {
        final posts = await _fetchProductsFilter(
            pageIndex: state.pageIndex, context: state.context);
        return state.copyWith(
          status: NotificationStatus.success,
          pageIndex: state.pageIndex + 1,
          posts: posts,
          hasReachedMax: false,
        );
      }
      List<NotificationClassModel>? productsList = await _fetchProductsFilter(
          pageIndex: state.pageIndex, context: state.context);
      return productsList!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              pageIndex: state.pageIndex + 1,
              status: NotificationStatus.success,
              posts: List.of(state.NotificationList)..addAll(productsList),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: NotificationStatus.failure);
    }
  }

  Future<List<NotificationClassModel>?> _fetchProductsFilter(
      {required BuildContext context, int? pageIndex}) async {
    Response? response = await NotificationDataProvider.getNotification(
        context: context, pageIndex: pageIndex!);

    if (response!.statusCode == 200) {
      if (response.data["status"] == 200) {
        print("Notification");
        print(response.data);
        print("Notification");
        NotificationModel notificationModel =
            NotificationModel.fromJson(response.data);
        List<NotificationClassModel> product = [];
        notificationModel.data!.notifications!.forEach((element) {
          product.add(element);
        });
        print(product.length);

        return product;
      }
    } else {
      print(response.data);
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close

    return super.close();
  }
}
