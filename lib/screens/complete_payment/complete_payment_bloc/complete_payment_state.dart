abstract class CompletePaymentState {}

class CompletePaymentStateInitial extends CompletePaymentState {}

class CompletePaymentStateNext extends CompletePaymentState {}

class CompletePaymentStateBack extends CompletePaymentState {}

class CompletePaymentStateShared extends CompletePaymentState {}

/// Address
class CompletePaymentStateGetCurrentAddress extends CompletePaymentState {}

class CompletePaymentStateAddressLoading extends CompletePaymentState {}

class CompletePaymentStateAddressSuccess extends CompletePaymentState {}

class CompletePaymentStateAddressFail extends CompletePaymentState {}

/// review
class CompletePaymentStateReviewLoading extends CompletePaymentState {}

class CompletePaymentStateReviewSuccess extends CompletePaymentState {}

class CompletePaymentStateReviewFail extends CompletePaymentState {}

/// Shipping
class CompletePaymentStateGetCurrentShipping extends CompletePaymentState {}

/// payment methods
class CompletePaymentStateCheckBox extends CompletePaymentState {}

class CompletePaymentStateGetCurrentPaymentMethods
    extends CompletePaymentState {}

/// post Order
class CompletePaymentStatePostLoading extends CompletePaymentState {}

class CompletePaymentStatePostSuccess extends CompletePaymentState {}

class CompletePaymentStatePostFail extends CompletePaymentState {}

class CompletePaymentStatePostNoStock extends CompletePaymentState {}

class CompletePaymentStatePostReset extends CompletePaymentState {}
