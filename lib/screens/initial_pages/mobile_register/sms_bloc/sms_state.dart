abstract class SmsState {}

class SmsStateInitial extends SmsState {}

class SmsStateCountryCode extends SmsState {}

class SmsStateLoading extends SmsState {}

class SmsStateSuccess extends SmsState {}

class SmsStateFailure extends SmsState {}

class SmsStateShared extends SmsState {}

///
class SmsStateSendLoading extends SmsState {}

class SmsStateSendSuccess extends SmsState {}

class SmsStateSendFailure extends SmsState {}

///
class SmsStateCheckCodeLoading extends SmsState {}

class SmsStateCheckCodeSuccess extends SmsState {}

class SmsStateCheckCodeFailure extends SmsState {}

/// forget password
class SmsStateForgetLoading extends SmsState {}

class SmsStateForgetSuccess extends SmsState {}

class SmsStateForgetFailure extends SmsState {}
