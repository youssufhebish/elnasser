import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/cart_widget/cart_item.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import 'payment_shared_widget.dart';

class Review extends StatelessWidget {
  const Review({
    Key? key,
    required this.colorsValue,
  }) : super(key: key);
  final ColorsInitialValue colorsValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h - (36.h),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: PaymentSharedWidget(
          colorsValue: colorsValue,
          isReview: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                CustomText(
                    text: "address".tr().toString(),
                    style: TextStyleConstant.headerTextLargeBlack(
                        context, colorsValue)),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  height: 15.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                          text:
                              "${CompletePaymentCubit.get(context).addressModel.data!.addresses![CompletePaymentCubit.get(context).currentAddressIndex].customerAddressesName}",
                          style: TextStyleConstant.bodyTextLarge(
                              context, colorsValue)),
                      CustomText(
                          text:
                              "${CompletePaymentCubit.get(context).addressModel.data!.addresses![CompletePaymentCubit.get(context).currentAddressIndex].customerAddressesAddress}",
                          style: TextStyleConstant.optionalText(
                              context, colorsValue)),
                      CustomText(
                          text:
                              "${CompletePaymentCubit.get(context).addressModel.data!.addresses![CompletePaymentCubit.get(context).currentAddressIndex].customerAddressesPhone}",
                          style: TextStyleConstant.optionalText(
                              context, colorsValue)),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 1.h,
                ),
                CustomText(
                    text: "shippingOption".tr().toString(),
                    style: TextStyleConstant.headerTextLargeBlack(
                        context, colorsValue)),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  height: 15.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                          text:
                              "${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![CompletePaymentCubit.get(context).currentShipping].shippingMethodsTitle}",
                          style: TextStyleConstant.bodyTextLarge(
                              context, colorsValue)),
                      CustomText(
                          text:
                              "${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![CompletePaymentCubit.get(context).currentShipping].shippingMethodsText}",
                          style: TextStyleConstant.optionalText(
                              context, colorsValue)),
                      CustomText(
                          text:
                              "${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![CompletePaymentCubit.get(context).currentShipping].shippingMethodsDeliveryCost}  ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                          style: TextStyleConstant.optionalText(
                              context, colorsValue)),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 1.h,
                ),
                CustomText(
                    text: "cart".tr().toString(),
                    style: TextStyleConstant.headerTextLargeBlack(
                        context, colorsValue)),
                SizedBox(
                  height: 1.h,
                ),
                BlocConsumer<AddToCartCubit, AddToCartState>(
                  buildWhen: (prev, current) =>
                      (current is AddToCartStateSuccess ||
                              current is CartStateDeleteSuccess)
                          ? true
                          : false,
                  builder: (context, state) {
                    return ListView.builder(
                        itemCount: AddToCartCubit.get(context)
                            .cartModel
                            .data!
                            .cart!
                            .items!
                            .length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CardCartItem(
                            isReview: true,
                            colorsValue: colorsValue,
                            cartItem: AddToCartCubit.get(context)
                                .cartModel
                                .data!
                                .cart!
                                .items![index],
                          );
                        });
                  },
                  listener: (context, state) {
                    if (state is CartStateSuccess ||
                        state is AddToCartStateInitial ||
                        state is AddToCartStateGetDeviceId) {}
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                AppTextFiled(
                  maxLines: 4,
                  textAlign: TextAlign.start,
                  password: false,
                  labelText: 'note'.tr().toString(),
                  colorsInitialValue: colorsValue,
                  validation: true,
                  controller: CompletePaymentCubit.get(context).controllerNote,
                  inputType: TextInputType.text,
                  nextNode: null,
                  hintText: 'note'.tr().toString(),
                  node: null,
                  validationWidget: Container(
                    width: 0,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
