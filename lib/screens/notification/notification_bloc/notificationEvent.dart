import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NotificationFetch extends NotificationEvent {}

class NotificationReset extends NotificationEvent {}
