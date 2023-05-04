import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_state.dart';
import 'package:elnasser/screens/complete_payment/widget/payment_shared_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SelectPaymentMethod extends StatelessWidget {
  const SelectPaymentMethod({
    Key? key,
    required this.colorsValue,
  }) : super(key: key);
  final ColorsInitialValue colorsValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h - (36.h),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: PaymentSharedWidget(
          colorsValue: colorsValue,
          isReview: false,
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CustomText(
                      text: "paymentMethod".tr().toString(),
                      style: TextStyleConstant.headerTextLargeBlack(
                          context, colorsValue)),
                ),
                SizedBox(
                  height: 1.h,
                ),
                BlocConsumer<CompletePaymentCubit, CompletePaymentState>(
                    buildWhen: (prev, current) =>
                        current is CompletePaymentStatePostSuccess,
                    builder: (context, state) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: AddressCubit.get(context)
                              .addressModel
                              .data!
                              .paymentMethods!
                              .length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    if (CompletePaymentCubit.get(context)
                                            .addressModel
                                            .data!
                                            .paymentMethods![index]
                                            .paymentsSlug ==
                                        "points") {
                                      if (AddToCartCubit.get(context)
                                                  .cartModel
                                                  .data!
                                                  .cart !=
                                              null &&
                                          AddToCartCubit.get(context)
                                                  .cartModel
                                                  .data!
                                                  .cart!
                                                  .couponsCode ==
                                              null) {
                                        if ((double.parse(
                                                    "${AddToCartCubit.get(context).cartModel.data!.cart!.cartsFinalCost}") +
                                                double.parse(
                                                    "${AddressCubit.get(context).addressModel.data!.shippingMethod![CompletePaymentCubit.get(context).currentShipping].shippingMethodsDeliveryCost}")) <=
                                            double.parse(
                                                "${CompletePaymentCubit.get(context).addressModel.data!.customerPointsValue}")) {
                                          CompletePaymentCubit.get(context)
                                              .getCurrentPaymentMethod(index);
                                        }
                                      }
                                    } else if (CompletePaymentCubit.get(context)
                                            .addressModel
                                            .data!
                                            .paymentMethods![index]
                                            .paymentsSlug ==
                                        "wallet") {
                                      if ((double.parse(
                                                  "${AddToCartCubit.get(context).cartModel.data!.cart!.cartsFinalCost}") +
                                              double.parse(
                                                  "${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![CompletePaymentCubit.get(context).currentShipping].shippingMethodsDeliveryCost}")) <=
                                          double.parse(
                                              "${CompletePaymentCubit.get(context).addressModel.data!.customersWallet}")) {
                                        CompletePaymentCubit.get(context)
                                            .getCurrentPaymentMethod(index);
                                      }
                                    } else {
                                      CompletePaymentCubit.get(context)
                                          .getCurrentPaymentMethod(index);
                                    }
                                  },
                                  child: PaymentMethodItem(
                                    disable: CompletePaymentCubit.get(context)
                                                .addressModel
                                                .data!
                                                .paymentMethods !=
                                            null
                                        ? CompletePaymentCubit.get(context)
                                                    .addressModel
                                                    .data!
                                                    .paymentMethods![index]
                                                    .paymentsSlug ==
                                                "points"
                                            ? AddToCartCubit.get(context)
                                                            .cartModel
                                                            .data!
                                                            .cart !=
                                                        null &&
                                                    AddToCartCubit.get(context)
                                                            .cartModel
                                                            .data!
                                                            .cart!
                                                            .couponsCode ==
                                                        null
                                                ? (double.parse("${AddToCartCubit.get(context).cartModel.data!.cart!.cartsFinalCost}") + double.parse("${AddressCubit.get(context).addressModel.data!.shippingMethod![CompletePaymentCubit.get(context).currentShipping].shippingMethodsDeliveryCost}")) <=
                                                        double.parse(
                                                            "${CompletePaymentCubit.get(context).addressModel.data!.customerPointsValue}")
                                                    ? false
                                                    : true
                                                : true
                                            : CompletePaymentCubit.get(context)
                                                        .addressModel
                                                        .data!
                                                        .paymentMethods![index]
                                                        .paymentsSlug ==
                                                    "wallet"
                                                ? (double.parse("${AddToCartCubit.get(context).cartModel.data!.cart!.cartsFinalCost}") +
                                                            double.parse("${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![CompletePaymentCubit.get(context).currentShipping].shippingMethodsDeliveryCost}")) <=
                                                        double.parse("${CompletePaymentCubit.get(context).addressModel.data!.customersWallet}")
                                                    ? false
                                                    : true
                                                : false
                                        : false,
                                    index: index,
                                    colorsValue: colorsValue,
                                    currentIndex:
                                        CompletePaymentCubit.get(context)
                                            .currentPaymentMethod,
                                  )),
                            );
                          });
                    },
                    listener: (context, state) {}),
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

class PaymentMethodItem extends StatelessWidget {
  PaymentMethodItem(
      {Key? key,
      required this.colorsValue,
      this.disable = false,
      required this.index,
      required this.currentIndex})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final int index;
  final int currentIndex;
  bool disable;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: disable == true
            ? ColorsConstant.getColorBackground5(colorsValue)
            : null,
        border: Border.all(
            color: index == currentIndex
                ? ColorsConstant.getColorBorder2(colorsValue)
                : ColorsConstant.getColorBorder1(colorsValue)),
        borderRadius: BorderRadius.circular(8),
        // color: index == currentIndex ? ColorsConstant.getColorBackground3(colorsValue):Colors.white,
      ),
      height: 8.h,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 4.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: CachedNetworkImage(
                      imageUrl:
                          "${Commons.baseUrl}${Commons.paymentMethodsFolder}${AddressCubit.get(context).addressModel.data!.paymentMethods![index].paymentsSlug}.png",
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 1,
                  child: CustomText(
                      text:
                          "${AddressCubit.get(context).addressModel.data!.paymentMethods![index].paymentsName}",
                      style: index == currentIndex
                          ? TextStyleConstant.bodyTextMainColor(
                              context, colorsValue)
                          : TextStyleConstant.bodyTextGreyBold(
                              context, colorsValue)),
                ),
                index == currentIndex
                    ? CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            ColorsConstant.getColorBackground3(colorsValue),
                        child: Icon(
                          Icons.check,
                          size: 20,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        width: 0,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
