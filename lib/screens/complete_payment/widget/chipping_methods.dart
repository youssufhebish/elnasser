import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ShippingMethods extends StatelessWidget {
  const ShippingMethods({Key? key, required this.colorsValue})
      : super(key: key);
  final ColorsInitialValue colorsValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h - (36.h),
      width: SizeDataConstant.fullWidth(context),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            CustomText(
                text: "shippingMethod".tr(),
                style: TextStyleConstant.headerText(context, colorsValue)),
            SizedBox(
              height: 2.h,
            ),
            CompletePaymentCubit.get(context).addressModel.data != null
                ? BlocBuilder<CompletePaymentCubit, CompletePaymentState>(
                    builder: (context, state) {
                    bool isFree = false;
                    CompletePaymentCubit.get(context)
                        .addressModel
                        .data!
                        .shippingMethod!
                        .forEach((element) {
                      if (element.shippingMethodsOrderLimit != null) {
                        if (double.parse(
                                    "${element.shippingMethodsOrderLimit}") -
                                double.parse(
                                    "${AddToCartCubit.get(context).cartModel.data!.cart!.cartsPrice}") <=
                            0) {
                          isFree = true;
                        }
                      }
                    });
                    print('ISFree:$isFree');
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: CompletePaymentCubit.get(context)
                          .addressModel
                          .data!
                          .shippingMethod!
                          .length,
                      itemBuilder: (context, index) {
                        return (isFree == true &&
                                CompletePaymentCubit.get(context)
                                        .addressModel
                                        .data!
                                        .shippingMethod![index]
                                        .shippingMethodsOrderLimit !=
                                    null)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      // if (CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![index].shippingMethodsOrderLimit == null) {
                                      //   CompletePaymentCubit.get(context)
                                      //       .getShipping(index);
                                      // } else if (CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![index].shippingMethodsOrderLimit != null &&double.parse(
                                      //             "${AddToCartCubit.get(context).cartModel.data!.cart!.cartsFinalCost}") > double.parse("${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![index].shippingMethodsOrderLimit}")) {
                                      //
                                      //

                                      CompletePaymentCubit.get(context)
                                          .getShipping(index);
                                      // }
                                    },
                                    child: ShippingItem(
                                      colorsValue: colorsValue,
                                      index: index,
                                      shippingMethodsOrderLimit:
                                          CompletePaymentCubit.get(context)
                                              .addressModel
                                              .data!
                                              .shippingMethod![index]
                                              .shippingMethodsOrderLimit,
                                      currentIndex:
                                          CompletePaymentCubit.get(context)
                                              .currentShipping,
                                    )),
                              )
                            : (isFree == false)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          if (CompletePaymentCubit.get(context)
                                                  .addressModel
                                                  .data!
                                                  .shippingMethod![index]
                                                  .shippingMethodsOrderLimit ==
                                              null) {
                                            CompletePaymentCubit.get(context)
                                                .getShipping(index);
                                          } else if (CompletePaymentCubit.get(
                                                          context)
                                                      .addressModel
                                                      .data!
                                                      .shippingMethod![index]
                                                      .shippingMethodsOrderLimit !=
                                                  null &&
                                              double.parse(
                                                      "${AddToCartCubit.get(context).cartModel.data!.cart!.cartsFinalCost}") >
                                                  double.parse(
                                                      "${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![index].shippingMethodsOrderLimit}")) {
                                            print(
                                                '${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![index].shippingMethodsOrderLimit}');
                                            print(
                                                '${AddToCartCubit.get(context).cartModel.data!.cart!.cartsFinalCost}');

                                            CompletePaymentCubit.get(context)
                                                .getShipping(index);
                                          }
                                        },
                                        child: ShippingItem(
                                          colorsValue: colorsValue,
                                          index: index,
                                          shippingMethodsOrderLimit:
                                              CompletePaymentCubit.get(context)
                                                  .addressModel
                                                  .data!
                                                  .shippingMethod![index]
                                                  .shippingMethodsOrderLimit,
                                          currentIndex:
                                              CompletePaymentCubit.get(context)
                                                  .currentShipping,
                                        )),
                                  )
                                : Container();
                      },
                    );
                  })
                : Container()
          ],
        ),
      )),
    );
  }
}

class ShippingItem extends StatelessWidget {
  ShippingItem(
      {Key? key,
      required this.colorsValue,
      required this.index,
      required this.shippingMethodsOrderLimit,
      required this.currentIndex})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final int index;
  final int currentIndex;
  String? shippingMethodsOrderLimit;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: index == currentIndex
                ? ColorsConstant.getColorBorder2(colorsValue)
                : ColorsConstant.getColorBorder1(colorsValue)),
        borderRadius: BorderRadius.circular(8),
        color: index == currentIndex
            ? ColorsConstant.getColorBackground3(colorsValue)
            : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomText(
                      text:
                          "${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![index].shippingMethodsTitle}",
                      style: index == currentIndex
                          ? TextStyleConstant.bodyTextWhiteBold(
                              context, colorsValue)
                          : TextStyleConstant.bodyTextGreyBold(
                              context, colorsValue)),
                ),
                index == currentIndex
                    ? CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.check,
                          size: 20,
                          color:
                              ColorsConstant.getColorBackground3(colorsValue),
                        ),
                      )
                    : Container(
                        width: 0,
                      ),
              ],
            ),
            shippingMethodsOrderLimit != null
                ? double.parse("${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![index].shippingMethodsOrderLimit}") -
                            double.parse(
                                "${AddToCartCubit.get(context).cartModel.data!.cart!.cartsPrice}") >
                        0
                    ? Row(
                        children: [
                          CustomText(
                              text:
                                  "${"need".tr()} ${double.parse("${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![index].shippingMethodsOrderLimit}") - double.parse("${AddToCartCubit.get(context).cartModel.data!.cart!.cartsPrice}")} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ${"forFreeShipping".tr().toString()} ",
                              style: index == currentIndex
                                  ? TextStyleConstant.whiteText(
                                      context, colorsValue)
                                  : TextStyleConstant.bodyTextGrey(
                                      context, colorsValue)),
                        ],
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      )
                : Container(
                    height: 0,
                    width: 0,
                  ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomText(
                      text:
                          "${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![index].shippingMethodsText}",
                      style: index == currentIndex
                          ? TextStyleConstant.whiteText(context, colorsValue)
                          : TextStyleConstant.bodyTextGrey(
                              context, colorsValue)),
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(
                    text: CompletePaymentCubit.get(context)
                                .addressModel
                                .data!
                                .shippingMethod![index]
                                .shippingMethodsDeliveryCost ==
                            "0"
                        ? "free".tr().toString()
                        : "${CompletePaymentCubit.get(context).addressModel.data!.shippingMethod![index].shippingMethodsDeliveryCost} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                    style: index == currentIndex
                        ? TextStyleConstant.whiteText(context, colorsValue)
                        : TextStyleConstant.bodyTextGrey(context, colorsValue)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
