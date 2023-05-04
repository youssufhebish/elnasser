import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_state.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/image.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsAttributes extends StatelessWidget {
  const ProductDetailsAttributes({Key? key, required this.product, required this.theInitialModel, required this.colorsValue})
      : super(key: key);
  final ProductClass? product;
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsSliderCubit, ProductDetailsSliderState>(
      builder: (context, state) {
        return SizedBox(
          width: SizeDataConstant.fullWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'attributes'.tr().toString(),
                              style: TextStyleConstant.headerText(context, colorsValue),
                            ),
                          ],
                        ),
                      )),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      ProductDetailsSliderCubit.get(context).clearData();
                    },
                    child: CustomText(
                      text: 'clear'.tr().toString(),
                      style: TextStyleConstant.lightText(context, colorsValue),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: SizeDataConstant.fullWidth(context),
                child: Wrap(
                  children: List.generate(
                      product!.attributes!.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: InkWell(
                              onTap: () {
                                ProductDetailsSliderCubit.get(context).getAtributeID(product!.attributes![index].attributesId!);
                                product!.attributes![index].productsChoicesIds!.length == 1
                                    ? ProductDetailsSliderCubit.get(context).getProductChoseIdAtributeNoChoise(
                                        context, product!.attributes![index].productsChoicesIds!.first, product!.productsChoices!)
                                    : null;
                                ProductDetailsSliderCubit.get(context).getSliderAttributeIndex(
                                    index: index,
                                    productsChoicesIdsList: product!.attributes![index].productsChoicesIds!,
                                    productsChoicesImagesIdsList: product!.attributes![index].productsChoicesImages!,
                                    productsChoiceList: product!.productsChoices!,
                                    ProductImagesList: product!.images!.toSet().toList());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: ProductDetailsSliderCubit.get(context).sliderListAttribute == index
                                        ? Border.all(width: 2, color: ColorsConstant.getColorBorder2(colorsValue))
                                        : null,
                                    borderRadius: BorderRadius.circular(6)),
                                width: 40,
                                height: 4.5.h,
                                child: ApiImage(
                                  type: 'thumbnail',
                                  image: product!.attributes![index].attributesImage,
                                  folderName: 'attributes',
                                  borderRadius: 4,
                                  boxFit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )),
                ),
              ),
              SizedBox(
                height: ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList.isNotEmpty ? 2.h : 0,
              ),
              (ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList.isNotEmpty &&
                      ProductDetailsSliderCubit.get(context).haveSize)
                  ? RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'sizes'.tr().toString(),
                            style: TextStyleConstant.headerText(context, colorsValue),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 1.h,
              ),
              ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList.isNotEmpty
                  ? SizedBox(
                      height: ProductDetailsSliderCubit.get(context).haveSize ? 7.h : 0,
                      width: SizeDataConstant.fullWidth(context),
                      child: ListView.builder(
                          itemCount: ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList[index].choices!.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: int.parse(
                                                        "${ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList[index].stock}") >
                                                    0
                                                ? ProductDetailsSliderCubit.get(context).choiceIndexValue == index
                                                    ? ColorsConstant.getColorBackground3(colorsValue)
                                                    : Colors.black
                                                : Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                          onTap: () {
                                            if (int.parse(
                                                    "${ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList[index].stock}") >
                                                0) {
                                              ProductDetailsSliderCubit.get(context).choiceIndex(index);
                                              AddToCartCubit.get(context).getProductChoiceID(
                                                  "${ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList[index].productsChoicesId}");
                                            } else {
                                              DataErrorAlert.NoStock(
                                                  colorValue: colorsValue, context: context, desc: "noStock".tr().toString());
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Row(
                                                children: List.generate(
                                                    ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList[index].choices!.length,
                                                    (index2) => Text(
                                                          " ${ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList[index].choices![index2].trans!.first.choicesTitle.toString()} ",
                                                          style: TextStyle(
                                                              color: int.parse(
                                                                          "${ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList[index].stock}") >
                                                                      0
                                                                  ? ProductDetailsSliderCubit.get(context).choiceIndexValue == index
                                                                      ? ColorsConstant.getColorBackground3(colorsValue)
                                                                      : Colors.black
                                                                  : Colors.grey),
                                                        )),
                                              ),
                                              Text(
                                                " ${ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList[index].productsChoicesPrice ?? ""} ${ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList[index].productsChoicesPrice != null ? SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency : ""}",
                                                style: TextStyle(
                                                    color: int.parse(
                                                                "${ProductDetailsSliderCubit.get(context).ProductsChoiceDisplayList[index].stock}") >
                                                            0
                                                        ? ProductDetailsSliderCubit.get(context).choiceIndexValue == index
                                                            ? ColorsConstant.getColorBackground3(colorsValue)
                                                            : Colors.black
                                                        : Colors.grey),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container();
                          }),
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }
}

class ProductChoicesNoAttributes extends StatelessWidget {
  const ProductChoicesNoAttributes({Key? key, required this.product, required this.theInitialModel, required this.colorsValue})
      : super(key: key);
  final ProductClass? product;
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsSliderCubit, ProductDetailsSliderState>(builder: (context, state) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'sizes'.tr().toString(),
                          style: TextStyleConstant.headerText(context, colorsValue),
                        ),
                      ],
                    ),
                  )),
              const Spacer(),
              InkWell(
                onTap: () {
                  ProductDetailsSliderCubit.get(context).clearData();
                },
                child: CustomText(
                  text: 'clear'.tr().toString(),
                  style: TextStyleConstant.lightText(context, colorsValue),
                ),
              )
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 7.h,
            width: SizeDataConstant.fullWidth(context),
            child: ListView.builder(
                itemCount: product!.productsChoices!.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: int.parse("${product!.productsChoices![index].stock}") > 0
                                ? ProductDetailsSliderCubit.get(context).choiceIndexValue == index
                                    ? ColorsConstant.getColorBackground3(colorsValue)
                                    : Colors.black
                                : Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            if (int.parse("${product!.productsChoices![index].stock}") > 0) {
                              AddToCartCubit.get(context).getProductChoiceID("${product!.productsChoices![index].productsChoicesId}");

                              ProductDetailsSliderCubit.get(context).choiceIndex(index);
                              ProductDetailsSliderCubit.get(context)
                                  .getAttributeImages(product!.images!, product!.productsChoices![index].productsChoicesImages!, index);
                            } else {
                              DataErrorAlert.NoStock(colorValue: colorsValue, context: context, desc: "noStock".tr().toString());
                            }
                          },
                          child: Row(
                            children: [
                              Row(
                                children: List.generate(
                                    product!.productsChoices![index].choices!.length,
                                    (index2) => Text(
                                          " ${product!.productsChoices![index].choices![index2].trans!.first.choicesTitle.toString()} ",
                                          style: TextStyle(
                                              color: int.parse("${product!.productsChoices![index].stock}") > 0
                                                  ? ProductDetailsSliderCubit.get(context).choiceIndexValue == index
                                                      ? ColorsConstant.getColorBackground3(colorsValue)
                                                      : Colors.black
                                                  : Colors.grey),
                                        )),
                              ),
                              Text(
                                " ${product!.productsChoices![index].productsChoicesPrice ?? ""} ${product!.productsChoices![index].productsChoicesPrice != null ? SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency : ""}",
                                style: TextStyle(
                                    color: int.parse("${product!.productsChoices![index].stock}") > 0
                                        ? ProductDetailsSliderCubit.get(context).choiceIndexValue == index
                                            ? ColorsConstant.getColorBackground3(colorsValue)
                                            : Colors.black
                                        : Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      );
    });
  }
}
