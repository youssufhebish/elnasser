import 'package:equatable/equatable.dart';

abstract class HomeState {}

class HomeChangeBottomNavState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomePreferenceState extends HomeState {}

class ShowSearchState extends HomeState {}

class InitialHomeState extends Equatable with HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

/// Web Home State ///
class HomeWebShowCatState extends HomeState {}

class HomeWebNextIndexState extends HomeState {}

class HomeWebPreviousIndexState extends HomeState {}

/// language

class HomeChangeLanguage extends HomeState {}

class HomeChangeLanguageValue extends HomeState {}
