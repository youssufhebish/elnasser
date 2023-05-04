import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/models/order_model/order_model_detail.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit_state.dart';
import 'package:elnasser/screens/orders_screen/order_data_provider/order_methods.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget(
      {Key? key, required this.colorsValue, required this.orderListModel})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final Order orderListModel;

  /// order Status ///
//   '0 => cancelled, 1 => new', 2 => preparing, 3 => on the way, 4 => done', 5 => cancelled_by_client'

  /// convert date

  @override
  Widget build(BuildContext context) {
    print("${orderListModel.ordersStatus} -- ${orderListModel.ordersNo}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        height:
            EasyLocalization.of(context)!.currentLocale!.languageCode == "ar"
                ? 23.h
                : 18.h,
        width: SizeDataConstant.fullWidth(context),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsConstant.getColorBorder1(colorsValue),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Expanded(
                    child: CustomText(
                  text: "${"code".tr().toString()}: ${orderListModel.ordersNo}",
                  style: TextStyleConstant.headerText(context, colorsValue),
                )),
                OrderMethods(colorsValue: colorsValue)
                    .getStatusWidget("${orderListModel.ordersStatus}")
              ],
            ),
            CustomText(
              text:
                  "${"date".tr().toString()}: ${OrderMethods(colorsValue: colorsValue).convertDate("${orderListModel.ordersCreatedAt}")} ",
              style: TextStyleConstant.bodyTextGrey(context, colorsValue),
            ),
            CustomText(
              text:
                  "${"count".tr().toString()}: ${orderListModel.items!.length} ${"products".tr().toString()}",
              style: TextStyleConstant.bodyTextGrey(context, colorsValue),
            ),
            Row(
              children: [
                Expanded(
                  child: RichText(
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
                                  color: OrderMethods(colorsValue: colorsValue)
                                      .getStatusColor(
                                          "${orderListModel.ordersStatus}")),
                        ),
                      ],
                    ),
                  ),
                ),
                orderListModel.orderReturnModel == null
                    ? Container()
                    : RichText(
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
                      )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<OrderCubit, OrderCubitState>(
                    builder: (context, state) {
                      return (OrderCubit.get(context).orderModelDetail.data !=
                                  null &&
                              OrderCubit.get(context)
                                  .orderModelDetail
                                  .data!
                                  .shippingStatus!
                                  .isNotEmpty &&
                              OrderCubit.get(context)
                                      .orderModelDetail
                                      .data!
                                      .order!
                                      .ordersId ==
                                  orderListModel.ordersId)
                          ? RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${"statusShipping".tr().toString()}: ',
                                    style: TextStyleConstant.bodyTextGrey(
                                        context, colorsValue),
                                  ),
                                  TextSpan(
                                    text: OrderCubit.get(context)
                                        .orderModelDetail
                                        .data!
                                        .shippingStatus,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                            color: ColorsConstant
                                                .getColorBackground3(
                                                    colorsValue)),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                    },
                  ),
                ),
                orderListModel.shipping != null
                    ? AppButton(
                        widthRatio: 2.65,
                        heightRatio: 4,
                        colorsInitialValue: colorsValue,
                        color: ColorsConstant.getColorBackground3(colorsValue),
                        textStyle:
                            TextStyleConstant.buttonText(context, colorsValue),
                        title: "shippingRefresh".tr().toString(),
                        onPressed: () {
                          OrderCubit.get(context).getOrderDetails(
                              context: context,
                              orderId: "${orderListModel.ordersId}");
                        })
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
