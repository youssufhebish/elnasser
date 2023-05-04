import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/cart_item_model.dart';
import 'package:elnasser/models/cart_model/cart_model.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/image.dart';
import 'package:elnasser/widget/patch_widget.dart';
import 'package:elnasser/widget/sign_item_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderItemWidget extends StatelessWidget {
  OrderItemWidget({
    Key? key,
    required this.colorsValue,
    required this.orderItem,
  }) : super(key: key);
  final ColorsInitialValue colorsValue;
  final OrderItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    String choice = "";
    orderItem.choice != null
        ? orderItem.choice!.choices!.forEach((element) {
            choice = choice + element.trans!.first.choicesTitle!;
          })
        : print("");
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // decoration: BoxDecoration(
            //   border: Border(
            //     bottom: BorderSide(
            //       color: ColorsConstant.getColorBorder1(colorsValue)
            //     )
            //   )
            // ),
            height: 18.5.h,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7, bottom: 5),
                        child: ApiImage(
                            type: "medium",
                            folderName: "products",
                            image: orderItem.choice != null
                                ? orderItem.choice!.images!.isNotEmpty
                                    ? orderItem.choice!.images!.first
                                        .productsImagesName
                                    : orderItem.product!.productsImg
                                : orderItem.product!.productsImg),
                      ),
                      // Image.asset(ImageConstants.product1,fit: BoxFit.cover,),
                      orderItem.offer != null
                          ? Positioned(
                              top: 8,
                              left: 5,
                              child: PatchWidget(
                                backGroundColor:
                                    ColorsConstant.getColorBackground3(
                                        colorsValue),
                                title:
                                    "${orderItem.offer!.trans!.first.offersTitle != null ? orderItem.offer!.trans!.first.offersTitle : ""}",
                                colorsValue: colorsValue,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomText(
                                  text:
                                      "${orderItem.product!.trans!.first.productsTitle}",
                                  style: TextStyleConstant.bodyText(
                                      context, colorsValue)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            (orderItem.choice != null &&
                                    orderItem.choice!.attribute != null)
                                ? CustomText(
                                    text:
                                        "${orderItem.choice!.attribute!.trans!.first.attributesTitle}   ${choice}",
                                    style: TextStyleConstant.lightText(
                                        context, colorsValue))
                                : choice.isNotEmpty
                                    ? CustomText(
                                        text: "${choice}",
                                        style: TextStyleConstant.lightText(
                                            context, colorsValue))
                                    : Container(),
                            Spacer(),
                            CustomText(
                                text: "ItemsCount".tr().toString(),
                                style: TextStyleConstant.lightText(
                                    context, colorsValue)),
                            CustomText(
                                text: orderItem.ordersItemsCount!
                                    .split(".")
                                    .first,
                                style: TextStyleConstant.lightText(
                                    context, colorsValue))
                          ],
                        ),
                        Row(
                          children: [
                            (orderItem.ordersItemsPriceBeforeSale != "0.000" &&
                                    orderItem.ordersItemsPriceBeforeSale !=
                                        null)
                                ? CustomText(
                                    text:
                                        "${double.parse("${orderItem.ordersItemsPriceBeforeSale}")}",
                                    style: TextStyleConstant.cartItemDiscount(
                                        context, colorsValue))
                                : Container(),
                            SizedBox(
                              width: orderItem.ordersItemsPriceBeforeSale !=
                                      "0.000"
                                  ? 5
                                  : 0,
                            ),
                            orderItem.ordersItemsPrice != null
                                ? CustomText(
                                    text:
                                        "${double.parse("${orderItem.ordersItemsPrice}")} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                    style: TextStyleConstant.blackCaption12(
                                            context: context,
                                            colorValue: colorsValue)
                                        .copyWith(
                                            color: ColorsConstant.getColorText3(
                                                colorsValue)))
                                : Container(),
                            Spacer(),
                            CustomText(
                                text:
                                    "${(double.parse("${orderItem.product!.productsPoints}")).toInt()} ${"point".tr().toString()}",
                                style: TextStyleConstant.blackCaption12(
                                        context: context,
                                        colorValue: colorsValue)
                                    .copyWith(
                                        color: ColorsConstant.getColorText3(
                                            colorsValue))),
                          ],
                        ),

                        // Row(
                        //   children: [
                        //
                        //     (orderItem.ordersItemsPriceBeforeSale!= "0.000" && orderItem.ordersItemsPriceBeforeSale!=null)?   CustomText(text: "${(double.parse("${orderItem.ordersItemsPriceBeforeSale}")*double.parse("${orderItem.ordersItemsCount}")).toDouble()}", style: TextStyleConstant.cartItemDiscount(context,colorsValue)):Container(),
                        //     SizedBox(width: orderItem.ordersItemsPriceBeforeSale!= "0.000"? 5:0,),
                        //     // orderItem.ordersItemsPrice != null?  CustomText(text: "${(double.parse("${  orderItem.ordersItemsPrice }")*double.parse("${orderItem.ordersItemsCount}")).toStringAsFixed(2)} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}", style: TextStyleConstant.cartItemPrice(context,colorsValue)):Container(),
                        //
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          width: SizeDataConstant.fullWidth(context),
          color: ColorsConstant.getColorBorder1(colorsValue),
        ),
      ],
    );
  }
}
