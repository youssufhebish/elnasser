import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/orders_screen/Order_screen.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit_state.dart';
import 'package:elnasser/screens/refund/refund_screen.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// order Status ///
//   '0 => cancelled, 1 => new', 2 => preparing, 3 => on the way, 4 => done', 5 => cancelled_by_client'
class OrderMethods {
  OrderMethods({required this.colorsValue});
  final ColorsInitialValue colorsValue;

  getStatusColor(String status) {
    switch (status) {
      case "0":
        return ColorsConstant.getColorText5(colorsValue);
      case "5":
        return ColorsConstant.getColorText5(colorsValue);
      case "6":
        return ColorsConstant.getColorText5(colorsValue);
      case "4":
        return ColorsConstant.getColorText6(colorsValue);
      case "9":
        return ColorsConstant.getColorText6(colorsValue);
      default:
        {
          return ColorsConstant.getColorText3(colorsValue);
        }
    }
  }

  getStatusWidget(String status) {
    switch (status) {
      case "0":
        return Icon(
          Icons.clear,
          color: ColorsConstant.getColorText5(colorsValue),
        );
      case "5":
        return Icon(
          Icons.clear,
          color: ColorsConstant.getColorText5(colorsValue),
        );
      case "4":
        return Icon(
          Icons.check,
          color: ColorsConstant.getColorText6(colorsValue),
        );
      default:
        {
          return Container();
        }
    }
  }

  getOrderDetailWidget(
      {required String status,
      required BuildContext context,
      required String orderId,
      required List<OrderItemModel> items}) {
    switch (status) {
      case "1":
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: BlocConsumer<OrderCubit, OrderCubitState>(
                builder: (contexts, state) {
                  return AppButton(
                    withBorder: true,
                    color: ColorsConstant.getColorBackground3(colorsValue),
                    colorsInitialValue: colorsValue,
                    onPressed: () {
                      OrderCubit.get(context)
                          .CancelOrderMethod(context: context, orderId: orderId)
                          .whenComplete(() {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                    title: 'cancelTheOrder'.tr().toString(),
                    textStyle: TextStyleConstant.buttonTextMainColor(
                        context, colorsValue),
                  );
                },
                listener: (context, state) {
                  if (state is OrderCubitStateCancelOrderSuccess) {
                    DataErrorAlert.CancelOrderSuccess(
                        colorValue: colorsValue, context: context);
                  }
                },
              ),
            ),
            SizedBox(
              width: 18,
            ),
            Expanded(
              child: BlocConsumer<OrderCubit, OrderCubitState>(
                listener: (contexsts, state) {
                  print(state);

                  if (state is OrderCubitStateReorderSuccess) {
                    AddToCartCubit.get(context).getCart(context: context);
                    Navigator.pop(context);
                    DataErrorAlert.ReorderSuccess(
                        colorValue: colorsValue, context: context);
                  }
                },
                builder: (contexts, state) {
                  return AppButton(
                    color: ColorsConstant.getColorBackground3(colorsValue),
                    colorsInitialValue: colorsValue,
                    onPressed: () {
                      DataErrorAlert.cartWillBeDeleted(
                          colorValue: colorsValue,
                          ordersId: orderId,
                          context: context);
                    },
                    title: 'reOrder'.tr().toString(),
                    textStyle:
                        TextStyleConstant.buttonText(context, colorsValue),
                  );
                },
              ),
            ),
          ],
        );
      case "4":
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: BlocConsumer<OrderCubit, OrderCubitState>(
                listener: (context, state) {
                  if (state is OrderCubitStateRefundOrderSuccess) {}
                },
                builder: (context, state) {
                  return AppButton(
                    withBorder: true,
                    color: ColorsConstant.getColorBackground3(colorsValue),
                    colorsInitialValue: colorsValue,
                    onPressed: () {
                      // DataErrorAlert.OrderReasonRefund(colorValue: colorsValue, context: context, controller: OrderCubit.get(context).refundController,id: orderId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RefundScreen(
                                    items: items,
                                    colorsValue: colorsValue,
                                    orderId: orderId,
                                  )));
                    },
                    title: 'refund'.tr().toString(),
                    textStyle: TextStyleConstant.buttonTextMainColor(
                        context, colorsValue),
                  );
                },
              ),
            ),
            SizedBox(
              width: 18,
            ),
            Expanded(
              child: BlocConsumer<OrderCubit, OrderCubitState>(
                listener: (contexst, state) {
                  print("state $state");
                  if (state is OrderCubitStateReorderSuccess) {
                    AddToCartCubit.get(context).getCart(context: context);
                    // Navigator.pop(context);
                    DataErrorAlert.ReorderSuccess(
                        colorValue: colorsValue, context: context);
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    color: ColorsConstant.getColorBackground3(colorsValue),
                    colorsInitialValue: colorsValue,
                    onPressed: () {
                      DataErrorAlert.cartWillBeDeleted(
                          colorValue: colorsValue,
                          ordersId: orderId,
                          context: context);
                    },
                    title: 'reOrder'.tr().toString(),
                    textStyle:
                        TextStyleConstant.buttonText(context, colorsValue),
                  );
                },
              ),
            ),
          ],
        );
      case "6":
        return Container();
      default:
        {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              BlocConsumer<OrderCubit, OrderCubitState>(
                listener: (contesxt, state) {
                  print(state);

                  if (state is OrderCubitStateReorderSuccess) {
                    AddToCartCubit.get(context).getCart(context: context);
                    // Navigator.pop(context);
                    DataErrorAlert.ReorderSuccess(
                        colorValue: colorsValue, context: context);
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    color: ColorsConstant.getColorBackground3(colorsValue),
                    colorsInitialValue: colorsValue,
                    onPressed: () {
                      DataErrorAlert.cartWillBeDeleted(
                          colorValue: colorsValue,
                          ordersId: orderId,
                          context: context);
                    },
                    title: 'reOrder'.tr().toString(),
                    textStyle:
                        TextStyleConstant.buttonText(context, colorsValue),
                  );
                },
              ),
              Spacer(),
            ],
          );
        }
    }
  }

  String? getStatus(String status) {
    switch (status) {
      case "0":
        return "cancelled";

      case "1":
        return "new";
      case "2":
        return "preparing";
      case "3":
        return "onTheWay";
      case "4":
        return "done";
      case "9":
        return "returned";
      case "5":
        return "cancelledByClient";
      case "6":
        return "rejectedByCustomer";
      case "-1":
        return "fullyReturned";
      default:
        return "";
    }
  }

  String? getReturnStatus(String status) {
    switch (status) {
      case "0":
        return "new";

      case "1":
        return "executingTheRequest";
      case "2":
        return "reject";
      case "3":
        return "partiallyReturned";
      case "4":
        return "fullReturned";
    }
  }

  getReturnStatusColor(String status) {
    switch (status) {
      case "2":
        return ColorsConstant.getColorText5(colorsValue);

      case "3":
        return ColorsConstant.getColorText6(colorsValue);
      case "4":
        return ColorsConstant.getColorText6(colorsValue);
      case "4":
        return ColorsConstant.getColorText6(colorsValue);
      default:
        {
          return ColorsConstant.getColorText7(colorsValue);
        }
    }
  }

  convertDate(String date) {
    DateTime localDate = DateTime.parse(date).toLocal();
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse("$localDate").toLocal();
    var inputDate = DateTime.parse(parseDate.toString()).toLocal();
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate).toLocale();
    return outputDate;
  }
}
