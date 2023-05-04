import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';

class PatchWidget extends StatelessWidget {
  const PatchWidget(
      {Key? key,
      required this.backGroundColor,
      required this.colorsValue,
      required this.title})
      : super(key: key);
  final String title;
  final Color backGroundColor;
  final ColorsInitialValue colorsValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backGroundColor, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CustomText(
          overflow: TextOverflow.ellipsis,
          maxLie: 2,
          text: title,
          textAlign: TextAlign.start,
          style: TextStyleConstant.whiteTextPatch(context, colorsValue),
        ),
      ),
    );
  }
}
