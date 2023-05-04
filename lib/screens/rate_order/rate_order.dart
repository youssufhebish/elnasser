import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/models/order_model/order_model_detail.dart';
import 'package:elnasser/models/rating/get_rating.dart';
import 'package:elnasser/screens/rate_order/ratin_oredr_bloc/rating_order_bloc.dart';
import 'package:elnasser/screens/rate_order/ratin_oredr_bloc/rating_order_state.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/image.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class RatingOrder extends StatefulWidget {
  RatingOrder(
      {Key? key,
      required this.colorsValue,
      required this.orderModelDetail,
      this.edit = false,
      this.productRating})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final Order orderModelDetail;
  List<RatingProduct>? productRating;

  bool edit;
  @override
  State<RatingOrder> createState() => _RatingOrderState();
}

class _RatingOrderState extends State<RatingOrder> {
  @override
  void initState() {
    // TODO: implement initState
    if (widget.edit == true) {
      RatingOrderCubit.get(context).getEditData(
          items: widget.orderModelDetail.items!,
          productRating: widget.productRating!,
          orderDetailsRating: widget.orderModelDetail.orderDetailsRating!);
      RatingOrderCubit.get(context)
          .generateController(widget.orderModelDetail.items!.length);
    } else {
      // RatingOrderCubit.get(context).clearData();

      RatingOrderCubit.get(context)
          .RateProduct(widget.orderModelDetail.items!.length);
      RatingOrderCubit.get(context)
          .generateController(widget.orderModelDetail.items!.length);
    }

    super.initState();
  }

