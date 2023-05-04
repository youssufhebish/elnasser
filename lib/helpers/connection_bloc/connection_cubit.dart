import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionCubit extends Cubit<InternetState> {
  late final Connectivity connectivity;
  final BuildContext context;
  late StreamSubscription connectivityStreamSubscription;

  ConnectionCubit({required this.connectivity, required this.context})
      : super(InternetInitialState()) {
    emitGetConnection(context);
  }

  void emitConnected() => emit(InternetConnectedState());
  void emitDisconnected() => emit(InternetDisconnectedState());
  void emitGetConnection(BuildContext context) {
    connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        emitDisconnected();
      } else {
        // SplashCubit.get(context).getInitial(context);
        emitConnected();
      }
    });
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        emitDisconnected();
      } else {
        emitConnected();
      }
    });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
