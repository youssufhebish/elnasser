import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/rating/add_rating.dart';
import 'package:elnasser/screens/rating/rating_bloc/rating_bloc.dart';
import 'package:elnasser/screens/rating/rating_bloc/rating_bloc_state.dart';
import 'package:elnasser/screens/rating/rating_bloc/rating_event.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingScreen extends StatefulWidget {
  RatingScreen({Key? key, required this.colorsValue, required this.productId})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String productId;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double fiveStar = 0.0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    context.read<RatingBloc>()..emit(RatingBlocState(context: context));
    context.read<RatingBloc>()..add(RatingFetch(orderID: widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Product ID ${widget.productId}');
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: CustomText(
              text: "rating".tr().toString(),
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
            physics: NeverScrollableScrollPhysics(),
            child: BlocConsumer<RatingBloc, RatingBlocState>(
                // buildWhen: (prev,current)=> current.status== RatingBlocStatus.success,
                builder: (context, state) {
              print("Rating  ${state.status}");
              if (state.status == RatingBlocStatus.success &&
                  state.ratingList.isNotEmpty) {
                print('Allow ${state.ratingModel.data!.allowRating}');

                return Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: 11.h,
                              width: 11.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 4,
                                      color: ColorsConstant.getColorBackground3(
                                          widget.colorsValue))),
                              child: Center(
                                  child: CustomText(
                                text:
                                    "${state.ratingModel.data!.productRating}",
                                style: TextStyleConstant.headerTextMainColor(
                                    context, widget.colorsValue),
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomText(
                              text:
                                  "${"baseOn".tr().toString()}: ${state.ratingModel.data!.allReviews}",
                              style: TextStyleConstant.bodyTextGrey(
                                  context, widget.colorsValue)),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: double.parse(
                                    "${state.ratingModel.data!.productRating}"),
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 18,
                                glow: false,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // print(rating);
                                },
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "5 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(
                                                    context,
                                                    (state.ratingModel.data!
                                                            .allReviews! /
                                                        state.ratingModel.data!
                                                            .fiveStar!)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground3(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text:
                                            "${state.ratingModel.data!.fiveStar!}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "4 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(
                                                    context,
                                                    (state.ratingModel.data!
                                                            .allReviews! /
                                                        state.ratingModel.data!
                                                            .fourStar!)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground3(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text:
                                            "${state.ratingModel.data!.fourStar!}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "3 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(
                                                    context,
                                                    (state.ratingModel.data!
                                                            .allReviews! /
                                                        state.ratingModel.data!
                                                            .threeStar!)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground3(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text:
                                            "${state.ratingModel.data!.threeStar!}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "2 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(
                                                    context,
                                                    (state.ratingModel.data!
                                                            .allReviews! /
                                                        state.ratingModel.data!
                                                            .twoStar!)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground3(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text:
                                            "${state.ratingModel.data!.twoStar!}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "1 ${"star".tr().toString()}  ",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(
                                                    context,
                                                    (state.ratingModel.data!
                                                            .allReviews! /
                                                        state.ratingModel.data!
                                                            .oneStar!)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground3(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text:
                                            "${state.ratingModel.data!.oneStar!}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                      child: SmartRefresher(
                        physics: BouncingScrollPhysics(),
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropHeader(),
                        footer: CustomFooter(
                          builder: (context, mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = state.hasReachedMax == true
                                  ? Container()
                                  : Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.5));
                            } else if (mode == LoadStatus.loading) {
                              body = Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1.5));
                            } else if (mode == LoadStatus.failed) {
                              body = Text("Load Failed!Click retry!");
                            } else {
                              body = Text("No more Data");
                            }
                            return Container(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        controller: _refreshController,
                        onRefresh: () async {
                          context
                              .read<RatingBloc>()
                              .add(RatingReset(orderID: widget.productId));
                          await Future.delayed(Duration(seconds: 4));

                          _refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await Future.delayed(Duration(seconds: 0));
                          context
                              .read<RatingBloc>()
                              .add(RatingFetch(orderID: widget.productId));

                          _refreshController.loadComplete();
                        },
                        child: state.status == RatingBlocStatus.success
                            ? state.ratingList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: state.ratingList.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: ColorsConstant
                                                          .getColorBackground5(
                                                              widget
                                                                  .colorsValue)))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomText(
                                                          text:
                                                              "${state.ratingList[index].customer!.customersName}",
                                                          style: TextStyleConstant
                                                              .bodyTextMainColorRate(
                                                                  context,
                                                                  widget
                                                                      .colorsValue)),
                                                    ),
                                                    CustomText(
                                                        text:
                                                            "${SharedMethods.convertDate("${state.ratingList[index].ratingsCreatedAt}")}",
                                                        style: TextStyleConstant
                                                            .bodyTextGreyDate(
                                                                context,
                                                                widget
                                                                    .colorsValue)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    RatingBar.builder(
                                                      ignoreGestures: true,
                                                      initialRating: double.parse(
                                                          "${state.ratingList[index].ratingsValue}"),
                                                      minRating: 0,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 18,
                                                      glow: false,
                                                      itemPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 1.0),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
// print(rating);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                (state.ratingList[index]
                                                                .ratingsText !=
                                                            null &&
                                                        state
                                                            .ratingList[index]
                                                            .ratingsText!
                                                            .isNotEmpty)
                                                    ? CustomText(
                                                        text:
                                                            "${state.ratingList[index].ratingsText}"
                                                                .replaceAll(
                                                                    "null", ""),
                                                        style: TextStyle())
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Container()
                            : state.status == RatingBlocStatus.initial
                                ? Center(child: CircularProgressIndicator())
                                : state.status == RatingBlocStatus.refresh
                                    ? Center(child: CircularProgressIndicator())
                                    : Center(child: Text("Errro")),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 6.h,
                      child: AppButton(
                          // disable: state.ratingModel.data!.allowRating! < 1,
                          colorsInitialValue: widget.colorsValue,
                          color: ColorsConstant.getColorBackground3(
                              widget.colorsValue),
                          textStyle: TextStyleConstant.buttonText(
                              context, widget.colorsValue),
                          title: "rateNow".tr().toString(),
                          onPressed: () {
                            if (state.ratingModel.data!.allowRating! < 1) {
                              DataErrorAlert.RateMessage(
                                  context: context,
                                  colorValue: widget.colorsValue);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddRating(
                                          colorsValue: widget.colorsValue,
                                          orderId: widget.productId)));
                            }
                          }),
                    ),
                  ],
                );
              } else if (state.status == RatingBlocStatus.success &&
                  state.ratingList.isEmpty) {
                return Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: 11.h,
                              width: 11.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 4,
                                      color: ColorsConstant.getColorBackground3(
                                          widget.colorsValue))),
                              child: Center(
                                  child: CustomText(
                                text: "0.0",
                                style: TextStyleConstant.headerTextMainColor(
                                    context, widget.colorsValue),
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomText(
                              text: "${"baseOn".tr().toString()}: 0.0",
                              style: TextStyleConstant.bodyTextGrey(
                                  context, widget.colorsValue)),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: 0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 18,
                                glow: false,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // print(rating);
                                },
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "5 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(context, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: "0",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "4 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(context, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: "0",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "3 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(context, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: "0",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "2 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(context, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: "0",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "1 ${"star".tr().toString()}   ",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(context, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: "0",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                      child: SmartRefresher(
                        physics: BouncingScrollPhysics(),
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropHeader(),
                        footer: CustomFooter(
                          builder: (context, mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = state.hasReachedMax == true
                                  ? Container()
                                  : Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.5));
                            } else if (mode == LoadStatus.loading) {
                              body = Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1.5));
                            } else if (mode == LoadStatus.failed) {
                              body = Text("Load Failed!Click retry!");
                            } else {
                              body = Text("No more Data");
                            }
                            return Container(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        controller: _refreshController,
                        onRefresh: () async {
                          context
                              .read<RatingBloc>()
                              .add(RatingReset(orderID: widget.productId));
                          await Future.delayed(Duration(seconds: 4));

                          _refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await Future.delayed(Duration(seconds: 0));
                          context
                              .read<RatingBloc>()
                              .add(RatingFetch(orderID: widget.productId));

                          _refreshController.loadComplete();
                        },
                        child: state.status == RatingBlocStatus.success
                            ? state.ratingList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: state.ratingList.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: ColorsConstant
                                                          .getColorBackground5(
                                                              widget
                                                                  .colorsValue)))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomText(
                                                          text:
                                                              "${state.ratingList[index].customer!.customersName}",
                                                          style: TextStyleConstant
                                                              .headerTextMainColor(
                                                                  context,
                                                                  widget
                                                                      .colorsValue)),
                                                    ),
                                                    CustomText(
                                                        text:
                                                            "${SharedMethods.convertDate("${state.ratingList[index].ratingsCreatedAt}")}",
                                                        style: TextStyleConstant
                                                            .lightText(
                                                                context,
                                                                widget
                                                                    .colorsValue)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    RatingBar.builder(
                                                      ignoreGestures: true,
                                                      initialRating: double.parse(
                                                          "${state.ratingList[index].ratingsValue}"),
                                                      minRating: 0,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 18,
                                                      glow: false,
                                                      itemPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 1.0),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
// print(rating);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                (state.ratingList[index]
                                                                .ratingsText !=
                                                            null &&
                                                        state
                                                            .ratingList[index]
                                                            .ratingsText!
                                                            .isNotEmpty)
                                                    ? CustomText(
                                                        text:
                                                            "${state.ratingList[index].ratingsText}"
                                                                .replaceAll(
                                                                    "null", ""),
                                                        style: TextStyleConstant
                                                            .bodyTextSmall(
                                                                context,
                                                                widget
                                                                    .colorsValue))
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Container()
                            : state.status == RatingBlocStatus.initial
                                ? Center(child: CircularProgressIndicator())
                                : state.status == RatingBlocStatus.refresh
                                    ? Center(child: Container())
                                    : Center(child: Text("Errro")),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 6.h,
                      child: AppButton(
                          // disable: state.ratingModel.data!.allowRating! < 1,
                          colorsInitialValue: widget.colorsValue,
                          color: ColorsConstant.getColorBackground3(
                              widget.colorsValue),
                          textStyle: TextStyleConstant.buttonText(
                              context, widget.colorsValue),
                          title: "rateNow".tr().toString(),
                          onPressed: () {
                            if (state.ratingModel.data!.allowRating! < 1) {
                              DataErrorAlert.RateMessage(
                                  context: context,
                                  colorValue: widget.colorsValue);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddRating(
                                          colorsValue: widget.colorsValue,
                                          orderId: widget.productId)));
                            }
                          }),
                    ),
                  ],
                );
              } else if (state.status == RatingBlocStatus.refresh &&
                  state.ratingList.isEmpty) {
                return Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: 11.h,
                              width: 11.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 4,
                                      color: ColorsConstant.getColorBackground3(
                                          widget.colorsValue))),
                              child: Center(
                                  child: CustomText(
                                text: "0.0",
                                style: TextStyleConstant.headerTextMainColor(
                                    context, widget.colorsValue),
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomText(
                              text: "${"baseOn".tr().toString()}: 0.0",
                              style: TextStyleConstant.bodyTextGrey(
                                  context, widget.colorsValue)),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: 0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 18,
                                glow: false,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // print(rating);
                                },
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "5 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(context, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: "0",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "4 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(context, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: "0",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "3 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(context, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: "0",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "2 ${"stars".tr().toString()}",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(context, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: "0",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 4),
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: "1 ${"star".tr().toString()}   ",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant.fullWidth(
                                                context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: SizeDataConstant
                                                .customWidthRate(context, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorsConstant
                                                    .getColorBackground5(
                                                        widget.colorsValue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: "0",
                                        style: TextStyleConstant.bodyTextSmall(
                                            context, widget.colorsValue)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                      child: SmartRefresher(
                        physics: BouncingScrollPhysics(),
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropHeader(),
                        footer: CustomFooter(
                          builder: (context, mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = state.hasReachedMax == true
                                  ? Container()
                                  : Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.5));
                            } else if (mode == LoadStatus.loading) {
                              body = Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1.5));
                            } else if (mode == LoadStatus.failed) {
                              body = Text("Load Failed!Click retry!");
                            } else {
                              body = Text("No more Data");
                            }
                            return Container(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        controller: _refreshController,
                        onRefresh: () async {
                          context
                              .read<RatingBloc>()
                              .add(RatingReset(orderID: widget.productId));
                          await Future.delayed(Duration(seconds: 4));

                          _refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await Future.delayed(Duration(seconds: 0));
                          context
                              .read<RatingBloc>()
                              .add(RatingFetch(orderID: widget.productId));

                          _refreshController.loadComplete();
                        },
                        child: state.status == RatingBlocStatus.success
                            ? state.ratingList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: state.ratingList.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: ColorsConstant
                                                          .getColorBackground5(
                                                              widget
                                                                  .colorsValue)))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomText(
                                                          text:
                                                              "${state.ratingList[index].customer!.customersName}",
                                                          style: TextStyleConstant
                                                              .headerTextMainColor(
                                                                  context,
                                                                  widget
                                                                      .colorsValue)),
                                                    ),
                                                    CustomText(
                                                        text:
                                                            "${SharedMethods.convertDate("${state.ratingList[index].ratingsCreatedAt}")}",
                                                        style: TextStyleConstant
                                                            .lightText(
                                                                context,
                                                                widget
                                                                    .colorsValue)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    RatingBar.builder(
                                                      ignoreGestures: true,
                                                      initialRating: double.parse(
                                                          "${state.ratingList[index].ratingsValue}"),
                                                      minRating: 0,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 18,
                                                      glow: false,
                                                      itemPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 1.0),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
// print(rating);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                (state.ratingList[index]
                                                                .ratingsText !=
                                                            null &&
                                                        state
                                                            .ratingList[index]
                                                            .ratingsText!
                                                            .isNotEmpty)
                                                    ? CustomText(
                                                        text:
                                                            "${state.ratingList[index].ratingsText}"
                                                                .replaceAll(
                                                                    "null", ""),
                                                        style: TextStyleConstant
                                                            .bodyTextSmall(
                                                                context,
                                                                widget
                                                                    .colorsValue))
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Container()
                            : state.status == RatingBlocStatus.initial
                                ? Center(child: CircularProgressIndicator())
                                : state.status == RatingBlocStatus.refresh
                                    ? Center(child: Container())
                                    : Center(child: Text("Errro")),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 6.h,
                      child: AppButton(
                          // disable: state.ratingModel.data!.allowRating! < 1,
                          colorsInitialValue: widget.colorsValue,
                          color: ColorsConstant.getColorBackground3(
                              widget.colorsValue),
                          textStyle: TextStyleConstant.buttonText(
                              context, widget.colorsValue),
                          title: "rateNow".tr().toString(),
                          onPressed: () {
                            if (state.ratingModel.data!.allowRating! < 1) {
                              DataErrorAlert.RateMessage(
                                  context: context,
                                  colorValue: widget.colorsValue);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddRating(
                                          colorsValue: widget.colorsValue,
                                          orderId: widget.productId)));
                            }
                          }),
                    ),
                  ],
                );
              } else {
                return SizedBox(
                  height: 100.h,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }, listener: (context, state) {
              if (state.status == RatingBlocStatus.initial ||
                  state.status == RatingBlocStatus.refresh) {
                context.read<RatingBloc>()
                  ..add(RatingFetch(orderID: widget.productId));
              }
            }),
          ),
        ),
      ),
    );
  }
}
