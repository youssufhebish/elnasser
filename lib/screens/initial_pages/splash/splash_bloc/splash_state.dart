enum SplashStatus { initial, success, failure }

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashShared extends SplashState {}

class SplashSuccess extends SplashState {}

class SplashFailure extends SplashState {}

class SplashGetAppData extends SplashState {}

class SplashChangeLanguage extends SplashState {}
