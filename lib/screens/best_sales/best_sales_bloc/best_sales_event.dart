import 'package:equatable/equatable.dart';

abstract class BestSaleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BestSalesFetch extends BestSaleEvent {}

class BestSalesReset extends BestSaleEvent {}
