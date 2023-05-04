import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit_state.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import 'alert.dart';

class PostOrderResult extends StatelessWidget {
  PostOrderResult(
      {Key? key,
      required this.colorsValue,
      required this.success,
      this.orderId})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final bool success;
  String? orderId;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: CustomText(
              text: "checkout".tr().toString(),
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center(child: CircleAvatar(radius: 70,backgroundColor: Color(0xff21BA45),child: ImageView(path: ImageConstants.check,color: Colors.white,fit: BoxFit.fill,),)),
                SizedBox(
                  height: 25.h,
                ),
                Center(
                    child: Container(
                  height: 13.h,
                  width: 13.h,
                  decoration: BoxDecoration(
                      color: success == true ? Color(0xff21BA45) : Colors.red,
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: success == true
                        ? ImageView(
                            path: ImageConstants.check,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 50,
                          ),
                  ),
                )),
                SizedBox(
                  height: 3.h,
                ),
                success == true
                    ? Column(
                        children: [
                          Center(
                            child: CustomText(
                              text: "orderSuccess".tr().toString(),
                              style: TextStyleConstant.headerTextLargeBlack(
                                  context, colorsValue),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Center(
                            child: CustomText(
                              textAlign: TextAlign.center,
                              text: "orderSuccessMessage".tr().toString(),
                              style: TextStyleConstant.bodyTextGrey(
                                  context, colorsValue),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Center(
                            child: CustomText(
                              text: "orderFail".tr().toString(),
                              style: TextStyleConstant.headerTextLargeError(
                                  context, colorsValue),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Center(
                            child: CustomText(
                              textAlign: TextAlign.center,
                              text: "orderFailMessage".tr().toString(),
                              style: TextStyleConstant.bodyTextGrey(
                                  context, colorsValue),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(
                      flex: success ? 2 : 1,
                    ),
                    AppButton(
                        widthRatio: success ? 1.3 : 2.5,
                        colorsInitialValue: colorsValue,
                        color: ColorsConstant.getColorBackground3(colorsValue),
                        textStyle:
                            TextStyleConstant.buttonText(context, colorsValue),
                        title: "continueShopping".tr().toString(),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Spacer(),
                    success == false
                        ? BlocConsumer<OrderCubit, OrderCubitState>(
                            listener: (contsext, state) {
                              print(state);

                              if (state is OrderCubitStateReorderSuccess) {
                                AddToCartCubit.get(context)
                                    .getCart(context: context);
                                // Navigator.pop(context);
                                DataErrorAlert.ReorderSuccess(
                                    colorValue: colorsValue, context: context);
                              }
                            },
                            builder: (context, state) {
                              return AppButton(
                                widthRatio: 2.5,
                                color: ColorsConstant.getColorBackground3(
                                    colorsValue),
                                colorsInitialValue: colorsValue,
                                onPressed: () {
                                  DataErrorAlert.cartWillBeDeleted(
                                      colorValue: colorsValue,
                                      ordersId: orderId!,
                                      context: context);
                                },
                                title: 'reOrder'.tr().toString(),
                                textStyle: TextStyleConstant.buttonText(
                                    context, colorsValue),
                              );
                            },
                          )
                        : Spacer(
                            flex: 1,
                          ),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
