import 'package:equatable/equatable.dart';

abstract class SpecialProductsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SpecialProductsFetch extends SpecialProductsEvent {}

class SpecialProductsReset extends SpecialProductsEvent {}
