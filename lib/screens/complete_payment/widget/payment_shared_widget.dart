import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_state.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../Info_screen.dart';

class PaymentSharedWidget extends StatelessWidget {
  const PaymentSharedWidget({
    Key? key,
    required this.isReview,
    required this.colorsValue,
  }) : super(key: key);
  final ColorsInitialValue colorsValue;
  final bool isReview;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "PaymentSharedWidget",
      child: Card(
        elevation: 0,
        child: BlocBuilder<CompletePaymentCubit, CompletePaymentState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  // so here your custom shadow goes:
                  BoxShadow(
                    color: Colors.black.withAlpha(
                        30), // the color of a shadow, you can adjust it
                    spreadRadius:
                        3, //also play with this two values to achieve your ideal result
                    blurRadius: 7,
                    offset: Offset(0,
                        -7), // changes position of shadow, negative value on y-axis makes it appering only on the top of a container
                  ),
                ],
              ),
              height: isReview == true ? 18.h : 23.h,
              //margin: const EdgeInsets.all(0),
              //alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        CustomText(
                            text: "${"reviewSupTotal".tr().toString()} ",
                            style: TextStyleConstant.optionalText(
                                context, colorsValue)),
                        Spacer(),
                        CustomText(
                            text:
                                "${AddToCartCubit.get(context).cartModel.data!.cart!.cartsPrice} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                            style: TextStyleConstant.optionalText(
                                context, colorsValue)),
                      ],
                    ),
                    AddToCartCubit.get(context)
                                .cartModel
                                .data!
                                .cart!
                                .couponsValue !=
                            null
                        ? Row(
                            children: [
                              CustomText(
                                  text: "${"discount".tr().toString()} ",
                                  style: TextStyleConstant.optionalText(
                                      context, colorsValue)),
                              Spacer(),
                              CustomText(
                                  text:
                                      "${AddToCartCubit.get(context).cartModel.data!.cart!.couponsValue} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                                  style: TextStyleConstant.optionalText(
                                      context, colorsValue)),
                            ],
                          )
                        : Container(),
                    Row(
                      children: [
                        CustomText(
                            text: "${"deliveryCost".tr().toString()} ",
                            style: TextStyleConstant.optionalText(
                                context, colorsValue)),
                        Spacer(),
                        CustomText(
                            text: AddressCubit.get(context)
                                        .addressModel
                                        .data!
                                        .shippingMethod![
                                            CompletePaymentCubit.get(context)
                                                .currentShipping]
                                        .shippingMethodsDeliveryCost ==
                                    "0"
                                ? "free".tr().toString()
                                : "${AddressCubit.get(context).addressModel.data!.shippingMethod![CompletePaymentCubit.get(context).currentShipping].shippingMethodsDeliveryCost} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                            style: TextStyleConstant.optionalText(
                                context, colorsValue)),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: "${"reviewTotal".tr().toString()} ",
                            style: TextStyleConstant.headerText(
                                context, colorsValue)),
                        Spacer(),
                        CustomText(
                            text:
                                "${double.parse("${AddToCartCubit.get(context).cartModel.data!.cart!.cartsFinalCost}") + double.parse("${AddressCubit.get(context).addressModel.data!.shippingMethod![CompletePaymentCubit.get(context).currentShipping].shippingMethodsDeliveryCost}")} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                            style: TextStyleConstant.bodyTextMainColor(
                                context, colorsValue)),
                      ],
                    ),
                    isReview == true
                        ? Container()
                        : CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            title: InkWell(
                                onTap: () {
                                  SplashCubit.get(context)
                                              .theInitialModel
                                              .data!
                                              .info!
                                              .infosReturnExchangePolicy !=
                                          null
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => InfoScreen(
                                                    data: SplashCubit.get(
                                                            context)
                                                        .theInitialModel
                                                        .data!
                                                        .info!
                                                        .infosReturnExchangePolicy!,
                                                    title:
                                                        'returnAndExchangePolicy',
                                                    colorsValue: colorsValue,
                                                  )))
                                      : print("0000000");
                                },
                                child: Container(
                                    height: 5.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: "termsAndConditions"
                                              .tr()
                                              .toString(),
                                          style: TextStyleConstant
                                              .bodyTextMainColor(
                                                  context, colorsValue),
                                        ),
                                      ],
                                    ))),
                            value: CompletePaymentCubit.get(context).termsValue,
                            onChanged: (v) {
                              CompletePaymentCubit.get(context)
                                  .changeDefaultValue(v!);
                            })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
