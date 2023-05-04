abstract class AddToCartState {}

class AddToCartStateInitial extends AddToCartState {}

class AddToCartStateLoading extends AddToCartState {}

class AddToCartStateSuccess extends AddToCartState {}

class AddToCartStateNoStock extends AddToCartState {}

class AddToCartStateNoStockInCart extends AddToCartState {}

class AddToCartStateFailed extends AddToCartState {}

class AddToCartStateGetProductChoiceId extends AddToCartState {}

class AddToCartStateGetAmountAdd extends AddToCartState {}

class AddToCartStateGetAmountMinus extends AddToCartState {}

class AddToCartStateGetDeviceId extends AddToCartState {}

class AddToCartStateResetData extends AddToCartState {}

/// get Cart /////////

class CartStateGetCart extends AddToCartState {}

class CartStateLoading extends AddToCartState {}

class CartStateSuccess extends AddToCartState {}

class CartStateStockError extends AddToCartState {}

class CartStateFailed extends AddToCartState {}

class CartStateEmpity extends AddToCartState {}

/// dlete Cart /////////

class CartStateDeleteLoading extends AddToCartState {}

class CartStateDeleteSuccess extends AddToCartState {}

class CartStateDeleteFail extends AddToCartState {}

/// add coupon /////////

class CartStateCouponLoading extends AddToCartState {}

class CartStateCouponSuccess extends AddToCartState {}

class CartStateCouponFail extends AddToCartState {}

class CartStateCouponFailDialog extends AddToCartState {}

/// remove coupon ///
class CartStateRemoveCouponLoading extends AddToCartState {}

class CartStateRemoveCouponSuccess extends AddToCartState {}

class CartStateRemoveCouponFail extends AddToCartState {}
