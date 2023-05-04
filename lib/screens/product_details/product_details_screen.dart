import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_state.dart';
import 'package:elnasser/screens/rating/rating_screen.dart';
import 'package:elnasser/widget/add_to_cart_bottom_sheet/methods/show_add_to_cart_sheet.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/cart_ounter_widget.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/no_item_widget.dart';
import 'package:elnasser/widget/patch_widget.dart';
import 'package:elnasser/widget/product_grid_list.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

import 'product_details_bloc/product_details_suggestion_cubit.dart';
import 'product_details_bloc/product_details_suggestion_state.dart';
import 'widget/prdouct_details_atributes.dart';
import 'widget/product_details_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, this.product, required this.theInitialModel, required this.colorsValue}) : super(key: key);
  final ProductClass? product;
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();

    // Initialize Twitter OAuth
    AddToCartCubit.get(context).resetData();
    ProductDetailsSliderCubit.get(context).clearData();
  }

  @override
  Widget build(BuildContext context) {
    String? categorySeriousTitle = "";

    print("product!.stock");
    print("${widget.product!.stock}");
    print("product!.stock");
    widget.product != null
        ? widget.product?.categorySeries?.forEach((element) {
            categorySeriousTitle = categorySeriousTitle! + "->" + element.trans!.first.categoriesTitle!;
          })
        : print("");

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        ProductDetailsSuggestionCubit.get(context).productIds.removeLast();

        ProductDetailsSuggestionCubit.get(context).productIds.isNotEmpty
            ? ProductDetailsSuggestionCubit.get(context).getProductDetails(
                context,
              )
            : null;
        return false;
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: AppButton(
              radius: 0,
              withBorder: false,
              widthRatio: 1,
              disable:
                  (widget.product!.productsChoices!.isEmpty && widget.product!.attributes!.isEmpty && "${widget.product!.stock}" == "0")
                      ? true
                      : false,
              colorsInitialValue: widget.colorsValue,
              textStyle: TextStyleConstant.whiteText(context, widget.colorsValue),
              title: 'addToCart'.tr().toString(),
              color: ColorsConstant.getColorBackground3(widget.colorsValue),
              onPressed: () {
                // AddToCartCubit.get(context).resetData();
                ///  See After Edit API V002

                showDraggableSheet().showSheet(
                  context: context,
                  colorsValue: widget.colorsValue,
                  theInitialModel: widget.theInitialModel,
                  productClass: widget.product!,
                  productImage: widget.product!.productsImg,
                  attributeProductsChoice: widget.product!.productsChoices,
                  attribute: widget.product!.attributes,
                  images: widget.product!.images!,
                );
              },
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 35,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.pop(context, [widget.product!]);

                  WidgetsFlutterBinding.ensureInitialized().endOfFrame.whenComplete(() {
                    ProductDetailsSuggestionCubit.get(context).productIds.removeLast();

                    ProductDetailsSuggestionCubit.get(context).productIds.isNotEmpty
                        ? ProductDetailsSuggestionCubit.get(context).getProductDetails(
                            context,
                          )
                        : print("");
                  });
                },
              ),
              actions: [
                RotatedBox(
                  quarterTurns: 3,
                  child: IconButton(
                    icon: Icon(
                      Icons.logout,
                      size: 25,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      Share.share("${widget.theInitialModel.data!.account!.accountsProductUrl}/${widget.product!.productsId}");
                    },
                  ),
                ),
                CartCounterWidget(colorsValue: widget.colorsValue)
              ],
            ),
            // extendBodyBehindAppBar: product!.images!.isNotEmpty ? true : false,
            body: BlocBuilder<ProductDetailsSliderCubit, ProductDetailsSliderState>(
              buildWhen: (prev, current) =>
                  (current is ProductDetailsStateSuccess || current is ProductDetailsStateLoading || current is ProductDetailsStateFail),
              builder: (context, state) {
                if (state is ProductDetailsStateLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductDetailsStateFail) {
                  return NoItemWidget(colorsValue: widget.colorsValue);
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///  See After Edit API V002
                        ProductDetalSliderWidget(
                          product: widget.product!,
                          images: widget.product!.images!,
                          video: widget.product!.productsVideo,
                          productImage: widget.product!.productsImg,
                          attributeProductsChoice: widget.product!.productsChoices,
                          attribute: widget.product!.attributes,
                          favorite: widget.product!.isFav!,
                          colorsValue: widget.colorsValue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 15.0, right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Row(
                              //   children: [
                              //     Expanded(
                              //         flex: 3,
                              //         child: CustomText(
                              //           text: categorySeriousTitle!
                              //               .replaceFirst("->", ""),
                              //           style: TextStyle(),
                              //         )),
                              //
                              //   ],
                              // ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: CustomText(
                                        text: widget.product?.trans!.first.productsTitle,
                                        style: TextStyleConstant.bodyText(context, widget.colorsValue)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RatingScreen(
                                                    colorsValue: widget.colorsValue,
                                                    productId: "${widget.product!.productsId}",
                                                  )));
                                    },
                                    child: RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: double.parse("${widget.product!.productsRating}"),
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: Responsive.isMobile(context) ? 18 : 25,
                                      glow: false,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Color(0xffD8B836),
                                      ),
                                      onRatingUpdate: (rating) {
                                        // print(rating);
                                      },
                                    ),
                                  ),
                                  CustomText(
                                      text: "( ${widget.product!.productsRating} )",
                                      style: TextStyle(color: Color(0xffD8B836), fontSize: Responsive.isMobile(context) ? 14 : 18)),
                                  Spacer(),
                                  SizedBox(
                                    height: 2.3.h,
                                    width: 3.h,
                                    child: ImageView(
                                      path: ImageConstants.pointGift,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        CustomText(
                                            text: "${widget.product?.productsPoints} ${"point".tr().toString()}",
                                            style: TextStyle(color: Color(0xffD8B836), fontSize: Responsive.isMobile(context) ? 16 : 20)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  (widget.product!.offer != null &&
                                          (widget.product!.offer!.offersAdditionalNumber != null ? false : true) &&
                                          (widget.product!.offer!.offersMainNumber != null
                                              ? int.parse("${widget.product!.offer?.offersMainNumber}") == 1
                                              : false))
                                      ? RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    ' ${widget.product!.productsPrice} ${widget.theInitialModel.data?.setting!.settingsCurrency}',
                                                style: TextStyleConstant.cardProductPriceDiscountTextStyle(context, widget.colorsValue),
                                              ),
                                              TextSpan(
                                                text:
                                                    "    ${(int.parse("${widget.product!.productsPrice}") - ((int.parse("${widget.product!.productsPrice}") / 100) * int.parse("${widget.product!.offer!.offersDiscount}"))).toStringAsFixed(2)} ${widget.theInitialModel.data?.setting!.settingsCurrency}",
                                                style: TextStyleConstant.cardProductPriceTextStyleMainColor(context, widget.colorsValue),
                                              ),
                                            ],
                                          ),
                                        )
                                      : CustomText(
                                          text:
                                              ' ${widget.product!.productsPrice} ${widget.theInitialModel.data?.setting!.settingsCurrency}',
                                          style: TextStyleConstant.cardProductPriceTextStyle(context, widget.colorsValue),
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Wrap(
                                      spacing: 5,
                                      runSpacing: 5,
                                      direction: Axis.horizontal,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      alignment: WrapAlignment.start,
                                      children: [
                                        widget.product!.offer != null
                                            ? ConstrainedBox(
                                                constraints: BoxConstraints(maxWidth: SizeDataConstant.mopCardWidth(context) - 50),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    color: ColorsConstant.getColorBackground3(widget.colorsValue),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: CustomText(
                                                        text: "${widget.product!.offer!.trans!.first.offersTitle}",
                                                        maxLie: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyleConstant.whiteTextPatch(context, widget.colorsValue)),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                              ),
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
                                        widget.product!.mostWanted == 1
                                            ? PatchWidget(
                                                backGroundColor: ColorsConstant.getColorBackground1(widget.colorsValue),
                                                title: "bestSeller".tr().toString(),
                                                colorsValue: widget.colorsValue,
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        widget.product!.isNew == 1
                                            ? PatchWidget(
                                                backGroundColor: ColorsConstant.getColorBackground2(widget.colorsValue),
                                                title: "new".tr().toString(),
                                                colorsValue: widget.colorsValue,
                                              )
                                            : Container(
                                                width: 0,
                                              ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              (widget.product!.productsChoices!.isEmpty &&
                                      widget.product!.attributes!.isEmpty &&
                                      "${widget.product!.stock}" == "0")
                                  ? Column(
                                      children: [
                                        CustomText(
                                            text: "outOfStock".tr().toString(),
                                            style: TextStyleConstant.errorText(context, widget.colorsValue)),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                      ],
                                    )
                                  : Container(),
                              (widget.product!.attributes!.isNotEmpty || widget.product!.productsChoices!.isNotEmpty)
                                  ? (widget.product!.attributes != null && widget.product!.attributes!.isNotEmpty)
                                      ? ProductDetailsAttributes(
                                          colorsValue: widget.colorsValue,
                                          theInitialModel: widget.theInitialModel,
                                          product: widget.product,
                                        )
                                      : ProductChoicesNoAttributes(
                                          colorsValue: widget.colorsValue,
                                          theInitialModel: widget.theInitialModel,
                                          product: widget.product,
                                        )
                                  : Container(),
                              SizedBox(
                                height: 2.h,
                              ),
                              widget.product!.trans!.first.productsDesc != null
                                  ? Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                        unselectedWidgetColor: Colors.black87,
                                        colorScheme: const ColorScheme.light(
                                          primary: Colors.black87,
                                        ),
                                      ),
                                      child: ExpansionTile(
                                        childrenPadding: EdgeInsets.zero,
                                        tilePadding: EdgeInsets.zero,
                                        initiallyExpanded: false,
                                        title: Text(
                                          "${"description".tr().toString()}",
                                          style: TextStyleConstant.headerText(context, widget.colorsValue),
                                        ),
                                        children: [
                                          Html(
                                            data: widget.product!.trans!.first.productsDesc ?? "",
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              BlocBuilder<ProductDetailsSliderCubit, ProductDetailsSliderState>(builder: (context, state) {
                                return BlocBuilder<AddToCartCubit, AddToCartState>(
                                  builder: (context, state) {
                                    return ProductDetailsSliderCubit.get(context).atributId != null
                                        ? Text(
                                            '${(ProductDetailsSliderCubit.get(context).atributId != null && (AddToCartCubit.get(context).productChoiceID != null && (widget.product!.productsChoices!.isNotEmpty || widget.product!.attributes!.isEmpty))) ? '' : 'please_select_size'.tr().toString()}',
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : SizedBox();
                                  },
                                );
                              }),
                              Divider(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RatingScreen(
                                                colorsValue: widget.colorsValue,
                                                productId: "${widget.product!.productsId}",
                                              )));
                                },
                                child: SizedBox(
                                  height: 5.h,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${"reviews".tr().toString()}",
                                        style: TextStyleConstant.headerText(context, widget.colorsValue),
                                      ),
                                      Spacer(),
                                      Icon(Icons.chevron_right_rounded),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(),
                              (widget.product!.attributes!.isNotEmpty || widget.product!.productsChoices!.isNotEmpty)
                                  ? SizedBox(
                                      height: 2.h,
                                    )
                                  : Container(),
                              BlocBuilder<ProductDetailsSuggestionCubit, ProductDetailsSuggestionState>(builder: (context, state) {
                                if (state is ProductDetailsSuggestionSuccessState) {
                                  print(ProductDetailsSuggestionCubit.get(context).productDetails.data!.product!.suggestions!.isNotEmpty);
                                  print(ProductDetailsSuggestionCubit.get(context).productDetails.data!.product!.suggestions!.length);
                                  return ProductDetailsSuggestionCubit.get(context).productDetails.data!.product!.suggestions!.isNotEmpty
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CustomText(
                                                  text: "suggestion".tr().toString(),
                                                  style: TextStyleConstant.headerTextMainColor(context, widget.colorsValue)),
                                            ),
                                            ProductGrid(
                                              product:
                                                  ProductDetailsSuggestionCubit.get(context).productDetails.data!.product!.suggestions!,
                                              colorsValue: widget.colorsValue,
                                              theInitialModel: widget.theInitialModel,
                                            ),
                                          ],
                                        )
                                      : Center(
                                          child: Container(),
                                        );
                                } else if (state is ProductDetailsSuggestionInitialState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Container(
                                    color: Colors.red,
                                  );
                                }
                              }),
                              // BlocBuilder<ProductDetailsSuggestionCubit,
                              //         ProductDetailsSuggestionState>(
                              //     builder: (context, state) {
                              //   if (state
                              //       is ProductDetailsSuggestionSuccessState) {
                              //     print(ProductDetailsSuggestionCubit.get(context)
                              //         .productDetails
                              //         .data!
                              //         .product!
                              //         .similarProducts!
                              //         .isNotEmpty);
                              //     print(ProductDetailsSuggestionCubit.get(context)
                              //         .productDetails
                              //         .data!
                              //         .product!
                              //         .similarProducts!
                              //         .length);
                              //     return ProductDetailsSuggestionCubit.get(
                              //                 context)
                              //             .productDetails
                              //             .data!
                              //             .product!
                              //             .similarProducts!
                              //             .isNotEmpty
                              //         ? Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Divider(),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: CustomText(
                              //                     text: "similar".tr().toString(),
                              //                     style: TextStyleConstant
                              //                         .headerTextMainColor(
                              //                             context, colorsValue)),
                              //               ),
                              //               ProductGrid(
                              //                 product:
                              //                     ProductDetailsSuggestionCubit
                              //                             .get(context)
                              //                         .productDetails
                              //                         .data!
                              //                         .product!
                              //                         .similarProducts!,
                              //                 colorsValue: colorsValue,
                              //                 theInitialModel: theInitialModel,
                              //               ),
                              //             ],
                              //           )
                              //         : Container();
                              //   } else if (state
                              //       is ProductDetailsSuggestionInitialState) {
                              //     return Center(
                              //       child: Container(),
                              //     );
                              //   } else {
                              //     return Container(
                              //       color: Colors.red,
                              //     );
                              //   }
                              // }),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
