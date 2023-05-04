import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/rate_order/rate_order.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
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

class OrderDetailScreenWithApi extends StatelessWidget {
  const OrderDetailScreenWithApi({Key? key, required this.colorsValue})
      : super(key: key);
  final ColorsInitialValue colorsValue;

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
          body: BlocConsumer<OrderCubit, OrderCubitState>(
            builder: (context, state) {
              if (state is OrderCubitStateSuccess ||
                  state is OrderCubitStateRefundOrderGetIds ||
                  state is OrderCubitStateRefundOrderSuccess ||
                  state is OrderCubitStateRefundOrderFailed) {
                List<OrderItemModel> RequestedRefundedItems = [];
                List<int> RequestedRefundedItemsId = [];

                (OrderCubit.get(context)
                                .orderModelDetail
                                .data!
                                .order!
                                .orderReturnModel !=
                            null &&
                        OrderCubit.get(context)
                                .orderModelDetail
                                .data!
                                .order!
                                .orderReturnModel!
                                .fkItemsIds !=
                            null)
                    ? (OrderCubit.get(context)
                        .orderModelDetail
                        .data!
                        .order!
                        .items!
                        .forEach((element) {
                        if (!OrderCubit.get(context)
                            .orderModelDetail
                            .data!
                            .order!
                            .orderReturnModel!
                            .fkItemsIds!
                            .contains(",")) {
                          if (element.ordersItemsId ==
                              int.parse(OrderCubit.get(context)
                                  .orderModelDetail
                                  .data!
                                  .order!
                                  .orderReturnModel!
                                  .fkItemsIds!)) {
                            RequestedRefundedItems.add(element);
                          }
                        } else if (OrderCubit.get(context)
                            .orderModelDetail
                            .data!
                            .order!
                            .orderReturnModel!
                            .fkItemsIds!
                            .split(",")
                            .contains("${element.ordersItemsId}")) {
                          RequestedRefundedItems.add(element);
                        }
                      }))
                    : null;
                OrderCubit.get(context)
                            .orderModelDetail
                            .data!
                            .order!
                            .orderReturnModel !=
                        null
                    ? (OrderCubit.get(context)
                        .orderModelDetail
                        .data!
                        .order!
                        .refundedItems!
                        .forEach((element) {
                        if (OrderCubit.get(context)
                                .orderModelDetail
                                .data!
                                .order!
                                .orderReturnModel!
                                .fkItemsIds!
                                .split(",")
                                .contains(element.ordersItemsId) &&
                            !RequestedRefundedItems.contains(element)) {
                          RequestedRefundedItems.add(element);
                        }
                      }))
                    : null;

                DateTime localDate = DateTime.parse(
                        "${OrderCubit.get(context).orderModelDetail.data!.order!.ordersCreatedAt}")
                    .toLocal();
                localDate.difference(DateTime.now());
                print(localDate.difference(DateTime.now()).inDays);
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 18, top: 0, right: 18, bottom: 0),
                        height: 18.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text:
                                        "${"code".tr().toString()}: ${OrderCubit.get(context).orderModelDetail.data!.order!.ordersNo}",
                                    style: TextStyleConstant.headerText(
                                        context, colorsValue),
                                  ),
                                ),
                              ],
                            ),
                            CustomText(
                              text:
                                  "${"date".tr().toString()}: ${OrderMethods(colorsValue: colorsValue).convertDate("${OrderCubit.get(context).orderModelDetail.data!.order!.ordersCreatedAt}")} ",
                              style: TextStyleConstant.bodyTextGrey(
                                  context, colorsValue),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${"status".tr().toString()}: ',
                                    style: TextStyleConstant.bodyText(
                                        context, colorsValue),
                                  ),
                                  TextSpan(
                                    text: OrderMethods(colorsValue: colorsValue)
                                        .getStatus(
                                            "${OrderCubit.get(context).orderModelDetail.data!.order!.ordersStatus}")
                                        ?.tr()
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                            color: OrderMethods(
                                                    colorsValue: colorsValue)
                                                .getStatusColor(
                                                    "${OrderCubit.get(context).orderModelDetail.data!.order!.ordersStatus}")),
                                  ),
                                ],
                              ),
                            ),
                            (OrderCubit.get(context)
                                            .orderModelDetail
                                            .data!
                                            .shippingStatus !=
                                        null &&
                                    OrderCubit.get(context)
                                        .orderModelDetail
                                        .data!
                                        .shippingStatus!
                                        .isNotEmpty)
                                ? Container(
                                    child: Row(
                                      children: [
                                        CustomText(
                                          text:
                                              "${"shippingStatus".tr().toString()}: ",
                                          style: TextStyleConstant.bodyText(
                                              context, colorsValue),
                                        ),
                                        CustomText(
                                          text:
                                              "${OrderCubit.get(context).orderModelDetail.data!.shippingStatus}",
                                          style: TextStyleConstant
                                              .bodyTextMainColor(
                                                  context, colorsValue),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            OrderCubit.get(context)
                                        .orderModelDetail
                                        .data!
                                        .order!
                                        .ordersStatus ==
                                    "4"
                                ? Row(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: OrderCubit.get(context)
                                                      .orderModelDetail
                                                      .data!
                                                      .order!
                                                      .orderDetailsRating !=
                                                  null
                                              ? double.parse(
                                                  "${OrderCubit.get(context).orderModelDetail.data!.order!.orderDetailsRating!.ratingsValue}")
                                              : 0,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 30,
                                          glow: false,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            // print(rating);
                                            // getRating(rating);
                                          },
                                        ),
                                      ),
                                      Spacer(),
                                      AppButton(
                                          widthRatio: 3,
                                          colorsInitialValue: colorsValue,
                                          color: ColorsConstant
                                              .getColorBackground3(colorsValue),
                                          textStyle:
                                              TextStyleConstant.buttonText(
                                                  context, colorsValue),
                                          title: "rateNow".tr().toString(),
                                          onPressed: () {
                                            // print(OrderCubit.get(context).orderModelDetail.data!.order!.orderDetailsRating!.ratingsText);
                                            // print(OrderCubit.get(context).orderModelDetail.data!.order!.orderDetailsRating!.ratingsText);
                                            // print(OrderCubit.get(context).orderModelDetail.data!.order!.orderDetailsRating!.ratingsService);
                                            // print(OrderCubit.get(context).orderModelDetail.data!.order!.orderDetailsRating!.clientsId);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RatingOrder(
                                                          edit: OrderCubit.get(
                                                                          context)
                                                                      .orderModelDetail
                                                                      .data!
                                                                      .order!
                                                                      .orderDetailsRating ==
                                                                  null
                                                              ? false
                                                              : true,
                                                          colorsValue:
                                                              colorsValue,
                                                          orderModelDetail:
                                                              OrderCubit.get(
                                                                      context)
                                                                  .orderModelDetail
                                                                  .data!
                                                                  .order!,
                                                          productRating: OrderCubit
                                                                  .get(context)
                                                              .orderModelDetail
                                                              .data!
                                                              .productRating,
                                                        )));
                                          })
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 0.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 18, top: 0, right: 18, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text: "${"orderItems".tr().toString()}",
                                    style: TextStyleConstant.headerText(
                                        context, colorsValue),
                                  ),
                                ),
                              ],
                            ),
                            ListView.builder(
                                itemCount: OrderCubit.get(context)
                                    .orderModelDetail
                                    .data!
                                    .order!
                                    .items!
                                    .length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return OrderItemWidget(
                                    colorsValue: colorsValue,
                                    orderItem: OrderCubit.get(context)
                                        .orderModelDetail
                                        .data!
                                        .order!
                                        .items![index],
                                  );
                                }),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        ),
                      ),

                      /// delted

                      OrderCubit.get(context)
                                  .orderModelDetail
                                  .data!
                                  .order!
                                  .ordersNotes !=
                              null
                          ? Container(
                              padding: EdgeInsets.only(
                                  left: 18, top: 10, right: 18, bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          text:
                                              "${"orderNotes".tr().toString()}",
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
                                        color:
                                            ColorsConstant.getColorBackground5(
                                                colorsValue)),
                                    child: CustomText(
                                      text:
                                          "${OrderCubit.get(context).orderModelDetail.data!.order!.ordersNotes}",
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
                        padding: EdgeInsets.only(
                            left: 18, top: 10, right: 18, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                    text:
                                        "${"reviewSupTotal".tr().toString()} ",
                                    style: TextStyleConstant.optionalText(
                                        context, colorsValue)),
                                Spacer(),
                                CustomText(
                                    text:
                                        "${OrderCubit.get(context).orderModelDetail.data!.order!.ordersPrice} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
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
                                        "${OrderCubit.get(context).orderModelDetail.data!.order!.shippingMethod!.shippingMethodsDeliveryCost} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                                    style: TextStyleConstant.optionalText(
                                        context, colorsValue)),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            OrderCubit.get(context)
                                        .orderModelDetail
                                        .data!
                                        .order!
                                        .couponsValue !=
                                    null
                                ? Row(
                                    children: [
                                      CustomText(
                                          text:
                                              "${"discount".tr().toString()} ",
                                          style: TextStyleConstant.optionalText(
                                              context, colorsValue)),
                                      Spacer(),
                                      CustomText(
                                          text:
                                              "${OrderCubit.get(context).orderModelDetail.data!.order!.couponsValue} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                                          style: TextStyleConstant.optionalText(
                                              context, colorsValue)),
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: 0.h,
                            ),
                            Row(
                              children: [
                                CustomText(
                                    text: "${"paymentMethod".tr().toString()} ",
                                    style: TextStyleConstant.optionalText(
                                        context, colorsValue)),
                                Spacer(),
                                CustomText(
                                    text:
                                        "${OrderCubit.get(context).orderModelDetail.data!.order!.payment!.paymentsName} ",
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
                                    text: "${"reviewTotal".tr().toString()} ",
                                    style: TextStyleConstant.headerText(
                                        context, colorsValue)),
                                Spacer(),
                                CustomText(
                                    text:
                                        "${OrderCubit.get(context).orderModelDetail.data!.order!.ordersFinalCost} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency} ",
                                    style: TextStyleConstant.bodyTextMainColor(
                                        context, colorsValue)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      OrderCubit.get(context)
                                  .orderModelDetail
                                  .data!
                                  .order!
                                  .orderReturnModel !=
                              null
                          ? Center(
                              child: BlocConsumer<OrderCubit, OrderCubitState>(
                                listener: (contesxt, state) {
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
                                              "${OrderCubit.get(context).orderModelDetail.data!.order!.ordersId}",
                                          context: context);
                                    },
                                    title: 'reOrder'.tr().toString(),
                                    textStyle: TextStyleConstant.buttonText(
                                        context, colorsValue),
                                  );
                                },
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: OrderCubit.get(context)
                                .orderModelDetail
                                .data!
                                .order!
                                .deletedItems!
                                .isNotEmpty
                            ? 2.h
                            : 0,
                      ),

                      SizedBox(
                        height: 2.h,
                      ),
                      ExpansionTile(
                        title: CustomText(
                          text: "${"shippingData".tr().toString()}",
                          style: TextStyleConstant.headerTextMainColor(
                              context, colorsValue),
                        ),
                        children: [
                          Container(
                            height: 25.h,
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
                                        text: "${"address".tr().toString()}",
                                        style: TextStyleConstant.headerText(
                                            context, colorsValue),
                                      ),
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text:
                                      "${"gov".tr().toString().replaceAll(" *", ":")}  ${OrderCubit.get(context).orderModelDetail.data!.order!.ordersDeliveryAddress!.split(",")[0]} ",
                                  style: TextStyleConstant.bodyTextGrey(
                                      context, colorsValue),
                                ),
                                CustomText(
                                  text:
                                      "${"street".tr().toString().replaceAll(" *", ":")} ${OrderCubit.get(context).orderModelDetail.data!.order!.ordersDeliveryAddress!.split(",")[2]},${OrderCubit.get(context).orderModelDetail.data!.order!.ordersDeliveryAddress!.split(",")[3]} ",
                                  style: TextStyleConstant.bodyTextGrey(
                                      context, colorsValue),
                                ),
                                CustomText(
                                  text:
                                      "${"buildingNo".tr().toString().replaceAll(". *", ":")} ${OrderCubit.get(context).orderModelDetail.data!.order!.ordersDeliveryAddress!.split(",")[4]} ",
                                  style: TextStyleConstant.bodyTextGrey(
                                      context, colorsValue),
                                ),
                                CustomText(
                                  text:
                                      "${"florNo".tr().toString().replaceAll(".", ":")} ${OrderCubit.get(context).orderModelDetail.data!.order!.ordersDeliveryAddress!.split(",")[5]} ",
                                  style: TextStyleConstant.bodyTextGrey(
                                      context, colorsValue),
                                ),
                                CustomText(
                                  text:
                                      "${"departmentNo".tr().toString().replaceAll(".", ":")} ${OrderCubit.get(context).orderModelDetail.data!.order!.ordersDeliveryAddress!.split(",")[6]} ",
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
                                        text:
                                            "${"shippingMethod".tr().toString()}",
                                        style: TextStyleConstant.headerText(
                                            context, colorsValue),
                                      ),
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text:
                                      "${OrderCubit.get(context).orderModelDetail.data!.order!.shippingMethod!.shippingMethodsTitle} ",
                                  style: TextStyleConstant.bodyTextGrey(
                                      context, colorsValue),
                                ),
                                CustomText(
                                  text:
                                      "${OrderCubit.get(context).orderModelDetail.data!.order!.shippingMethod!.shippingMethodsDeliveryCost} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                  style: TextStyleConstant.bodyTextGrey(
                                      context, colorsValue),
                                ),
                                CustomText(
                                  text:
                                      "${OrderCubit.get(context).orderModelDetail.data!.order!.shippingMethod!.shippingMethodsText}",
                                  style: TextStyleConstant.bodyTextGrey(
                                      context, colorsValue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      OrderCubit.get(context)
                              .orderModelDetail
                              .data!
                              .order!
                              .deletedItems!
                              .isNotEmpty
                          ? ExpansionTile(
                              title: CustomText(
                                text: "${"deletedItems".tr().toString()}",
                                style: TextStyleConstant.headerTextMainColor(
                                    context, colorsValue),
                              ),
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 0, right: 10, bottom: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ListView.builder(
                                          itemCount: OrderCubit.get(context)
                                              .orderModelDetail
                                              .data!
                                              .order!
                                              .deletedItems!
                                              .length,
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return OrderItemWidget(
                                              colorsValue: colorsValue,
                                              orderItem: OrderCubit.get(context)
                                                  .orderModelDetail
                                                  .data!
                                                  .order!
                                                  .deletedItems![index],
                                            );
                                          }),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Container(),
                      OrderCubit.get(context)
                                  .orderModelDetail
                                  .data!
                                  .order!
                                  .orderReturnModel ==
                              null
                          ? Container(
                              padding: EdgeInsets.only(
                                  left: 18, top: 10, right: 18, bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  OrderMethods(colorsValue: colorsValue)
                                      .getOrderDetailWidget(
                                          items: OrderCubit.get(context)
                                              .orderModelDetail
                                              .data!
                                              .order!
                                              .items!,
                                          status: DateTime.now()
                                                      .difference(localDate)
                                                      .inDays >=
                                                  30
                                              ? "-10"
                                              : "${OrderCubit.get(context).orderModelDetail.data!.order!.ordersStatus}",
                                          context: context,
                                          orderId:
                                              "${OrderCubit.get(context).orderModelDetail.data!.order!.ordersId}"),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              ),
                            )
                          : ExpansionTile(
                              title: CustomText(
                                  text: "${"refund".tr().toString()} ",
                                  style: TextStyleConstant.headerTextMainColor(
                                      context, colorsValue)),
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 18, top: 10, right: 18, bottom: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${"returnStatus".tr().toString()}: ',
                                              style: TextStyleConstant
                                                  .bodyTextGrey(
                                                      context, colorsValue),
                                            ),
                                            TextSpan(
                                              text: OrderMethods(
                                                      colorsValue: colorsValue)
                                                  .getReturnStatus(
                                                      "${OrderCubit.get(context).orderModelDetail.data!.order!.orderReturnModel!.orderReturnRequestsStatus}")
                                                  ?.tr()
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.copyWith(
                                                      color: OrderMethods(
                                                              colorsValue:
                                                                  colorsValue)
                                                          .getReturnStatusColor(
                                                              "${OrderCubit.get(context).orderModelDetail.data!.order!.orderReturnModel!.orderReturnRequestsStatus}")),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      CustomText(
                                        text:
                                            "${"refundReason".tr().toString()}: ${OrderCubit.get(context).orderModelDetail.data!.order!.orderReturnModel!.orderReturnRequestsReason} ",
                                        style: TextStyleConstant.bodyTextGrey(
                                            context, colorsValue),
                                      ),
                                      SizedBox(
                                        height: OrderCubit.get(context)
                                                    .orderModelDetail
                                                    .data!
                                                    .order!
                                                    .orderReturnModel!
                                                    .orderReturnRequestsResponseNotes !=
                                                null
                                            ? 2.h
                                            : 0,
                                      ),

                                      OrderCubit.get(context)
                                                  .orderModelDetail
                                                  .data!
                                                  .order!
                                                  .orderReturnModel!
                                                  .orderReturnRequestsStatus ==
                                              "0"
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  top: 0,
                                                  right: 10,
                                                  bottom: 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: CustomText(
                                                          text:
                                                              "${"items".tr().toString()}",
                                                          style: TextStyleConstant
                                                              .headerText(
                                                                  context,
                                                                  colorsValue),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  ListView.builder(
                                                      itemCount:
                                                          RequestedRefundedItems
                                                                  .toSet()
                                                              .toList()
                                                              .length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return OrderItemWidget(
                                                          colorsValue:
                                                              colorsValue,
                                                          orderItem:
                                                              RequestedRefundedItems[
                                                                  index],
                                                        );
                                                      }),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),

                                      OrderCubit.get(context)
                                                  .orderModelDetail
                                                  .data!
                                                  .order!
                                                  .orderReturnModel!
                                                  .orderReturnRequestsResponseNotes !=
                                              null
                                          ? CustomText(
                                              text:
                                                  "${"refundResponse".tr().toString()}: ${OrderCubit.get(context).orderModelDetail.data!.order!.orderReturnModel!.orderReturnRequestsResponseNotes} ",
                                              style: TextStyleConstant
                                                  .bodyTextGrey(
                                                      context, colorsValue),
                                            )
                                          : Container(),

                                      /// refunded
                                      OrderCubit.get(context)
                                              .orderModelDetail
                                              .data!
                                              .order!
                                              .refundedItems!
                                              .isNotEmpty
                                          ? Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 18,
                                                                  right: 18,
                                                                  top: 5),
                                                          child: CustomText(
                                                            text:
                                                                "${"refundedItems".tr().toString()}",
                                                            style: TextStyleConstant
                                                                .headerText(
                                                                    context,
                                                                    colorsValue),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ListView.builder(
                                                      itemCount: OrderCubit.get(
                                                              context)
                                                          .orderModelDetail
                                                          .data!
                                                          .order!
                                                          .refundedItems!
                                                          .length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return OrderItemWidget(
                                                          colorsValue:
                                                              colorsValue,
                                                          orderItem: OrderCubit
                                                                  .get(context)
                                                              .orderModelDetail
                                                              .data!
                                                              .order!
                                                              .refundedItems![index],
                                                        );
                                                      }),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
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
            listener: (context, state) {},
          ),
        ),
      ),
    );
  }
}
