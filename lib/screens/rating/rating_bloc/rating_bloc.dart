import 'package:dio/dio.dart';
import 'package:elnasser/models/rating/get_rating.dart';
import 'package:elnasser/screens/rating/rating_bloc/rating_bloc_state.dart';
import 'package:elnasser/screens/rating/rating_bloc/rating_event.dart';
import 'package:elnasser/screens/rating/rating_provider/rating_data_provider.dart';
import 'package:elnasser/screens/search_result_filter/search_result_bloc/search_result_bloc_filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/throttle.dart';

class RatingBloc extends Bloc<RatingEvent, RatingBlocState> {
  RatingBloc(BuildContext context) : super(RatingBlocState(context: context));

  @override
  Stream<Transition<RatingEvent, RatingBlocState>> transformEvents(
    Stream<RatingEvent> events,
    TransitionFunction<RatingEvent, RatingBlocState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<RatingBlocState> mapEventToState(RatingEvent event) async* {
    if (event is RatingFetch) {
      yield await _mapPostFetchedToState(state, event.orderID);
    }
    if (event is RatingReset) {
      yield await Refresh(state, event.orderID).whenComplete(() => _fetchOrder(
          pageIndex: state.pageIndex,
          context: state.context,
          orderId: event.orderID));
    }
  }

  Future<RatingBlocState> Refresh(RatingBlocState state, String orderId) async {
    try {
      List<RatingProduct> ratings = [];
      GetRatingModel? ratingModel = await _fetchOrder(
          pageIndex: state.pageIndex, context: state.context, orderId: orderId);
      return state.copyWith(
          status: RatingBlocStatus.refresh,
          ratingList: ratings,
          pageIndex: 1,
          hasReachedMax: false,
          ratingModel: ratingModel);
    } on Exception {
      return state.copyWith(status: RatingBlocStatus.failure);
    }
  }

  Future<RatingBlocState> _mapPostFetchedToState(
      RatingBlocState state, String orderId) async {
    print("state");
    print(state);
    if (state.hasReachedMax) return state;
    try {
      if (state.status == RatingBlocStatus.initial) {
        GetRatingModel? ratingModel = await _fetchOrder(
            pageIndex: state.pageIndex,
            context: state.context,
            orderId: orderId);
        return state.copyWith(
            status: RatingBlocStatus.success,
            ratingList: ratingModel!.data!.ratings,
            pageIndex: state.pageIndex + 1,
            hasReachedMax: false,
            ratingModel: ratingModel);
      }
      GetRatingModel? ratingModel = await _fetchOrder(
          pageIndex: state.pageIndex, context: state.context, orderId: orderId);
      return ratingModel!.data!.ratings!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: RatingBlocStatus.success,
              pageIndex: state.pageIndex + 1,
              ratingList: List.of(state.ratingList)
                ..addAll(ratingModel.data!.ratings!),
              hasReachedMax: false,
              ratingModel: ratingModel);
    } on Exception {
      return state.copyWith(status: RatingBlocStatus.failure);
    }
  }

  Future<GetRatingModel?> _fetchOrder(
      {required BuildContext context,
      int? pageIndex,
      required String orderId}) async {
    Response? response = await RatingDataProvider.getRating(
        context: context, page: pageIndex!, orderId: orderId);
    if (response!.statusCode == 200) {
      if (response.data["status"] == 200) {
        GetRatingModel ratingModel = GetRatingModel.fromJson(response.data);
        List<RatingProduct> orders = [];
        ratingModel.data!.ratings!.forEach((element) {
          orders.add(element);
        });

        return ratingModel;
      }
    } else {
      print(response.data);
    }
  }
}
