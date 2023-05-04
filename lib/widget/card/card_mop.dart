import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/home_model.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_cubit.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/product_details_suggestion_cubit.dart';
import 'package:elnasser/widget/add_to_cart_bottom_sheet/methods/show_add_to_cart_sheet.dart';
import 'package:elnasser/widget/card/card_bloc/card_cubit.dart';
import 'package:elnasser/widget/image.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../alert.dart';
import '../patch_widget.dart';
import '../text_widget.dart';

class ProductCardMop extends StatefulWidget {
  ProductCardMop(
      {Key? key,
      required this.colorsValue,
      required this.product,
      this.type = ""})
      : super(key: key);
  ColorsInitialValue colorsValue;
  final ProductClass product;
  String type;

  @override
  State<ProductCardMop> createState() => _ProductCardMopState();
}

class _ProductCardMopState extends State<ProductCardMop> {
  bool color = false;

  @override
  void initState() {
    // TODO: implement initState
    color = widget.product.isFav == 1 ? true : false;

    print("${widget.product.isFav} ${widget.product.productsId}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeDataConstant.mopCardWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SizedBox(
                      width: SizeDataConstant.mopCardWidth(context),
                      child: ApiImage(
                        image: Responsive.isMobile(context)
                            ? widget.product.productsImg
                            : widget.product.productsImg,
                        folderName: 'products',
                        type: 'medium',
                        boxFit: BoxFit.cover,
                      )),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: EasyLocalization.of(context)!
                                  .currentLocale!
                                  .languageCode ==
                              "en"
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        widget.product.offer != null
                            ? ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        SizeDataConstant.mopCardWidth(context) -
                                            50),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: ColorsConstant.getColorBackground3(
                                        widget.colorsValue),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CustomText(
                                        text:
                                            "${widget.product.offer!.trans?.first.offersTitle}",
                                        maxLie: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyleConstant.whiteTextPatch(
                                            context, widget.colorsValue)),
                                  ),
                                ),
                              )
                            : Container(),
                        // (product!.offer != null &&
                        //     (product!.offer!.offersAdditionalNumber !=
                        //         null
                        //         ? int.parse(
                        //         "${product!.offer?.offersAdditionalNumber}") !=
                        //         0
                        //         : false) &&
                        //     (product!.offer!.offersMainNumber != null
                        //         ? int.parse(
                        //         "${product!.offer?.offersMainNumber}") ==
                        //         1
                        //         : false))
                        //     ? PatchWidget(backGroundColor: ColorsConstant.getColorBackground3(colorsValue), title: product!.offer!.offersTitle!, colorsValue: colorsValue,)
                        //     : Container(),
                        const SizedBox(
                          height: 4,
                        ),
                        widget.product.mostWanted == 1
                            ? widget.type == "bestSale"
                                ? Container(
                                    width: 0,
                                  )
                                : PatchWidget(
                                    backGroundColor:
                                        ColorsConstant.getColorBackground1(
                                            widget.colorsValue),
                                    title: "bestSeller".tr().toString(),
                                    colorsValue: widget.colorsValue,
                                  )
                            : Container(),
                        const SizedBox(
                          height: 4,
                        ),
                        widget.product.isNew == 1
                            ? widget.type == "newArrivals"
                                ? Container(
                                    width: 0,
                                  )
                                : PatchWidget(
                                    backGroundColor:
                                        ColorsConstant.getColorBackground2(
                                            widget.colorsValue),
                                    title: "new".tr().toString(),
                                    colorsValue: widget.colorsValue,
                                  )
                            : Container(
                                width: 0,
                              ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              // fav.fetchFavoriteProduct(context);

                              if (HomeMobileCubit.get(context).isUserLogin ==
                                  false) {
                                DataErrorAlert.showLogin(
                                    colorValue: widget.colorsValue,
                                    title: 'YouNeedToLogin'.tr().toString(),
                                    data: 'pleaseLoginFirst'.tr().toString(),
                                    context: context);
                              } else {
                                setState(() {
                                  color = !color;
                                });
                                if (widget.product.isFav == 1) {
                                  widget.product.isFav = 0;
                                } else {
                                  widget.product.isFav = 1;
                                }

                                FavoriteCubit.get(context).addToFavorite(
                                    context: context,
                                    productId: "${widget.product.productsId}");
                                // onFavSubmit(_meals);

                                // var res = await updateFavsItem(
                                //     EasyLocalization.of(context)
                                //         .currentLocale
                                //         .languageCode,
                                //     widget.token,
                                //     widget.product.productsId,context);
                                // if (res.status == 200) {
                                //   SuccDialogAlertStaySameLayout(
                                //       context, res.message,ValueKey("Product${widget.product.productsId}"));
                                // } else {
                                //   if (res.status == 401) {
                                //     SystemControls().LogoutSetUserData(
                                //         context,
                                //         EasyLocalization.of(context)
                                //             .currentLocale
                                //             .languageCode);
                                //   }

                                if (widget.product.isFav == 1) {
                                  widget.product.isFav = 0;
                                } else {
                                  widget.product.isFav = 1;
                                }
                                // onFavSubmit(_meals);

                                // ErrorDialogAlert(context, res.message);
                                // }
                              }
                              // home.notifyListeners();
                            },
                            icon: Icon(
                              color == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: color == true
                                  ? ColorsConstant.getColorText5(
                                      widget.colorsValue)
                                  : null,
                            )),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.2,
              child: Row(
                children: [
                  Expanded(
                      child: CustomText(
                    text: "${widget.product.trans?.first.productsTitle}",
                    style: TextStyleConstant.cardProductNameTextStyle(
                        context, widget.colorsValue),
                    maxLie: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            ),
          ),
          (widget.product.offer != null &&
                  (widget.product.offer!.offersAdditionalNumber != null
                      ? int.parse(
                              "${widget.product.offer?.offersAdditionalNumber}") ==
                          0
                      : false) &&
                  (widget.product.offer!.offersMainNumber != null
                      ? int.parse(
                              "${widget.product.offer?.offersMainNumber}") ==
                          1
                      : false))
              ? Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Row(
                      children: [
                        widget.product.offer != null
                            ? CustomText(
                                text: "\$ ${widget.product.productsPrice}",
                                style: TextStyleConstant
                                    .cardProductPriceDiscountTextStyle(
                                        context, widget.colorsValue),
                              )
                            : Container(),
                        widget.product.offer != null
                            ? const SizedBox(
                                width: 15,
                              )
                            : Container(),
                        CustomText(
                          text:
                              "${widget.product.offer != null ? ((int.parse("${widget.product.productsPrice}") / 100) * int.parse("${widget.product.offer!.offersDiscount}")) : widget.product.productsPrice}",
                          style: TextStyleConstant.cardProductPriceTextStyle(
                              context, widget.colorsValue),
                        ),
                        Spacer(),
                        AddToCartCardWidget(
                          colorsValue: widget.colorsValue,
                          product: widget.product,
                        )
                      ],
                    ),
                  ),
                )
              : Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      CustomText(
                        text:
                            "${widget.product.productsPrice} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                        style: TextStyleConstant.cardProductPriceTextStyle(
                            context, widget.colorsValue),
                      ),
                      Spacer(),
                      AddToCartCardWidget(
                        colorsValue: widget.colorsValue,
                        product: widget.product,
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class AddToCartCardWidget extends StatelessWidget {
  AddToCartCardWidget(
      {Key? key, required this.colorsValue, required this.product})
      : super(key: key);
  ColorsInitialValue colorsValue;
  final ProductClass product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AddToCartCubit.get(context).resetData();
        ProductDetailsSliderCubit.get(context).clearData();

        ///  See After Edit API V002
        (product.productsChoices!.isEmpty &&
                product.attributes!.isEmpty &&
                "${product.stock}" == "0")
            ? null
            : showDraggableSheet().showSheet(
                context: context,
                colorsValue: colorsValue,
                theInitialModel: SplashCubit.get(context).theInitialModel,
                productClass: product,
                productImage: product.productsImg,
                attributeProductsChoice: product.productsChoices,
                attribute: product.attributes,
                images: product.images!,
              );
      },
      child: Container(
          width: 60,
          height: 40,
          child: ImageView(
            path: ImageConstants.addToCart,
            color: ((product.productsChoices!.isEmpty &&
                    product.attributes!.isEmpty &&
                    "${product.stock}" == "0"))
                ? ColorsConstant.getColorBorder1(colorsValue)
                : ColorsConstant.getColorBackground3(colorsValue),
            fit: BoxFit.contain,
          )),
    );
  }
}
