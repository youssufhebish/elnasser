import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/models/cart_model/cart_model.dart';

import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:elnasser/screens/complete_payment/complete_payment.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/edit_user/edit_user_bloc/edit_user_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobile_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_cubit.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/no_data_widget.dart';
import 'package:elnasser/widget/cart_widget/cart_item.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/no_internet_widget.dart';

import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  CartScreen({
    Key? key,
    required this.colorsValue,
  }) : super(key: key);
  ColorsInitialValue colorsValue;

  bool _keyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
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
              resizeToAvoidBottomInset: false,
              backgroundColor:
                  (AddToCartCubit.get(context).cartModel.data != null &&
                          AddToCartCubit.get(context).cartModel.data != null)
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Colors.white,
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shadowColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: CustomText(
                  text: "cart".tr().toString(),
                  style: TextStyleConstant.headerText(context, colorsValue),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: ColorsConstant.getColorText1(colorsValue),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: BlocConsumer<AddToCartCubit, AddToCartState>(
                  buildWhen: (prev, current) =>
                      (current is AddToCartStateSuccess ||
                              current is CartStateSuccess ||
                              current is CartStateDeleteSuccess ||
                              state is AddToCartStateResetData ||
                              current is CartStateCouponSuccess ||
                              current is CartStateRemoveCouponSuccess)
                          ? true
                          : false,
                  builder: (context, state) {
                    print("Currrent State$state");

                    if ((state is CartStateSuccess ||
                            state is AddToCartStateSuccess ||
                            state is AddToCartStateResetData ||
                            state is CartStateCouponSuccess ||
                            state is CartStateDeleteSuccess ||
                            state is CartStateRemoveCouponSuccess ||
                            state is AddToCartStateGetAmountMinus ||
                            state is AddToCartStateGetAmountAdd) &&
                        AddToCartCubit.get(context).cartModel.data!.cart !=
                            null) {
                      return Column(
                        children: [
                          SizedBox(
                            height: _keyboardVisible == true ? 38.h : 52.h,
                            child: (AddToCartCubit.get(context)
                                            .cartModel
                                            .data!
                                            .cart !=
                                        null &&
                                    AddToCartCubit.get(context)
                                        .cartModel
                                        .data!
                                        .cart!
                                        .items!
                                        .isNotEmpty)
                                ? ListView.builder(
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
                                        isReview: false,
                                        colorsValue: colorsValue,
                                        cartItem: AddToCartCubit.get(context)
                                            .cartModel
                                            .data!
                                            .cart!
                                            .items![index],
                                      );
                                    })
                                : NoDataWidget(
                                    colorsValue: colorsValue,
                                    title: "cartEmpty",
                                    image: ImageConstants.emptyCart,
                                    description: 'cartEmptyDesc',
                                  ),
                          ),
                          (AddToCartCubit.get(context).cartModel.data!.cart !=
                                      null &&
                                  AddToCartCubit.get(context)
                                      .cartModel
                                      .data!
                                      .cart!
                                      .items!
                                      .isNotEmpty)
                              ? CardBottomWidget(
                                  isOpen: _keyboardVisible,
                                  colorsValue: colorsValue,
                                  cartModel:
                                      AddToCartCubit.get(context).cartModel,
                                )
                              : Container(),
                        ],
                      );
                    } else if (AddToCartCubit.get(context).cartModel.data ==
                            null ||
                        AddToCartCubit.get(context).cartModel.data!.cart ==
                            null ||
                        AddToCartCubit.get(context)
                            .cartModel
                            .data!
                            .cart!
                            .items!
                            .isEmpty) {
                      return Center(
                        child: NoDataWidget(
                          colorsValue: colorsValue,
                          title: "cartEmpty",
                          image: ImageConstants.emptyCart,
                          description: 'cartEmptyDesc',
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 60.h,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                  listener: (context, state) {
                    if (state is CartStateSuccess) {
                      AddToCartCubit.get(context).resetData();

                      // AddToCartCubit.get(context).getCart(context: context);

                    }
                    if (state is AddToCartStateNoStock) {
                      DataErrorAlert.NoStock(
                          colorValue: colorsValue,
                          desc: AddToCartCubit.get(context)
                              .errorModel
                              .errors!
                              .first,
                          context: context);
                    }
                  },
                ),
              ),
            ),
          ),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        // AddToCartCubit.get(context).getCart(context: context);
      }
    });
  }
}

