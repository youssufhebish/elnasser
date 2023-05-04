import 'package:equatable/equatable.dart';

abstract class OfferEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OfferFetch extends OfferEvent {}

class OfferReset extends OfferEvent {}
