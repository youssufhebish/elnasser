import 'package:elnasser/models/notification_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum NotificationStatus { initial, success, failure, refresh }

class NotificationBlocState extends Equatable {
  NotificationBlocState({
    this.status = NotificationStatus.initial,
    this.NotificationList = const <NotificationClassModel>[],
    this.hasReachedMax = false,
    required this.context,
    this.pageIndex = 1,
  });

  final NotificationStatus status;
  final List<NotificationClassModel> NotificationList;
  final bool hasReachedMax;
  final BuildContext context;
  int pageIndex;
  NotificationBlocState copyWith(
      {NotificationStatus? status,
      List<NotificationClassModel>? posts,
      bool? hasReachedMax,
      int? pageIndex}) {
    return NotificationBlocState(
        status: status ?? this.status,
        NotificationList: posts ?? this.NotificationList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        context: context,
        pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${NotificationList.length} }''';
  }

  @override
  List<Object> get props => [status, NotificationList, hasReachedMax];
}
