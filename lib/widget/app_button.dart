import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {Key? key,
      this.radius = 8,
      required this.colorsInitialValue,
      required this.color,
      required this.textStyle,
      required this.title,
      this.widthRatio = 1.3,
      this.heightRatio = 6,
      required this.onPressed,
      this.withBorder = false,
      this.disable = false})
      : super(key: key);
  final String title;
  final TextStyle textStyle;
  final ColorsInitialValue colorsInitialValue;
  final Color color;
  double? heightRatio;
  double? widthRatio;
  bool? withBorder;
  double? radius;
  bool? disable;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeDataConstant.customWidth(context, widthRatio!),
      child: MaterialButton(
        height: heightRatio!.h,
        splashColor: Colors.white,
        onPressed: disable == false ? onPressed : () {},
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        color: disable == false
            ? withBorder == false
                ? color
                : Colors.white
            : ColorsConstant.getColorBackground6(colorsInitialValue),
        shape: withBorder == false
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius!))
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius!),
                side: BorderSide(color: color, width: 1),
              ),
        child: CustomText(
          text: title,
          style: textStyle,
        ),
      ),
    );
  }
}

class AppButtonNoInterNet extends StatelessWidget {
  AppButtonNoInterNet(
      {Key? key,
      required this.color,
      required this.textStyle,
      required this.title,
      this.widthRatio = 1.3,
      this.heightRatio = 6,
      required this.onPressed,
      this.withBorder = false,
      this.disable = false})
      : super(key: key);
  final String title;
  final TextStyle textStyle;
  final Color color;
  double? heightRatio;
  double? widthRatio;
  bool? withBorder;
  bool? disable;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeDataConstant.customWidth(context, widthRatio!),
      child: MaterialButton(
        height: heightRatio!.h,
        splashColor: Colors.white,
        onPressed: disable == false ? onPressed : () {},
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        color: disable == false
            ? withBorder == false
                ? color
                : Colors.white
            : Color(0xff0060AF),
        shape: withBorder == false
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: color, width: 1),
              ),
        child: CustomText(
          text: title,
          style: textStyle,
        ),
      ),
    );
  }
}
