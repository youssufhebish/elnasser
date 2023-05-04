abstract class RatingOrderState {}

class RatingOrderStateInitial extends RatingOrderState {}

class RatingOrderStateGenerateControllers extends RatingOrderState {}

class RatingOrderStateGenerateProductList extends RatingOrderState {}

class RatingOrderStateGetShoppingRate extends RatingOrderState {}

class RatingOrderStateGetDeliveryRate extends RatingOrderState {}

class RatingOrderStateGetSize extends RatingOrderState {}

class RatingOrderStateGetQuality extends RatingOrderState {}

class RatingOrderStateGetPrice extends RatingOrderState {}

class RatingOrderStateGetMatch extends RatingOrderState {}

class RatingOrderStateGenerateLists extends RatingOrderState {}

class RatingOrderStateEdit extends RatingOrderState {}

class RatingOrderStateSubmitLoading extends RatingOrderState {}

class RatingOrderStateSubmitSuccess extends RatingOrderState {}

class RatingOrderStateSubmitFail extends RatingOrderState {}

class RatingOrderStateSubmitClear extends RatingOrderState {}
