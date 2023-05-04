import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/address/address_bloc/address_state.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import 'complete_payment_bloc/complete_payment_state.dart';

class CompletePayment extends StatelessWidget {
  const CompletePayment({Key? key, required this.colorsValue})
      : super(key: key);
  final ColorsInitialValue colorsValue;

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionCubit, InternetState>(
        builder: (context, state) {
      print('Current State $state');
      if (state is InternetDisconnectedState) {
        return NoInterNetWidget();
      } else {
        return Container(
          color: Colors.white,
          child: SafeArea(
              child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              title: CustomText(
                text: "payment".tr().toString(),
                style: TextStyleConstant.headerText(context, colorsValue),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.chevron_left,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: Responsive.isMobile(context) ? 70 : 8.h,
                    child: Row(
                      children: [
                        Spacer(),
                        BlocBuilder<CompletePaymentCubit, CompletePaymentState>(
                          builder: (context, state) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                CompletePaymentCubit.get(context).steps.length,
                                (index) => InkWell(
                                  onTap: () {
                                    // CompletePaymentCubit.get(context).goToStep(index);
                                  },
                                  child: BlocBuilder<CompletePaymentCubit,
                                      CompletePaymentState>(
                                    builder: (context, state) {
                                      return StepperWidget(
                                        index: index,
                                        currentIndex:
                                            CompletePaymentCubit.get(context)
                                                .currentStep,
                                        colorsValue: colorsValue,
                                        title: CompletePaymentCubit.get(context)
                                            .steps[index],
                                        image: CompletePaymentCubit.get(context)
                                            .images[index],
                                        isLast: index ==
                                                CompletePaymentCubit.get(
                                                            context)
                                                        .steps
                                                        .length -
                                                    1
                                            ? true
                                            : false,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Spacer(),
                      ],
                    )),
                BlocBuilder<CompletePaymentCubit, CompletePaymentState>(
                    builder: (context, state) {
                  return CompletePaymentCubit.get(context)
                          .stepsWidget(colorsValue)[
                      CompletePaymentCubit.get(context).currentStep];
                }),
                Spacer(),
                BlocConsumer<CompletePaymentCubit, CompletePaymentState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 8.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CompletePaymentCubit.get(context).currentStep ==
                                0
                            ? Center(
                                child: BlocBuilder<AddressCubit, AddressState>(
                                  buildWhen: (prev, current) => (current
                                          is AddressStateShared ||
                                      current is AddressStateAddressSuccess ||
                                      current is AddressStateGetCurrentAddress),
                                  builder: (context, state) {
                                    return AppButton(
                                      disable:
                                          (CompletePaymentCubit.get(context)
                                                      .currentAddressIndex !=
                                                  -1)
                                              ? false
                                              : true,
                                      colorsInitialValue: colorsValue,
                                      color: ColorsConstant.getColorBackground3(
                                          colorsValue),
                                      textStyle: TextStyleConstant.buttonText(
                                          context, colorsValue),
                                      title: "next".tr().toString(),
                                      onPressed: () {
                                        CompletePaymentCubit.get(context)
                                            .goNext(context);
                                      },
                                      withBorder: false,
                                    );
                                  },
                                ),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: AppButton(
                                      colorsInitialValue: colorsValue,
                                      color: ColorsConstant.getColorBackground3(
                                          colorsValue),
                                      textStyle:
                                          TextStyleConstant.bodyTextMainColor(
                                              context, colorsValue),
                                      title: "back".tr().toString(),
                                      onPressed: () {
                                        CompletePaymentCubit.get(context)
                                            .goBack();
                                      },
                                      withBorder: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AppButton(
                                      disable: (CompletePaymentCubit.get(
                                                          context)
                                                      .currentStep ==
                                                  1 &&
                                              CompletePaymentCubit.get(context)
                                                      .currentShipping ==
                                                  -1)
                                          ? true
                                          : (CompletePaymentCubit.get(context)
                                                          .currentStep ==
                                                      3 &&
                                                  (CompletePaymentCubit.get(
                                                                  context)
                                                              .termsValue ==
                                                          false ||
                                                      CompletePaymentCubit.get(
                                                                  context)
                                                              .currentPaymentMethod ==
                                                          -1))
                                              ? true
                                              : false,
                                      colorsInitialValue: colorsValue,
                                      color: ColorsConstant.getColorBackground3(
                                          colorsValue),
                                      textStyle: TextStyleConstant.buttonText(
                                          context, colorsValue),
                                      title: CompletePaymentCubit.get(context)
                                                  .currentStep ==
                                              3
                                          ? "PlaceOrder".tr().toString()
                                          : "next".tr().toString(),
                                      onPressed: () {
                                        if (CompletePaymentCubit.get(context)
                                                .currentStep ==
                                            3) {
                                          CompletePaymentCubit.get(context)
                                              .updateCart(context)
                                              .whenComplete(() =>
                                                  CompletePaymentCubit.get(
                                                          context)
                                                      .PostOrderMethods(
                                                          context));
                                          // CompletePaymentCubit.get(context).updateCart(context);

                                        } else if (CompletePaymentCubit.get(
                                                    context)
                                                .currentStep ==
                                            1) {
                                          CompletePaymentCubit.get(context)
                                              .goNext(context);

                                          AddToCartCubit.get(context)
                                              .getCart(context: context);
                                        } else if (CompletePaymentCubit.get(
                                                    context)
                                                .currentStep ==
                                            2) {
                                          if (AddToCartCubit.get(context)
                                                      .cartModel
                                                      .data!
                                                      .errors ==
                                                  null ||
                                              AddToCartCubit.get(context)
                                                  .cartModel
                                                  .data!
                                                  .errors!
                                                  .isEmpty) {
                                            print('xxxxxxxx');
                                            CompletePaymentCubit.get(context)
                                                .goNext(context);
                                          } else {
                                            String errors = "";
                                            AddToCartCubit.get(context)
                                                .cartModel
                                                .data!
                                                .errors!
                                                .forEach((element) {
                                              errors = errors + "\n\n$element";
                                            });
                                            DataErrorAlert.showError(
                                                title: "",
                                                data: errors,
                                                colorValue: colorsValue,
                                                context: context);
                                          }
                                        }
                                        print(CompletePaymentCubit.get(context)
                                            .currentStep);
                                        // CompletePaymentCubit.get(context).goNext(context);
                                        // CompletePaymentCubit.get(context).currentStep !=3? CompletePaymentCubit.get(context).goNext(context):null;
                                        //
                                        // if(CompletePaymentCubit.get(context).currentStep ==1){
                                        // AddToCartCubit.get(context).getCart(context: context);
                                        // }
                                        // if(CompletePaymentCubit.get(context).currentStep ==2){
                                        //
                                        // if( AddToCartCubit.get(context).cartModel.data!.errors==null||AddToCartCubit.get(context).cartModel.data!.errors!.isEmpty){
                                        // print('xxxxxxxx');
                                        // CompletePaymentCubit.get(context).goNext(context);
                                        // }else{
                                        // String errors ="";
                                        // AddToCartCubit.get(context).cartModel.data!.errors!.forEach((element) {
                                        // errors = errors +"\n\n$element";
                                        // });
                                        // DataErrorAlert.showError(title: "", data: errors, colorValue: colorsValue, context: context);
                                        // }
                                        // }
                                      },
                                      withBorder: false,
                                    ),
                                  )
                                ],
                              ),
                      ),
                    );
                  },
                  listener: (context, state) {
                    if (state is CompletePaymentStatePostNoStock) {
                      DataErrorAlert.NoStock(
                          colorValue: colorsValue,
                          desc: CompletePaymentCubit.get(context)
                              .errorModel
                              .errors!
                              .first,
                          context: context);
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        // print('InternetConnectedState');
        // AddToCartCubit.get(context).getCart(context: context);
        // AddToCartCubit.get(context).getCart(context: context);
        //
        // AddressCubit.get(context).getData();
        // AddressCubit.get(context).getAddressAndPaymentMethods(context);
      }
    });
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final ColorsInitialValue colorsValue;
  final int index;
  final int currentIndex;
  const MySeparator(
      {this.height = 1,
      required this.colorsValue,
      required this.index,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: index <= currentIndex - 1
                        ? ColorsConstant.getColorBorder2(colorsValue)
                        : ColorsConstant.getColorBorder1(colorsValue)),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

class StepperWidget extends StatelessWidget {
  StepperWidget(
      {Key? key,
      required this.colorsValue,
      this.isLast = false,
      required this.title,
      required this.index,
      required this.currentIndex,
      required this.image})
      : super(key: key);
  final ColorsInitialValue colorsValue;

  bool isLast;
  final String title;
  final String image;
  final int index;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: Responsive.isMobile(context)
                  ? SizeDataConstant.customWidth(context, 9.5)
                  : 5.h,
              width: SizeDataConstant.customWidth(context, 9),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index <= currentIndex
                      ? ColorsConstant.getColorBackground3(colorsValue)
                      : Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ImageView(
                  path: image,
                  color: index <= currentIndex
                      ? ColorsConstant.getColorBackground5(colorsValue)
                      : ColorsConstant.getColorBorder1(colorsValue),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            isLast == false
                ? SizedBox(
                    width: SizeDataConstant.customWidth(context, 5.99),
                    child: MySeparator(
                      height: 3,
                      colorsValue: colorsValue,
                      index: index,
                      currentIndex: currentIndex,
                    ))
                : SizedBox(
                    width: 0,
                  ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(
            left: 2.0,
          ),
          child: Center(
              child: CustomText(
                  text: "$title".tr().toString(),
                  style: index <= currentIndex
                      ? TextStyleConstant.stepMain(context, colorsValue)
                      : TextStyleConstant.stepGrey(context, colorsValue))),
        )
      ],
    );
  }
}
