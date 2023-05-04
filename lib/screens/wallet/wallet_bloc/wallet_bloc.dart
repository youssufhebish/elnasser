import 'package:dio/dio.dart';
import 'package:elnasser/models/wallet_model/Wallet_model.dart';
import 'package:elnasser/screens/wallet/wallet_data_provider/wallet_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/throttle.dart';

import 'wallet_bloc_state.dart';
import 'wallet_event.dart';

class WalletBloc extends Bloc<WalletEvent, WalletBlocState> {
  WalletBloc(BuildContext context) : super(WalletBlocState(context: context));

  @override
  Stream<Transition<WalletEvent, WalletBlocState>> transformEvents(
    Stream<WalletEvent> events,
    TransitionFunction<WalletEvent, WalletBlocState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<WalletBlocState> mapEventToState(WalletEvent event) async* {
    if (event is WalletFetch) {
      yield await _mapProductToState(state);
    }
    if (event is WalletReset) {
      yield await Refresh(state).whenComplete(() =>
          _fetchProductsTitle(pageIndex: pageIndex, context: state.context));
    }
  }

  int pageIndex = 0;

  Future<WalletBlocState> Refresh(
    WalletBlocState state,
  ) async {
    print("state");
    print(state);

    try {
      pageIndex = 0;

      List<ClientWalletOperation>? productList = [];
      WalletModel walletModel = WalletModel();
      return state.copyWith(
          status: WalletStatus.refresh,
          posts: productList,
          hasReachedMax: false,
          walletModel: walletModel);
    } on Exception {
      return state.copyWith(status: WalletStatus.failure);
    }
  }

  Future<WalletBlocState> _mapProductToState(WalletBlocState state) async {
    if (state.hasReachedMax) return state;
    try {
      pageIndex = pageIndex + 1;
      if (state.status == WalletStatus.initial) {
        WalletModel? posts = await _fetchProductsTitle(
            pageIndex: pageIndex, context: state.context);
        return state.copyWith(
            status: WalletStatus.success,
            posts: posts!.data!.clientWalletOperations,
            hasReachedMax: false,
            walletModel: posts);
      }
      List<ClientWalletOperation>? productList = [];

      WalletModel? walletModel = await _fetchProductsTitle(
          pageIndex: pageIndex, context: state.context);
      return walletModel != null
          ? walletModel.data!.clientWalletOperations!.isEmpty
              ? state.copyWith(
                  status: WalletStatus.success,
                  posts: productList,
                  hasReachedMax: false,
                  walletModel: walletModel)
              : state.copyWith(
                  status: WalletStatus.success,
                  posts: List.of(state.clientOperations)
                    ..addAll(walletModel.data!.clientWalletOperations!),
                  hasReachedMax: false,
                  walletModel: walletModel)
          : state.copyWith(
              status: WalletStatus.success,
              posts: productList,
              hasReachedMax: false,
              walletModel: walletModel);
    } on Exception {
      return state.copyWith(status: WalletStatus.failure);
    }
  }

  Future<WalletModel?> _fetchProductsTitle(
      {required BuildContext context, int? pageIndex}) async {
    Response? response = await WalletDataProvider.getWallet(
        pageIndex: pageIndex!, context: context);
    if (response!.statusCode == 200) {
      if (response.data["status"] == 200) {
        WalletModel walletModel = WalletModel.fromJson(response.data);
        List<ClientWalletOperation> product = [];
        walletModel.data!.clientWalletOperations!.forEach((element) {
          product.add(element);
        });

        print(product.length);
        print("product.length");
        print(response.data);
        print(product.length);

        return walletModel;
      }
    } else {
      print(response.data);
    }
  }
}
