import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';

import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'image_widget.dart';

class NoItemWidget extends StatelessWidget {
  NoItemWidget({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;
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
            path: ImageConstants.emptyCart,
            fit: BoxFit.fill,
            width: 10.h,
            height: 10.h,
          )),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          height: 2.h,
        ),
        CustomText(
          text: "noProductFound".tr().toString(),
          style: TextStyleConstant.headerText(context, colorsValue),
        )
      ],
    );
  }
}