  List<int> ids = [];
  @override
  Widget build(BuildContext context) {
    ids.clear();
    widget.orderModelDetail.items!.forEach((element) {
      if (!ids.contains(element.product!.productsId)) {
        ids.add(element.product!.productsId!);
      } else {
        ids.add(-1);
      }
    });

    for (int x in ids) {
      if (x == -1) {
        widget.orderModelDetail.items!.removeAt(ids.indexOf(x));
      }
    }
    print(ids);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              BlocConsumer<RatingOrderCubit, RatingOrderState>(
            builder: (context, state) {
              print("Rate State $state");
              return AppButton(
                  radius: 0,
                  widthRatio: 1,
                  colorsInitialValue: widget.colorsValue,
                  color: ColorsConstant.getColorBackground3(widget.colorsValue),
                  textStyle:
                      TextStyleConstant.buttonText(context, widget.colorsValue),
                  title: "submit".tr().toString(),
                  onPressed: () {
                    if (RatingOrderCubit.get(context).shoppingRate == 0.0 ||
                        RatingOrderCubit.get(context).deliveryRate == 0.0) {
                      DataErrorAlert.MissingRateMessageOrder(
                          context: context, colorValue: widget.colorsValue);
                    } else {
                      RatingOrderCubit.get(context).submitRate(
                          items: widget.orderModelDetail.items!,
                          context: context,
                          colorValue: widget.colorsValue,
                          orderId: widget.orderModelDetail.ordersId!);
                    }
                  });
            },
            listener: (context, state) {
              if (state is RatingOrderStateSubmitSuccess) {
                DataErrorAlert.rateSuccess(
                    colorValue: widget.colorsValue, context: context);
              }
            },
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: CustomText(
              text: "addRating".tr().toString(),
              style: TextStyleConstant.headerText(context, widget.colorsValue),
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
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                      child: CustomText(
                          text:
                              "${"code".tr().toString()}:${widget.orderModelDetail.ordersNo}",
                          style: TextStyleConstant.headerTextLargeBlack(
                              context, widget.colorsValue))),
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                      child: CustomText(
                          text:
                              "thankYouForYourPurchaseAndForYourThoughtfulReview"
                                  .tr()
                                  .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyleConstant.bodyTextMainColor(
                              context, widget.colorsValue))),
                  SizedBox(
                    height: 2.h,
                  ),
                  RatingWidget(
                    colorsValue: widget.colorsValue,
                    rate: RatingOrderCubit.get(context).shoppingRate,
                    title: 'ratingShopping'.tr().toString(),
                    getRating: (double rating) {
                      RatingOrderCubit.get(context).getShoppingRate(rating);
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  RatingWidget(
                    colorsValue: widget.colorsValue,
                    rate: RatingOrderCubit.get(context).deliveryRate,
                    title: 'ratingDelivery'.tr().toString(),
                    getRating: (double rating) {
                      RatingOrderCubit.get(context).getDeliveryRate(rating);
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                      child: AppTextFiled(
                    password: false,
                    validation: null,
                    hintText: "orderComment".tr().toString(),
                    nextNode: null,
                    controller: RatingOrderCubit.get(context).rateNote,
                    inputType: TextInputType.text,
                    labelText: "ratingNote".tr().toString(),
                    node: null,
                    validationWidget: Container(),
                    colorsInitialValue: widget.colorsValue,
                    maxLines: 2,
                  )),
                  Divider(),
                  CustomText(
                      text: "products".tr().toString(),
                      style: TextStyleConstant.headerTextMainColor(
                          context, widget.colorsValue)),
                  BlocConsumer<RatingOrderCubit, RatingOrderState>(
                      builder: (context, state) {
                        return ListView.builder(
                            itemCount: widget.orderModelDetail.items!
                                .toSet()
                                .toList()
                                .length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 12.h,
                                      width:
                                          SizeDataConstant.fullWidth(context),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: ApiImage(
                                                type: "medium",
                                                folderName: "products",
                                                image: widget
                                                    .orderModelDetail
                                                    .items![index]
                                                    .product!
                                                    .productsImg),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Center(
                                                  child: CustomText(
                                                      text: widget
                                                          .orderModelDetail
                                                          .items![index]
                                                          .product!
                                                          .trans!
                                                          .first
                                                          .productsTitle,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyleConstant
                                                          .bodyTextMainColor(
                                                              context,
                                                              widget
                                                                  .colorsValue)))),
                                          Expanded(
                                            flex: 3,
                                            child: AppButton(
                                                colorsInitialValue:
                                                    widget.colorsValue,
                                                color: ColorsConstant
                                                    .getColorBackground3(
                                                        widget.colorsValue),
                                                textStyle: TextStyleConstant
                                                    .buttonText(context,
                                                        widget.colorsValue),
                                                title: RatingOrderCubit.get(
                                                                    context)
                                                                .showProductRating[
                                                            index] ==
                                                        false
                                                    ? "rateNow".tr().toString()
                                                    : "cancel".tr().toString(),
                                                onPressed: () {
                                                  setState(() {
                                                    RatingOrderCubit.get(
                                                                context)
                                                            .showProductRating[
                                                        index] = !RatingOrderCubit
                                                                .get(context)
                                                            .showProductRating[
                                                        index];
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                    ColoredContainer(
                                      index: index,
                                      isContainerVisible:
                                          RatingOrderCubit.get(context)
                                              .showProductRating[index],
                                      colorsValue: widget.colorsValue,
                                      textEditingController:
                                          RatingOrderCubit.get(context)
                                              .controller[index],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      listener: (context, state) {}),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  RatingWidget(
      {Key? key,
      required this.colorsValue,
      required this.title,
      required this.getRating,
      required this.rate,
      this.itemSize = 40})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String title;
  final Function getRating;
  final double rate;
  double? itemSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: SizeDataConstant.fullWidth(context),
            child: Wrap(
              children: [
                CustomText(
                  text: "$title",
                  style: TextStyleConstant.headerText(context, colorsValue),
                ),
                RatingBar.builder(
                  ignoreGestures: false,
                  initialRating: rate,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: itemSize!,
                  glow: false,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // print(rating);
                    getRating(rating);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ColoredContainer extends StatelessWidget {
  ColoredContainer(
      {required this.isContainerVisible,
      required this.colorsValue,
      required this.textEditingController,
      required this.index,
      this.edit = false});
  final bool isContainerVisible;
  final ColorsInitialValue colorsValue;
  final TextEditingController textEditingController;
  final int index;
  bool edit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingOrderCubit, RatingOrderState>(
        builder: (context, state) {
      return Center(
          child: isContainerVisible == true
              ? AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  // height: isContainerVisible ? 30.h: 0.0,
                  // width: isContainerVisible ? SizeDataConstant.fullWidth(context) : 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingWidget(
                        getRating: (double rating) {
                          print(index);
                          print(index);
                          RatingOrderCubit.get(context)
                              .getQuality(rating, index);
                        },
                        rate: RatingOrderCubit.get(context).quality.isNotEmpty
                            ? RatingOrderCubit.get(context).quality[index]
                            : 0,
                        title: 'productQuality'.tr().toString(),
                        colorsValue: colorsValue,
                        itemSize: 30,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      RatingWidget(
                        getRating: (double rating) {
                          RatingOrderCubit.get(context).getSize(rating, index);
                        },
                        rate: RatingOrderCubit.get(context).size.isNotEmpty
                            ? RatingOrderCubit.get(context).size[index]
                            : 0,
                        title: 'productSize'.tr().toString(),
                        colorsValue: colorsValue,
                        itemSize: 30,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      RatingWidget(
                        getRating: (double rating) {
                          RatingOrderCubit.get(context).getPrice(rating, index);
                        },
                        rate: RatingOrderCubit.get(context).price.isNotEmpty
                            ? RatingOrderCubit.get(context).price[index]
                            : 0,
                        title: 'productPrice'.tr().toString(),
                        colorsValue: colorsValue,
                        itemSize: 30,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      RatingWidget(
                        getRating: (double rating) {
                          RatingOrderCubit.get(context).getMatch(rating, index);
                        },
                        rate: RatingOrderCubit.get(context).match.isNotEmpty
                            ? RatingOrderCubit.get(context).match[index]
                            : 0,
                        title: 'productMatch'.tr().toString(),
                        colorsValue: colorsValue,
                        itemSize: 30,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "ratingNote".tr().toString(),
                          style: TextStyleConstant.headerText(
                              context, colorsValue),
                        ),
                      ),
                      Center(
                          child: AppTextFiled(
                        password: false,
                        validation: null,
                        hintText: "ratingNote".tr().toString(),
                        nextNode: null,
                        controller: textEditingController,
                        inputType: TextInputType.text,
                        labelText: "ratingNote".tr().toString(),
                        node: null,
                        validationWidget: Container(),
                        colorsInitialValue: colorsValue,
                        maxLines: 2,
                      )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Divider(),
                    ],
                  ),
                )
              : Container());
    });
  }
}
