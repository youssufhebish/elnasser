abstract class OrderCubitState {}

class OrderCubitStateInitial extends OrderCubitState {}

class OrderCubitStateShared extends OrderCubitState {}

class OrderCubitStateLoading extends OrderCubitState {}

class OrderCubitStateSuccess extends OrderCubitState {}

class OrderCubitStateFailed extends OrderCubitState {}

/// ReOrder
class OrderCubitStateReorderLoading extends OrderCubitState {}

class OrderCubitStateReorderSuccess extends OrderCubitState {}

class OrderCubitStateReorderFailed extends OrderCubitState {}

/// cancel order
class OrderCubitStateCancelOrderLoading extends OrderCubitState {}

class OrderCubitStateCancelOrderSuccess extends OrderCubitState {}

class OrderCubitStateCancelOrderFailed extends OrderCubitState {}

/// refund order
class OrderCubitStateRefundOrderGetIds extends OrderCubitState {}

class OrderCubitStateRefundOrderLoading extends OrderCubitState {}

class OrderCubitStateRefundOrderSuccess extends OrderCubitState {}

class OrderCubitStateRefundOrderFailed extends OrderCubitState {}
