import 'package:equatable/equatable.dart';

abstract class CategoryProductsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryProductsFetch extends CategoryProductsEvent {}

class CategoryProductsReset extends CategoryProductsEvent {}
