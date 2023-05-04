import 'package:equatable/equatable.dart';

abstract class NewArrivalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewArrivalFetch extends NewArrivalEvent {}

class NewArrivalReset extends NewArrivalEvent {}
