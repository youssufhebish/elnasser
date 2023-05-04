import 'package:elnasser/models/wallet_model/Wallet_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum WalletStatus { initial, success, failure, refresh }

class WalletBlocState extends Equatable {
  const WalletBlocState(
      {this.status = WalletStatus.initial,
      this.clientOperations = const <ClientWalletOperation>[],
      this.hasReachedMax = false,
      required this.context,
      this.walletModel});

  final WalletStatus status;
  final List<ClientWalletOperation> clientOperations;
  final WalletModel? walletModel;
  final bool hasReachedMax;
  final BuildContext context;

  WalletBlocState copyWith({
    WalletStatus? status,
    WalletModel? walletModel,
    List<ClientWalletOperation>? posts,
    bool? hasReachedMax,
  }) {
    return WalletBlocState(
        status: status ?? this.status,
        walletModel: walletModel ?? this.walletModel,
        clientOperations: posts ?? this.clientOperations,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        context: context);
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${clientOperations.length} }''';
  }

  @override
  List<Object> get props => [status, clientOperations, hasReachedMax];
}
