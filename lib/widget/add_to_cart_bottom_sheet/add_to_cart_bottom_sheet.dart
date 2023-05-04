import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/home_model/product_images_list.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_state.dart';
import 'package:elnasser/screens/product_details/widget/prdouct_details_atributes.dart';
import 'package:elnasser/screens/rating/rating_screen.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../alert.dart';
import '../app_button.dart';
import '../image.dart';
import '../patch_widget.dart';
import '../text_widget.dart';

class AddToCartBottomSheet extends StatelessWidget {
  AddToCartBottomSheet(
      {Key? key,
      required this.product,
      required this.theInitialModel,
      required this.colorsValue,
      required this.productImage,
      required this.attributeProductsChoice,
      required this.attribute,
      required this.images})
      : super(key: key);
  final ProductClass? product;
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;
  final List<ProductImagesList> images;
  final List<AttributeElement>? attribute;
  final List<ProductsChoice>? attributeProductsChoice;
  final String? productImage;
  List<String> sliderList = [];
  @override
  Widget build(BuildContext context) {
    if (productImage != null) {
      sliderList.add(productImage!);
    }
    images.forEach((element) {
      sliderList.add(element.productsImagesName!);
    });

    String? categorySeriousTitle = "";

    product?.categorySeries?.forEach((element) {
      categorySeriousTitle = categorySeriousTitle! + " -> " + element.trans!.first.categoriesTitle!;
    });
    return DraggableScrollableSheet(
      initialChildSize: .6,
      maxChildSize: .9,
      minChildSize: .5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          child: SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),

                    /// After change V002
                    BlocBuilder<ProductDetailsSliderCubit, ProductDetailsSliderState>(
                      builder: (context, state) {
                        return SizedBox(
                          height: 15.h,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: ProductDetailsSliderCubit.get(context).sliderListAttribute == -1
                                  ? sliderList.length
                                  : ProductDetailsSliderCubit.get(context).ProductImagesDisplayList.length == 0
                                      ? 1
                                      : ProductDetailsSliderCubit.get(context).ProductImagesDisplayList.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: SizedBox(
                                    width: SizeDataConstant.customWidth(context, 4),
                                    child: ApiImage(
                                      folderName: "products",
                                      type: "original",
                                      image: ProductDetailsSliderCubit.get(context).sliderListAttribute == -1
                                          ? sliderList[index]
                                          : ProductDetailsSliderCubit.get(context).ProductImagesDisplayList.length != 0
                                              ? ProductDetailsSliderCubit.get(context).ProductImagesDisplayList[index].productsImagesName
                                              : productImage,
                                      borderRadius: 0,
                                    ),
                                  ),
                                );
                              }),
                        );
                      },
                    ),

                    ///
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //         flex: 3,
                    //         child: CustomText(
                    //           text: categorySeriousTitle!.replaceFirst(" -> ", ""),
                    //           style: TextStyle(),
                    //         )),
                    //     const Spacer(),
                    //     InkWell(
                    //       onTap: (){
                    //         Navigator.push(context, MaterialPageRoute(builder: (context)=> RatingScreen(colorsValue:colorsValue,productId: "${product!.productsId}",)));
                    //
                    //       },
                    //       child: RatingBar.builder(
                    //         ignoreGestures: true,
                    //         initialRating: double.parse("${product!.productsRating}"),
                    //         minRating: 1,
                    //         direction: Axis.horizontal,
                    //         allowHalfRating: true,
                    //         itemCount: 5,
                    //         itemSize: 18,
                    //         glow: false,
                    //         itemPadding:
                    //             const EdgeInsets.symmetric(horizontal: 1),
                    //         itemBuilder: (context, _) => const Icon(
                    //           Icons.star,
                    //           color: Colors.amber,
                    //         ),
                    //         onRatingUpdate: (rating) {
                    //           // print(rating);
                    //         },
                    //       ),
                    //     ),
                    //     SizedBox(width: 2.w,)
                    //   ],
                    // ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomText(
                              text: product?.trans!.first.productsTitle, style: TextStyleConstant.bodyText(context, colorsValue)),
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
                                          colorsValue: colorsValue,
                                          productId: "${product!.productsId}",
                                        )));
                          },
                          child: RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: double.parse("${product!.productsRating}"),
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
                            text: "( ${product!.productsRating} )",
                            style: TextStyle(color: Color(0xffD8B836), fontSize: Responsive.isMobile(context) ? 14 : 16)),
                        Spacer(),
                        SizedBox(
                          height: 2.h,
                          width: 3.h,
                          child: ImageView(
                            path: ImageConstants.pointGift,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 3.8.h,
                          child: Column(
                            children: [
                              Spacer(),
                              CustomText(
                                  text: "${product?.productsPoints} ${"point".tr().toString()}",
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
                        (product!.offer != null &&
                                (product!.offer!.offersAdditionalNumber != null ? false : true) &&
                                (product!.offer!.offersMainNumber != null ? int.parse("${product!.offer?.offersMainNumber}") == 1 : false))
                            ? RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: ' ${product!.productsPrice}',
                                      style: TextStyleConstant.cardProductPriceDiscountTextStyle(context, colorsValue),
                                    ),
                                    TextSpan(
                                      text:
                                          "    ${(int.parse("${product!.productsPrice}") - ((int.parse("${product!.productsPrice}") / 100) * int.parse("${product!.offer!.offersDiscount}"))).toStringAsFixed(2)} ${theInitialModel.data?.setting!.settingsCurrency}",
                                      style: TextStyleConstant.cardProductPriceTextStyle(context, colorsValue),
                                    ),
                                  ],
                                ),
                              )
                            : CustomText(
                                text: '${theInitialModel.data?.setting!.settingsCurrency} ${product!.productsPrice}',
                                style: TextStyleConstant.cardProductPriceTextStyle(context, colorsValue),
                              ),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.start,
                            children: [
                              product!.offer != null
                                  ? ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: SizeDataConstant.mopCardWidth(context) - 50),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: ColorsConstant.getColorBackground3(colorsValue),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CustomText(
                                              text: "${product!.offer!.trans!.first.offersTitle}",
                                              maxLie: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyleConstant.whiteTextPatch(context, colorsValue)),
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
                              product!.mostWanted == 1
                                  ? PatchWidget(
                                      backGroundColor: ColorsConstant.getColorBackground1(colorsValue),
                                      title: "bestSeller".tr().toString(),
                                      colorsValue: colorsValue,
                                    )
                                  : Container(
                                      width: 0,
                                    ),
                              const SizedBox(
                                height: 4,
                              ),
                              product!.isNew == 1
                                  ? PatchWidget(
                                      backGroundColor: ColorsConstant.getColorBackground2(colorsValue),
                                      title: "new".tr().toString(),
                                      colorsValue: colorsValue,
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
                    (product!.attributes!.isNotEmpty || product!.productsChoices!.isNotEmpty)
                        ? (product!.attributes != null && product!.attributes!.isNotEmpty)
                            ? ProductDetailsAttributes(
                                colorsValue: colorsValue,
                                theInitialModel: theInitialModel,
                                product: product,
                              )
                            : ProductChoicesNoAttributes(
                                colorsValue: colorsValue,
                                theInitialModel: theInitialModel,
                                product: product,
                              )
                        : Container(),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocBuilder<ProductDetailsSliderCubit, ProductDetailsSliderState>(builder: (context, state) {
                      return BlocBuilder<AddToCartCubit, AddToCartState>(
                        builder: (context, state) {
                          return ProductDetailsSliderCubit.get(context).atributId != null
                              ? Text(
                                  '${(ProductDetailsSliderCubit.get(context).atributId != null && (AddToCartCubit.get(context).productChoiceID != null && (product!.productsChoices!.isNotEmpty || product!.attributes!.isEmpty))) ? '' : 'please_select_size'}',
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox();
                        },
                      );
                    }),
                    SizedBox(
                      height: 1.h,
                    ),

                    Row(
                      children: [
                        BlocConsumer<AddToCartCubit, AddToCartState>(
                          builder: (context, state) {
                            print(AddToCartCubit.get(context).productChoiceID);
                            print(state);

                            return Center(
                                child: product!.productsChoices!.isNotEmpty && product!.attributes!.isNotEmpty
                                    ? AppButton(
                                        disable: (AddToCartCubit.get(context).productChoiceID != null &&
                                                (product!.productsChoices!.isNotEmpty || product!.attributes!.isEmpty))
                                            ? false
                                            : true,
                                        // disable: ProductDetailsSliderCubit.get(context).attributeChoiceValue ==-1 ,
                                        widthRatio: 1.6,
                                        colorsInitialValue: colorsValue,
                                        textStyle: TextStyleConstant.whiteText(context, colorsValue),
                                        title: 'addToCart'.tr().toString(),
                                        color: ColorsConstant.getColorBackground3(colorsValue),
                                        onPressed: () {
                                          print("Stop Order ${SplashCubit.get(context).theInitialModel.data!.setting!.stopOrder}");
                                          if (SplashCubit.get(context).theInitialModel.data!.setting!.stopOrder == "0") {
                                            DataErrorAlert.showError(
                                                data: SplashCubit.get(context).theInitialModel.data!.setting!.stopOrderMsg!,
                                                title: "",
                                                colorValue: colorsValue,
                                                context: context);
                                          } else {
                                            print('ID: ${AddToCartCubit.get(context).productChoiceID}');
                                            AddToCartCubit.get(context)
                                                .addToCartApi(productId: product!.productsId!, context: context, inCart: false);
                                          }
                                        },
                                      )
                                    : product!.attributes!.isEmpty && product!.productsChoices!.isNotEmpty
                                        ? AppButton(
                                            // disable:  (AddToCartCubit.get(context).productChoiceID != null && (product!.productsChoices!.isNotEmpty || product!.attributes!.isEmpty )) ? false: true ,
                                            disable: AddToCartCubit.get(context).productChoiceID == null,
                                            colorsInitialValue: colorsValue,
                                            widthRatio: 1.6,
                                            textStyle: TextStyleConstant.whiteText(context, colorsValue),
                                            title: 'addToCart'.tr().toString(),
                                            color: ColorsConstant.getColorBackground3(colorsValue),
                                            onPressed: () {
                                              print("Stop Order ${SplashCubit.get(context).theInitialModel.data!.setting!.stopOrder}");
                                              if (SplashCubit.get(context).theInitialModel.data!.setting!.stopOrder == "0") {
                                                DataErrorAlert.showError(
                                                    data: SplashCubit.get(context).theInitialModel.data!.setting!.stopOrderMsg!,
                                                    title: "",
                                                    colorValue: colorsValue,
                                                    context: context);
                                              } else {
                                                print('ID: ${AddToCartCubit.get(context).productChoiceID}');
                                                AddToCartCubit.get(context)
                                                    .addToCartApi(productId: product!.productsId!, context: context, inCart: false);
                                              }
                                            },
                                          )
                                        : AppButton(
                                            // disable:  (AddToCartCubit.get(context).productChoiceID != null && (product!.productsChoices!.isNotEmpty || product!.attributes!.isEmpty )) ? false: true ,
                                            // disable: (product!.productsChoices!.isEmpty && product!.attributes!.isEmpty )?false:(AddToCartCubit.get(context).productChoiceID != null && (product!.productsChoices!.isNotEmpty || product!.attributes!.isEmpty ))? false: true ,
                                            colorsInitialValue: colorsValue,
                                            widthRatio: 1.6,
                                            textStyle: TextStyleConstant.whiteText(context, colorsValue),
                                            title: 'addToCart'.tr().toString(),
                                            color: ColorsConstant.getColorBackground3(colorsValue),
                                            onPressed: () {
                                              print("Stop Order ${SplashCubit.get(context).theInitialModel.data!.setting!.stopOrder}");
                                              if (SplashCubit.get(context).theInitialModel.data!.setting!.stopOrder == "0") {
                                                DataErrorAlert.showError(
                                                    title: "",
                                                    data: SplashCubit.get(context).theInitialModel.data!.setting!.stopOrderMsg!,
                                                    colorValue: colorsValue,
                                                    context: context);
                                              } else {
                                                print('ID: ${AddToCartCubit.get(context).productChoiceID}');
                                                AddToCartCubit.get(context)
                                                    .addToCartApi(productId: product!.productsId!, context: context, inCart: false);
                                              }
                                            },
                                          ));
                          },
                          listener: (context, state) {
                            if (state is AddToCartStateSuccess || state is CartStateDeleteSuccess) {
                              AddToCartCubit.get(context).resetData();
                              ProductDetailsSliderCubit.get(context).clearData();

                              AddToCartCubit.get(context).getCart(context: context);
                            } else if (state is AddToCartStateNoStock) {
                              DataErrorAlert.NoStock(
                                  colorValue: colorsValue, desc: AddToCartCubit.get(context).errorModel.errors!.first, context: context);
                            }
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        BlocBuilder<AddToCartCubit, AddToCartState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                Container(
                                    color: ColorsConstant.getColorBackground5(colorsValue),
                                    height: 6.h,
                                    child: IconButton(
                                      splashColor: ColorsConstant.getColorBackground3(colorsValue),
                                      onPressed: () {
                                        AddToCartCubit.get(context).getProductCountAdd();
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: ColorsConstant.getColorBackground3(colorsValue),
                                      ),
                                    )),
                                Container(
                                    height: 6.h,
                                    color: ColorsConstant.getColorBackground5(colorsValue),
                                    child: Center(
                                        child: CustomText(
                                            text: "${AddToCartCubit.get(context).productCount}",
                                            style: TextStyleConstant.bodyText(context, colorsValue)))),
                                Container(
                                    height: 6.h,
                                    color: ColorsConstant.getColorBackground5(colorsValue),
                                    child: IconButton(
                                      splashColor: ColorsConstant.getColorBackground3(colorsValue),
                                      onPressed: () {
                                        AddToCartCubit.get(context).getProductCountMinus();
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        color: ColorsConstant.getColorBackground3(colorsValue),
                                      ),
                                    )),
                              ],
                            );
                          },
                          buildWhen: (prev, current) {
                            if (current is AddToCartStateGetAmountMinus || current is AddToCartStateGetAmountAdd) {
                              return true;
                            } else {
                              return false;
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
