import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/models/order_model/order_model_detail.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/rate_order/rate_order.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/cart_widget/cart_item.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import 'bloc_widget/order_item.dart';
import 'order_bloc/order_cubit.dart';
import 'order_bloc/order_cubit_state.dart';
import 'order_data_provider/order_methods.dart';

class OrderDetailScreenNoApi extends StatelessWidget {
  const OrderDetailScreenNoApi(
      {Key? key, required this.colorsValue, required this.orderListModel})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final Order orderListModel;

  @override
  Widget build(BuildContext context) {
    DateTime localDate =
        DateTime.parse("${orderListModel.ordersCreatedAt}").toLocal();
    localDate.difference(DateTime.now());
    print(localDate.difference(DateTime.now()).inDays);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(onPressed: () { },

          // ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: CustomText(
              text: "orderDetails".tr().toString(),
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
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 18, top: 10, right: 18, bottom: 0),
                  height: 15.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text:
                                  "${"code".tr().toString()}: ${orderListModel.ordersId}",
                              style: TextStyleConstant.headerText(
                                  context, colorsValue),
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        text:
                            "${"date".tr().toString()}: ${OrderMethods(colorsValue: colorsValue).convertDate("${orderListModel.ordersCreatedAt}")} ",
                        style: TextStyleConstant.bodyTextGrey(
                            context, colorsValue),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${"status".tr().toString()}: ',
                              style: TextStyleConstant.bodyTextGrey(
                                  context, colorsValue),
                            ),
                            TextSpan(
                              text: OrderMethods(colorsValue: colorsValue)
                                  .getStatus("${orderListModel.ordersStatus}")
                                  ?.tr()
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: OrderMethods(
                                              colorsValue: colorsValue)
                                          .getStatusColor(
                                              "${orderListModel.ordersStatus}")),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            ignoreGestures: false,
                            initialRating: orderListModel
                                        .orderDetailsRating!.ratingsValue !=
                                    null
                                ? double.parse(
                                    "${orderListModel.orderDetailsRating!.ratingsValue}")
                                : 0,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            glow: false,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              // print(rating);
                              // getRating(rating);
                            },
                          ),
                          Spacer(),
                          AppButton(
                              widthRatio: 3,
                              colorsInitialValue: colorsValue,
                              color: ColorsConstant.getColorBackground3(
                                  colorsValue),
                              textStyle: TextStyleConstant.buttonText(
                                  context, colorsValue),
                              title: "rateNow".tr().toString(),
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> RatingOrder(edit: true,colorsValue: colorsValue, orderListModel: orderListModel,)));
                              })
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 25.h,
                  padding:
                      EdgeInsets.only(left: 18, top: 10, right: 18, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: "${"address".tr().toString()}",
                              style: TextStyleConstant.headerText(
                                  context, colorsValue),
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        text:
                            "${"gov".tr().toString().replaceAll(" *", ":")}  ${orderListModel.ordersDeliveryAddress!.split(",")[0]} ",
                        style: TextStyleConstant.bodyTextGrey(
                            context, colorsValue),
                      ),
                      CustomText(
                        text:
                            "${"street".tr().toString().replaceAll(" *", ":")} ${orderListModel.ordersDeliveryAddress!.split(",")[2]},${orderListModel.ordersDeliveryAddress!.split(",")[3]} ",
                        style: TextStyleConstant.bodyTextGrey(
                            context, colorsValue),
                      ),
                      CustomText(
                        text:
                            "${"buildingNo".tr().toString().replaceAll(". *", ":")} ${orderListModel.ordersDeliveryAddress!.split(",")[4]} ",
                        style: TextStyleConstant.bodyTextGrey(
                            context, colorsValue),
                      ),
                      CustomText(
                        text:
                            "${"florNo".tr().toString().replaceAll(".", ":")} ${orderListModel.ordersDeliveryAddress!.split(",")[5]} ",
                        style: TextStyleConstant.bodyTextGrey(
                            context, colorsValue),
                      ),
                      CustomText(
                        text:
                            "${"departmentNo".tr().toString().replaceAll(".", ":")} ${orderListModel.ordersDeliveryAddress!.split(",")[6]} ",
                        style: TextStyleConstant.bodyTextGrey(
                            context, colorsValue),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 10.h,
                  padding:
                      EdgeInsets.only(left: 18, top: 10, right: 18, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: "${"paymentMethod".tr().toString()}",
                              style: TextStyleConstant.headerText(
                                  context, colorsValue),
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        text: "${orderListModel.payment!.paymentsName} ",
                        style: TextStyleConstant.bodyTextGrey(
                            context, colorsValue),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 20.h,
                  padding:
                      EdgeInsets.only(left: 18, top: 10, right: 18, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: "${"shippingMethod".tr().toString()}",
                              style: TextStyleConstant.headerText(
                                  context, colorsValue),
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        text:
                            "${orderListModel.shippingMethod!.shippingMethodsTitle} ",
                        style: TextStyleConstant.bodyTextGrey(
                            context, colorsValue),
                      ),
                      CustomText(
                        text:
                            "${orderListModel.shippingMethod!.shippingMethodsDeliveryCost} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                        style: TextStyleConstant.bodyTextGrey(
                            context, colorsValue),
                      ),
                      CustomText(
                        text:
                            "${orderListModel.shippingMethod!.shippingMethodsText}",
                        style: TextStyleConstant.bodyTextGrey(
                            context, colorsValue),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 18, top: 10, right: 18, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: "${"orderInformation".tr().toString()}",
                              style: TextStyleConstant.headerText(
                                  context, colorsValue),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ListView.builder(
                          itemCount: orderListModel.items!.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return OrderItemWidget(
                              colorsValue: colorsValue,
                              orderItem: orderListModel.items![index],
                            );
                          }),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
                orderListModel.ordersNotes != null
                    ? Container(
                        padding: EdgeInsets.only(
                            left: 18, top: 10, right: 18, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text: "${"orderNotes".tr().toString()}",
                                    style: TextStyleConstant.headerText(
                                        context, colorsValue),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              width: SizeDataConstant.fullWidth(context),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: ColorsConstant.getColorBackground5(
                                      colorsValue)),
                              child: CustomText(
                                text: "${orderListModel.ordersNotes}",
                                style: TextStyleConstant.bodyTextGrey(
                                    context, colorsValue),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  padding:
                      EdgeInsets.only(left: 18, top: 10, right: 18, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "${orderListModel.ordersPrice} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                              style: TextStyleConstant.optionalText(
                                  context, colorsValue)),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          CustomText(
                              text: "${"deliveryCost".tr().toString()} ",
                              style: TextStyleConstant.optionalText(
                                  context, colorsValue)),
                          Spacer(),
                          CustomText(
                              text:
                                  "${orderListModel.shippingMethod!.shippingMethodsDeliveryCost} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                              style: TextStyleConstant.optionalText(
                                  context, colorsValue)),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      orderListModel.couponsValue != null
                          ? Row(
                              children: [
                                CustomText(
                                    text: "${"discount".tr().toString()} ",
                                    style: TextStyleConstant.optionalText(
                                        context, colorsValue)),
                                Spacer(),
                                CustomText(
                                    text:
                                        "${orderListModel.couponsValue} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                                    style: TextStyleConstant.optionalText(
                                        context, colorsValue)),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 2.h,
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
                                  "${orderListModel.ordersFinalCost} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                              style: TextStyleConstant.bodyTextMainColor(
                                  context, colorsValue)),
                        ],
                      ),
                    ],
                  ),
                ),
                orderListModel.orderReturnModel == null
                    ? Container(
                        padding: EdgeInsets.only(
                            left: 18, top: 10, right: 18, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OrderMethods(colorsValue: colorsValue)
                                .getOrderDetailWidget(
                                    status: DateTime.now()
                                                .difference(localDate)
                                                .inDays >=
                                            30
                                        ? "-10"
                                        : "${orderListModel.ordersStatus}",
                                    context: context,
                                    items: orderListModel.items!,
                                    orderId: "${orderListModel.ordersId}"),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(
                            left: 18, top: 10, right: 18, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Divider(),
                            CustomText(
                                text: "${"refund".tr().toString()} ",
                                style: TextStyleConstant.headerTextMainColor(
                                    context, colorsValue)),
                            SizedBox(
                              height: 2.h,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${"returnStatus".tr().toString()}: ',
                                    style: TextStyleConstant.bodyTextGrey(
                                        context, colorsValue),
                                  ),
                                  TextSpan(
                                    text: OrderMethods(colorsValue: colorsValue)
                                        .getReturnStatus(
                                            "${orderListModel.orderReturnModel!.orderReturnRequestsStatus}")
                                        ?.tr()
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                            color: OrderMethods(
                                                    colorsValue: colorsValue)
                                                .getReturnStatusColor(
                                                    "${orderListModel.orderReturnModel!.orderReturnRequestsStatus}")),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            CustomText(
                              text:
                                  "${"refundReason".tr().toString()}: ${orderListModel.orderReturnModel!.orderReturnRequestsReason} ",
                              style: TextStyleConstant.bodyTextGrey(
                                  context, colorsValue),
                            ),
                            SizedBox(
                              height: orderListModel.orderReturnModel!
                                          .orderReturnRequestsResponseNotes !=
                                      null
                                  ? 2.h
                                  : 0,
                            ),
                            orderListModel.orderReturnModel!
                                        .orderReturnRequestsResponseNotes !=
                                    null
                                ? CustomText(
                                    text:
                                        "${"refundResponse".tr().toString()}: ${orderListModel.orderReturnModel!.orderReturnRequestsResponseNotes} ",
                                    style: TextStyleConstant.bodyTextGrey(
                                        context, colorsValue),
                                  )
                                : Container(),
                            SizedBox(
                              height: 2.h,
                            ),
                            Center(
                              child: BlocConsumer<OrderCubit, OrderCubitState>(
                                listener: (contextx, state) {
                                  print(state);

                                  if (state is OrderCubitStateReorderSuccess) {
                                    AddToCartCubit.get(context)
                                        .getCart(context: context);
                                    // Navigator.pop(context);
                                    DataErrorAlert.ReorderSuccess(
                                        colorValue: colorsValue,
                                        context: context);
                                  }
                                },
                                builder: (context, state) {
                                  return AppButton(
                                    color: ColorsConstant.getColorBackground3(
                                        colorsValue),
                                    colorsInitialValue: colorsValue,
                                    onPressed: () {
                                      DataErrorAlert.cartWillBeDeleted(
                                          colorValue: colorsValue,
                                          ordersId:
                                              "${orderListModel.ordersId}",
                                          context: context);
                                    },
                                    title: 'reOrder'.tr().toString(),
                                    textStyle: TextStyleConstant.buttonText(
                                        context, colorsValue),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
