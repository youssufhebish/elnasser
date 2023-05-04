import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/rating/rating_bloc/rating_cubit.dart';
import 'package:elnasser/screens/rating/rating_bloc/rating_cubit_state.dart';
import 'package:elnasser/screens/rating/rating_screen.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class AddRating extends StatelessWidget {
  AddRating({Key? key, required this.colorsValue, required this.orderId})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: CustomText(
              text: "addRating".tr().toString(),
              style: TextStyleConstant.headerText(context, colorsValue),
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
            child: BlocConsumer<RatingCubit, RatingCubitState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingWidget(
                      getRating: (double rating) {
                        RatingCubit.get(context).getQuality(rating);
                      },
                      rate: RatingCubit.get(context).quality,
                      title: 'productQuality'.tr().toString(),
                      colorsValue: colorsValue,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    RatingWidget(
                      getRating: (double rating) {
                        RatingCubit.get(context).getPrice(rating);
                      },
                      rate: RatingCubit.get(context).price,
                      title: 'productPrice'.tr().toString(),
                      colorsValue: colorsValue,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    RatingWidget(
                      getRating: (double rating) {
                        RatingCubit.get(context).getSize(rating);
                      },
                      rate: RatingCubit.get(context).size,
                      title: 'productPrice'.tr().toString(),
                      colorsValue: colorsValue,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    RatingWidget(
                      getRating: (double rating) {
                        RatingCubit.get(context).getMatch(rating);
                      },
                      rate: RatingCubit.get(context).match,
                      title: 'productMatch'.tr().toString(),
                      colorsValue: colorsValue,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: "ratingNote".tr().toString(),
                        style:
                            TextStyleConstant.headerText(context, colorsValue),
                      ),
                    ),
                    Center(
                        child: AppTextFiled(
                      password: false,
                      validation: null,
                      hintText: "ratingNote".tr().toString(),
                      nextNode: null,
                      controller: RatingCubit.get(context).rateNotes,
                      inputType: TextInputType.text,
                      labelText: "ratingNote".tr().toString(),
                      node: null,
                      validationWidget: Container(),
                      colorsInitialValue: colorsValue,
                      maxLines: 5,
                    )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: AppButton(
                          colorsInitialValue: colorsValue,
                          color:
                              ColorsConstant.getColorBackground3(colorsValue),
                          textStyle: TextStyleConstant.buttonText(
                              context, colorsValue),
                          title: "submit".tr().toString(),
                          onPressed: () {
                            RatingCubit.get(context).addRatingMethod(
                                context: context, orderId: orderId);
                          }),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                );
              },
              listener: (context, state) {
                if (state is RatingCubitStateAddSuccess) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RatingScreen(
                              colorsValue: colorsValue, productId: orderId)));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget(
      {Key? key,
      required this.colorsValue,
      required this.title,
      required this.getRating,
      required this.rate})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String title;
  final Function getRating;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "$title".tr().toString(),
            style: TextStyleConstant.headerText(context, colorsValue),
          ),
          Row(
            children: [
              Spacer(),
              RatingBar.builder(
                ignoreGestures: false,
                initialRating: rate,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 45,
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
        ],
      ),
    );
  }
}
