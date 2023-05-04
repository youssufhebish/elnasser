import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';

import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NoDataWidget extends StatelessWidget {
  NoDataWidget(
      {Key? key,
      required this.colorsValue,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String title;
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 18.h,
          width: 18.h,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsConstant.getColorBackground5(colorsValue)),
          child: Center(
              child: ImageView(
            path: image,
            fit: BoxFit.fill,
            width: 10.h,
            height: 10.h,
          )),
        ),
        SizedBox(
          height: 2.h,
        ),
        CustomText(
          text: "$title".tr().toString(),
          style: TextStyleConstant.headerText(context, colorsValue),
        ),
        SizedBox(
          height: 2.h,
        ),
        CustomText(
          text: "$description".tr().toString(),
          style: TextStyleConstant.lightText(context, colorsValue),
        ),
        SizedBox(
          height: 2.h,
        ),
        AppButton(
            colorsInitialValue: colorsValue,
            color: ColorsConstant.getColorBackground3(colorsValue),
            textStyle: TextStyleConstant.buttonText(context, colorsValue),
            title: "goShopping".tr().toString(),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
