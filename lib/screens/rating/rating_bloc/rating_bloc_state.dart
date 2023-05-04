import 'package:elnasser/models/rating/get_rating.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum RatingBlocStatus { initial, success, failure, refresh }

class RatingBlocState extends Equatable {
  RatingBlocState({
    this.status = RatingBlocStatus.initial,
    this.ratingModel = const GetRatingModel(),
    this.hasReachedMax = false,
    this.ratingList = const <RatingProduct>[],
    this.pageIndex = 1,
    required this.context,
  });
  final RatingBlocStatus status;
  final GetRatingModel ratingModel;

  final bool hasReachedMax;
  final BuildContext context;
  final List<RatingProduct> ratingList;
  int pageIndex;

  RatingBlocState copyWith(
      {RatingBlocStatus? status,
      GetRatingModel? ratingModel,
      List<RatingProduct>? ratingList,
      bool? hasReachedMax,
      int? pageIndex}) {
    return RatingBlocState(
        status: status ?? this.status,
        ratingModel: ratingModel ?? this.ratingModel,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        context: context,
        ratingList: ratingList ?? this.ratingList,
        pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${ratingModel}, posts: ${ratingList} }''';
  }

  @override
  List<Object> get props => [status, ratingModel, ratingList, hasReachedMax];
}
