import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WalletFetch extends WalletEvent {}

class WalletReset extends WalletEvent {}