class CardBottomWidget extends StatefulWidget {
  CardBottomWidget(
      {Key? key,
      required this.colorsValue,
      required this.isOpen,
      required this.cartModel})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  bool isOpen;
  final CartModel cartModel;

  @override
  State<CardBottomWidget> createState() => _CardBottomWidgetState();
}

class _CardBottomWidgetState extends State<CardBottomWidget> {
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isOpen == true ? 45.h : 40.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,

        //   border: Border(
        //   top: BorderSide(
        //     color: ColorsConstant.getColorBorder1(colorsValue)
        //   )
        // )
      ),
      child: BlocConsumer<AddToCartCubit, AddToCartState>(
        buildWhen: (prev, current) => (current is CartStateCouponFailDialog ||
                current is CartStateCouponFail ||
                current is CartStateCouponSuccess ||
                current is CartStateRemoveCouponSuccess ||
                current is CartStateCouponLoading)
            ? true
            : false,
        builder: (context, state) {
          // if (state is CartStateSuccess || state is AddToCartStateSuccess) {
          return Column(
            children: [
              Expanded(
                flex: widget.cartModel.data!.cart!.couponsValue != null &&
                        widget.cartModel.data!.cart!.couponsValue != "0.000"
                    ? 5
                    : 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorsConstant.getColorBorder1(
                                widget.colorsValue)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocConsumer<AddToCartCubit, AddToCartState>(
                              buildWhen: (prev, current) => (current
                                          is CartStateCouponFailDialog ||
                                      current is CartStateCouponFail ||
                                      current is CartStateCouponSuccess ||
                                      current is CartStateRemoveCouponSuccess ||
                                      current is CartStateCouponLoading)
                                  ? true
                                  : false,
                              builder: (context, state) {
                                return AppTextFiled(
                                  password: false,
                                  labelText: 'couponCode'.tr().toString(),
                                  hintText: 'couponCode'.tr().toString(),
                                  node: _focusNode,
                                  nextNode: null,
                                  inputType: TextInputType.text,
                                  validation: true,
                                  colorsInitialValue: widget.colorsValue,
                                  validationWidget: TextButton(
                                    child: CustomText(
                                        text: "apply".tr().toString(),
                                        style:
                                            TextStyleConstant.bodyTextMainColor(
                                                context, widget.colorsValue)),
                                    onPressed: () {
                                      if (HomeMobileCubit.get(context)
                                              .isUserLogin ==
                                          true) {
                                        AddToCartCubit.get(context)
                                            .AddCouponApi(
                                                context: context,
                                                couponValue:
                                                    AddToCartCubit.get(context)
                                                        .couponController
                                                        .value
                                                        .text);
                                      } else {
                                        DataErrorAlert.showLogin(
                                          colorValue: widget.colorsValue,
                                          context: context,
                                          title:
                                              'YouNeedToLogin'.tr().toString(),
                                          data: 'pleaseLoginFirst'
                                              .tr()
                                              .toString(),
                                        );
                                      }
                                    },
                                  ),
                                  scrollPadding: 0,
                                  controller: AddToCartCubit.get(context)
                                      .couponController,
                                  prefixIcon: ImageView(
                                    path: ImageConstants.coupon,
                                    color: ColorsConstant.getColorText1(
                                        widget.colorsValue),
                                  ),
                                );
                              },
                              listener: (context, state) {
                                if (state is CartStateCouponFailDialog) {
                                  DataErrorAlert.showError(
                                      title: AddToCartCubit.get(context)
                                          .errorModel
                                          .message!,
                                      data: AddToCartCubit.get(context)
                                          .errorModel
                                          .errors![0],
                                      colorValue: widget.colorsValue,
                                      context: context);
                                }
                              },
                            ),
                          ),
                          Spacer(),
                          widget.cartModel.data!.cart!.couponsValue != null &&
                                  widget.cartModel.data!.cart!.couponsValue !=
                                      "0.000"
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: ImageView(
                                          path: ImageConstants.couponDiscount,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomText(
                                          text:
                                              "  ${widget.cartModel.data!.cart!.couponsValue.toString().replaceAll(".000", ".00")}  ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                          style: TextStyleConstant.bodyText(
                                              context, widget.colorsValue)),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            AddToCartCubit.get(context)
                                                .removeCoupon(context: context);
                                          },
                                          icon: Icon(Icons.close))
                                    ],
                                  ),
                                )
                              : Container(),
                          Spacer(),
                        ],
                      )),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12, top: 5, bottom: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text:
                                      "${"supTotal".tr().toString()} ${widget.cartModel.data!.cart!.cartsPrice} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                                  style: TextStyleConstant.lightText(
                                      context, widget.colorsValue)),
                              Spacer(),
                              widget.cartModel.data!.cart!.couponsValue != null
                                  ? CustomText(
                                      text:
                                          "${"coupon".tr().toString()} ${widget.cartModel.data!.cart!.couponsValue.toString().replaceAll(".000", ".00")} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                      style: TextStyleConstant.lightText(
                                          context, widget.colorsValue))
                                  : Container(),
                            ],
                          )),
                      Column(
                        children: [
                          widget.cartModel.data!.cart!.couponsValue != null
                              ? Spacer()
                              : Container(),
                          CustomText(
                              text:
                                  "${"total".tr().toString()} ${widget.cartModel.data!.cart!.cartsFinalCost} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                              style: TextStyleConstant.bodyTextMainColor(
                                  context, widget.colorsValue)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 50,
                            child:
                                BlocBuilder<HomeMobileCubit, HomeMobileState>(
                              builder: (context, state) {
                                return AppButton(
                                    colorsInitialValue: widget.colorsValue,
                                    color: ColorsConstant.getColorBackground3(
                                        widget.colorsValue),
                                    textStyle: TextStyleConstant.whiteText(
                                        context, widget.colorsValue),
                                    title: "proceedToCheckout".tr().toString(),
                                    onPressed: () async {
                                      AddToCartCubit.get(context)
                                          .couponController
                                          .clear();
                                      Loader.showLoader(context);
                                      AddToCartCubit.get(context)
                                          .getCart(context: context)
                                          .whenComplete(() {
                                        Loader.hideLoader(context);

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
                                          if (HomeMobileCubit.get(context)
                                                  .isUserLogin ==
                                              true) {
                                            EditUserCubit.get(context)
                                                .getData(context);
                                            CompletePaymentCubit.get(context)
                                                .getAddressAndPaymentMethods(
                                                    context);
                                            AddressCubit.get(context)
                                                .getAddressAndPaymentMethods(
                                                    context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CompletePayment(
                                                            colorsValue: widget
                                                                .colorsValue)));
                                          } else {
                                            DataErrorAlert.showLogin(
                                                colorValue: widget.colorsValue,
                                                title: 'YouNeedToLogin'
                                                    .tr()
                                                    .toString(),
                                                data: 'pleaseLoginFirst'
                                                    .tr()
                                                    .toString(),
                                                context: context);
                                          }
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
                                              colorValue: widget.colorsValue,
                                              context: context);
                                        }
                                      });
                                      // await Future.delayed(Duration(seconds: 2));
                                    });
                              },
                            )),
                      ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  )),
            ],
          );
          // } else {
          //   return Column(
          //     children: [
          //       Expanded(
          //         flex: cartModel.data!.cart!.couponsValue != null ? 5 : 2,
          //         child: Padding(
          //           padding: const EdgeInsets.all(10.0),
          //           child: Container(
          //               decoration: BoxDecoration(
          //                 border: Border.all(
          //                     color:
          //                         ColorsConstant.getColorBorder1(colorsValue)),
          //                 borderRadius: BorderRadius.circular(6),
          //               ),
          //               child: Column(
          //                 children: [
          //                   Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: AppTextFiled(
          //                       password: false,
          //                       labelText: 'couponCode'.tr().toString(),
          //                       hintText: 'couponCode'.tr().toString(),
          //                       node: _focusNode,
          //                       nextNode: null,
          //                       inputType: TextInputType.text,
          //                       validation: true,
          //                       colorsInitialValue: colorsValue,
          //                       validationWidget: TextButton(
          //                         child: CustomText(
          //                             text: "apply".tr().toString(),
          //                             style:
          //                                 TextStyleConstant.bodyTextMainColor(
          //                                     context, colorsValue)),
          //                         onPressed: () {},
          //                       ),
          //                       scrollPadding: 0,
          //                       controller: couponController,
          //                       prefixIcon: ImageView(
          //                         path: ImageConstants.coupon,
          //                         color:
          //                             ColorsConstant.getColorText1(colorsValue),
          //                       ),
          //                     ),
          //                   ),
          //                   Spacer(),
          //                   cartModel.data!.cart!.couponsValue != null
          //                       ? Padding(
          //                           padding: const EdgeInsets.only(
          //                             left: 8,
          //                             right: 8,
          //                           ),
          //                           child: Row(
          //                             children: [
          //                               Container(
          //                                 height: 30,
          //                                 width: 30,
          //                                 child: ImageView(
          //                                   path: ImageConstants.couponDiscount,
          //                                   fit: BoxFit.cover,
          //                                 ),
          //                               ),
          //                               SizedBox(
          //                                 width: 10,
          //                               ),
          //                               CustomText(
          //                                   text:
          //                                       "${cartModel.data!.cart!.couponsValue}",
          //                                   style: TextStyleConstant.bodyText(
          //                                       context, colorsValue)),
          //                               Spacer(),
          //                               IconButton(
          //                                   onPressed: () {},
          //                                   icon: Icon(Icons.close))
          //                             ],
          //                           ),
          //                         )
          //                       : Container(),
          //                   Spacer(),
          //                 ],
          //               )),
          //         ),
          //       ),
          //       Expanded(
          //         flex: 2,
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //               left: 12.0, right: 12, top: 5, bottom: 5),
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Expanded(
          //                   flex: 1,
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       CustomText(
          //                           text:
          //                               "${"supTotal".tr().toString()} ${cartModel.data!.cart!.cartsPrice} ${HomeCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
          //                           style: TextStyleConstant.lightText(
          //                               context, colorsValue)),
          //                       Spacer(),
          //                       cartModel.data!.cart!.couponsValue != null
          //                           ? CustomText(
          //                               text:
          //                                   "${"coupon".tr().toString()} 10 ${HomeCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
          //                               style: TextStyleConstant.lightText(
          //                                   context, colorsValue))
          //                           : Container(),
          //                     ],
          //                   )),
          //               Expanded(
          //                   flex: 1,
          //                   child: Column(
          //                     children: [
          //                       cartModel.data!.cart!.couponsValue != null
          //                           ? Spacer()
          //                           : Container(),
          //                       CustomText(
          //                           text:
          //                               "${"total".tr().toString()} ${cartModel.data!.cart!.cartsFinalCost} ${HomeCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
          //                           style: TextStyleConstant.bodyTextMainColor(
          //                               context, colorsValue)),
          //                     ],
          //                   )),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //           flex: 3,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: SizedBox(
          //                   height: 50,
          //                   child: AppButton(
          //                       colorsInitialValue: colorsValue,
          //                       color: ColorsConstant.getColorBackground3(
          //                           colorsValue),
          //                       textStyle: TextStyleConstant.whiteText(
          //                           context, colorsValue),
          //                       title: "proceedToCheckout".tr().toString(),
          //                       onPressed: () {
          //                         AddressCubit.get(context)
          //                             .getAddressAndPaymentMethods(context);
          //                         Navigator.push(
          //                             context,
          //                             MaterialPageRoute(
          //                                 builder: (context) => CompletePayment(
          //                                     colorsValue: colorsValue)));
          //                       }),
          //                 ),
          //               ),
          //             ],
          //           )),
          //     ],
          //   );
          // }
        },
        listener: (context, state) {},
      ),
    );
  }
}
