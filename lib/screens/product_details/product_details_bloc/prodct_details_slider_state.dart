abstract class ProductDetailsSliderState {}

class ProductDetailsSliderInitialState extends ProductDetailsSliderState {}

class ProductDetailsSliderIndexState extends ProductDetailsSliderState {}

class ProductDetailsSliderChoiceState extends ProductDetailsSliderState {}

class ProductDetailsSliderAttributeChoiceState
    extends ProductDetailsSliderState {}

class ProductDetailsSliderActiveIndicatorState
    extends ProductDetailsSliderState {}

class ProductDetailsSliderReset extends ProductDetailsSliderState {}

class ProductDetailsStateLoading extends ProductDetailsSliderState {}

class ProductDetailsStateSuccess extends ProductDetailsSliderState {}

class ProductDetailsStateFail extends ProductDetailsSliderState {}

///  New Api V002;
///
class SliderListAttributeState extends ProductDetailsSliderState {}

class GetAttributeChoiceState extends ProductDetailsSliderState {}
