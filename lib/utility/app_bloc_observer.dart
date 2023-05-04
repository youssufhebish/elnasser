import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onClose(BlocBase cubit) {
    // TODO: implement onClose
    super.onClose(cubit);
  }

  @override
  void onCreate(BlocBase cubit) {
    print(cubit);
    super.onCreate(cubit);
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
  }
}
