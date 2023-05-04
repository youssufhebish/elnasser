import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderFetch extends OrderEvent {}

class OrderReset extends OrderEvent {}
