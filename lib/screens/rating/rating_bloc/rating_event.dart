import 'package:equatable/equatable.dart';

abstract class RatingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RatingFetch extends RatingEvent {
  RatingFetch({required this.orderID});
  final String orderID;
}

class RatingReset extends RatingEvent {
  RatingReset({required this.orderID});
  final String orderID;
}
