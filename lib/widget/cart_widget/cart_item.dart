import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/cart_item_model.dart';
import 'package:elnasser/models/cart_model/cart_model.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../image.dart';
import '../image_widget.dart';
import '../patch_widget.dart';
import '../sign_item_widget.dart';
import '../text_widget.dart';

class CardCartItem extends StatelessWidget {
  CardCartItem(
      {Key? key,
      required this.colorsValue,
      required this.cartItem,
      required this.isReview})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final CartItemsModel cartItem;
  final bool isReview;

  @override
  Widget build(BuildContext context) {
    String choice = "";
    cartItem.choice != null
        ? cartItem.choice!.choices!.forEach((element) {
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
            height: 20.5.h,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7, bottom: 5),
                        child: ApiImage(
                            type: "medium",
                            folderName: "products",
                            boxFit: BoxFit.contain,
                            image: cartItem.choice != null
                                ? cartItem.choice!.images!.isNotEmpty
                                    ? cartItem.choice!.images!.first
                                        .productsImagesName
                                    : cartItem.product!.productsImg
                                : cartItem.product!.productsImg),
                      ),
                      // Image.asset(ImageConstants.product1,fit: BoxFit.cover,),
                      cartItem.productOffer != null
                          ? Positioned(
                              top: 7.5,
                              left: Responsive.isMobile(context) ? 5 : 20,
                              right: Responsive.isMobile(context) ? 0 : 20,
                              child: SizedBox(
                                width: 30.w,
                                child: PatchWidget(
                                  backGroundColor:
                                      ColorsConstant.getColorBackground3(
                                          colorsValue),
                                  title:
                                      "${cartItem.productOffer!.trans!.first.offersTitle}",
                                  colorsValue: colorsValue,
                                ),
                              ),
                              //   CustomPaint(
                              //
                              //   size: Size(35.w,(27.w*0.2).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              //   painter: RPSCustomPainter(colorsInitialValue: colorsValue),
                              //   child: Container(
                              //     width: SizeDataConstant.customWidth(context, 3.4),
                              //     child: Row(
                              //       children: [
                              //         Expanded(child: Center(child: Padding(
                              //           padding: const EdgeInsets.all(3.0),
                              //           child: CustomText(
                              //               overflow: TextOverflow.ellipsis,
                              //               maxLie: 1,
                              //               text: "${cartItem.productOffer!.offersTitle}", style: TextStyleConstant.captionMainColor(context, colorsValue)),
                              //         ))),
                              //
                              //       ],
                              //     ),
                              //   ),
                              // ),
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
                                  maxLie: 2,
                                  text:
                                      "${cartItem.product!.trans!.first.productsTitle}",
                                  style: TextStyleConstant.bodyText(
                                      context, colorsValue)),
                            ),
                            isReview
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    onPressed: () {
                                      AddToCartCubit.get(context)
                                          .deleteCartApi(
                                              context: context,
                                              productId:
                                                  "${cartItem.cartsItemsId}")
                                          .whenComplete(() =>
                                              AddToCartCubit.get(context)
                                                  .getCart(context: context));
                                    },
                                    icon: ImageView(
                                      path: ImageConstants.delete,
                                    )),
                          ],
                        ),
                        (cartItem.choice != null)
                            ? CustomText(
                                text:
                                    "${cartItem.choice!.attribute != null ? cartItem.choice!.attribute!.trans!.first.attributesTitle : "Size".tr().toString()}   ${choice}",
                                style: TextStyleConstant.lightText(
                                    context, colorsValue))
                            : Container(),
                        Row(
                          children: [
                            (cartItem.cartsItemsPriceBeforeSale != "0.000" &&
                                    cartItem.cartsItemsPriceBeforeSale != null)
                                ? CustomText(
                                    text:
                                        "${double.parse("${cartItem.cartsItemsPriceBeforeSale}")}",
                                    style: TextStyleConstant.cartItemDiscount(
                                        context, colorsValue))
                                : Container(),
                            SizedBox(
                              width:
                                  cartItem.cartsItemsPriceBeforeSale != "0.000"
                                      ? 5
                                      : 0,
                            ),
                            cartItem.cartsItemsPrice != null
                                ? CustomText(
                                    text:
                                        "${double.parse("${cartItem.cartsItemsPrice}")} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                    style: TextStyleConstant.blackCaption12(
                                        context: context,
                                        colorValue: colorsValue))
                                : Container(),
                            Spacer(),
                            SizedBox(
                              height: 3.h,
                              width: 3.h,
                              child: ImageView(
                                path: ImageConstants.pointGift,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: 3.5.h,
                              child: Column(
                                children: [
                                  Spacer(),
                                  CustomText(
                                      text:
                                          " ${cartItem.product!.productsPoints} ${"points".tr().toString()}",
                                      style: TextStyle(
                                          color: Color(0xffD8B836),
                                          fontSize: Responsive.isMobile(context)
                                              ? 12
                                              : 18)),
                                ],
                              ),
                            )
                          ],
                        ),
                        cartItem.choice != null
                            ? int.parse("${cartItem.choice!.stock}") > 0
                                ? Row(
                                    children: [
                                      isReview
                                          ? Container(
                                              width: 0,
                                            )
                                          : Row(
                                              children: [
                                                Container(
                                                    color: ColorsConstant
                                                        .getColorBackground5(
                                                            colorsValue),
                                                    height: 5.h,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        AddToCartCubit.get(
                                                                context)
                                                            .getProductCountUpdatePlus(
                                                                double.parse(
                                                                        "${cartItem.cartsItemsCount}")
                                                                    .toInt());
                                                        cartItem.fkProductsChoicesId !=
                                                                null
                                                            ? AddToCartCubit
                                                                    .get(
                                                                        context)
                                                                .getProductChoiceID(
                                                                    cartItem
                                                                        .fkProductsChoicesId!)
                                                            : print('');
                                                        AddToCartCubit.get(
                                                                context)
                                                            .addToCartApi(
                                                                context:
                                                                    context,
                                                                productId: cartItem
                                                                    .product!
                                                                    .productsId!,
                                                                inCart: true,
                                                                add: true);
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: ColorsConstant
                                                            .getColorBackground3(
                                                                colorsValue),
                                                      ),
                                                    )),
                                                Container(
                                                    height: 5.h,
                                                    color: ColorsConstant
                                                        .getColorBackground5(
                                                            colorsValue),
                                                    child: Center(
                                                        child: CustomText(
                                                            text:
                                                                "${cartItem.cartsItemsCount!.replaceAll(".000", "")}",
                                                            style: TextStyleConstant
                                                                .bodyText(
                                                                    context,
                                                                    colorsValue)))),
                                                Container(
                                                    height: 5.h,
                                                    color: ColorsConstant
                                                        .getColorBackground5(
                                                            colorsValue),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        AddToCartCubit.get(
                                                                context)
                                                            .getProductCountUpdateMinus(
                                                                double.parse(
                                                                        "${cartItem.cartsItemsCount}")
                                                                    .toInt());
                                                        cartItem.fkProductsChoicesId !=
                                                                null
                                                            ? AddToCartCubit
                                                                    .get(
                                                                        context)
                                                                .getProductChoiceID(
                                                                    cartItem
                                                                        .fkProductsChoicesId!)
                                                            : print('');
                                                        AddToCartCubit.get(
                                                                context)
                                                            .addToCartApi(
                                                                context:
                                                                    context,
                                                                productId: cartItem
                                                                    .product!
                                                                    .productsId!,
                                                                inCart: true,
                                                                add: false);
                                                      },
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color: ColorsConstant
                                                            .getColorBackground3(
                                                                colorsValue),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                      isReview
                                          ? Container(
                                              width: 0,
                                            )
                                          : Spacer(),
                                      (cartItem.cartsItemsPriceBeforeSale !=
                                                  "0.000" &&
                                              cartItem.cartsItemsPriceBeforeSale !=
                                                  null)
                                          ? CustomText(
                                              text:
                                                  "${(double.parse("${cartItem.cartsItemsPriceBeforeSale}") * double.parse("${cartItem.cartsItemsCount}")).toDouble()}",
                                              style: TextStyleConstant
                                                  .cartItemDiscount(
                                                      context, colorsValue))
                                          : Container(),
                                      SizedBox(
                                        width:
                                            cartItem.cartsItemsPriceBeforeSale !=
                                                    "0.000"
                                                ? 5
                                                : 0,
                                      ),
                                      cartItem.cartsItemsPrice != null
                                          ? CustomText(
                                              text:
                                                  "${(double.parse("${cartItem.cartsItemsPrice}") * double.parse("${cartItem.cartsItemsCount}")).toStringAsFixed(2)} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                              style: TextStyleConstant
                                                  .cartItemPrice(
                                                      context, colorsValue))
                                          : Container(),
                                    ],
                                  )
                                : CustomText(
                                    text: "outOfStock".tr().toString(),
                                    style: TextStyleConstant.errorText(
                                        context, colorsValue),
                                  )
                            : int.parse("${cartItem.product!.productsStocks}") >
                                    0
                                ? Row(
                                    children: [
                                      isReview
                                          ? Container(
                                              width: 0,
                                            )
                                          : Row(
                                              children: [
                                                Container(
                                                    color: ColorsConstant
                                                        .getColorBackground5(
                                                            colorsValue),
                                                    height: 5.h,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        AddToCartCubit.get(
                                                                context)
                                                            .getProductCountUpdatePlus(
                                                                double.parse(
                                                                        "${cartItem.cartsItemsCount}")
                                                                    .toInt());
                                                        cartItem.fkProductsChoicesId !=
                                                                null
                                                            ? AddToCartCubit
                                                                    .get(
                                                                        context)
                                                                .getProductChoiceID(
                                                                    cartItem
                                                                        .fkProductsChoicesId!)
                                                            : print('');
                                                        AddToCartCubit.get(
                                                                context)
                                                            .addToCartApi(
                                                                context:
                                                                    context,
                                                                productId: cartItem
                                                                    .product!
                                                                    .productsId!,
                                                                inCart: true,
                                                                add: true);
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: ColorsConstant
                                                            .getColorBackground3(
                                                                colorsValue),
                                                      ),
                                                    )),
                                                Container(
                                                    height: 5.h,
                                                    color: ColorsConstant
                                                        .getColorBackground5(
                                                            colorsValue),
                                                    child: Center(
                                                        child: CustomText(
                                                            text:
                                                                "${cartItem.cartsItemsCount!.replaceAll(".000", "")}",
                                                            style: TextStyleConstant
                                                                .bodyText(
                                                                    context,
                                                                    colorsValue)))),
                                                Container(
                                                    height: 5.h,
                                                    color: ColorsConstant
                                                        .getColorBackground5(
                                                            colorsValue),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        AddToCartCubit.get(
                                                                context)
                                                            .getProductCountUpdateMinus(
                                                                double.parse(
                                                                        "${cartItem.cartsItemsCount}")
                                                                    .toInt());
                                                        cartItem.fkProductsChoicesId !=
                                                                null
                                                            ? AddToCartCubit
                                                                    .get(
                                                                        context)
                                                                .getProductChoiceID(
                                                                    cartItem
                                                                        .fkProductsChoicesId!)
                                                            : print('');
                                                        AddToCartCubit.get(
                                                                context)
                                                            .addToCartApi(
                                                                context:
                                                                    context,
                                                                productId: cartItem
                                                                    .product!
                                                                    .productsId!,
                                                                inCart: true,
                                                                add: false);
                                                      },
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color: ColorsConstant
                                                            .getColorBackground3(
                                                                colorsValue),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                      isReview
                                          ? Container(
                                              width: 0,
                                            )
                                          : Spacer(),
                                      (cartItem.cartsItemsPriceBeforeSale !=
                                                  "0.000" &&
                                              cartItem.cartsItemsPriceBeforeSale !=
                                                  null)
                                          ? CustomText(
                                              text:
                                                  "${(double.parse("${cartItem.cartsItemsPriceBeforeSale}") * double.parse("${cartItem.cartsItemsCount}")).toDouble()}",
                                              style: TextStyleConstant
                                                  .cartItemDiscount(
                                                      context, colorsValue))
                                          : Container(),
                                      SizedBox(
                                        width:
                                            cartItem.cartsItemsPriceBeforeSale !=
                                                    "0.000"
                                                ? 5
                                                : 0,
                                      ),
                                      cartItem.cartsItemsPrice != null
                                          ? CustomText(
                                              text:
                                                  "${(double.parse("${cartItem.cartsItemsPrice}") * double.parse("${cartItem.cartsItemsCount}")).toStringAsFixed(2)} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                              style: TextStyleConstant
                                                  .cartItemPrice(
                                                      context, colorsValue))
                                          : Container(),
                                    ],
                                  )
                                : CustomText(
                                    text: "outOfStock".tr().toString(),
                                    style: TextStyleConstant.errorText(
                                        context, colorsValue),
                                  ),
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
