import 'dart:math';

import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTextFiled extends StatelessWidget {
  AppTextFiled(
      {Key? key,
      this.onchange,
      this.textInputAction = TextInputAction.done,
      required this.password,
      required this.validation,
      required this.hintText,
      required this.nextNode,
      required this.controller,
      required this.inputType,
      required this.labelText,
      required this.node,
      required this.validationWidget,
      this.width = 95,
      this.contentPaddingTop = 12,
      this.maxLines = 1,
      this.prefixIcon,
      this.coupon,
      this.scrollPadding = 0.0,
      required this.colorsInitialValue,
      this.textAlign = TextAlign.justify,
      this.enable = true,
      this.maxLength})
      : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FocusNode? node;
  final FocusNode? nextNode;
  final TextInputType inputType;
  final bool password;
  final bool? validation;
  final Widget validationWidget;
  final ColorsInitialValue colorsInitialValue;
  Widget? prefixIcon;
  TextAlign? textAlign;
  double? width;
  Function(String v)? onchange;
  bool? enable;
  int? maxLength;
  double? scrollPadding;
  Function()? coupon;
  double contentPaddingTop;
  int? maxLines;
  TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width?.w,
        child: Center(
          child: TextFormField(
            scrollPadding: EdgeInsets.only(bottom: scrollPadding!),
            maxLength: maxLength,
            enabled: enable,
            maxLines: maxLines,
            enableInteractiveSelection: true,
            textAlign: textAlign!,
            controller: controller,
            keyboardType: inputType,
            obscureText: password,
            focusNode: node,
            onChanged: onchange,
            textInputAction: textInputAction,
            onFieldSubmitted: (data) {
              if (node != null) FocusScope.of(context).requestFocus(nextNode);
              coupon;
            },
            decoration: InputDecoration(
              prefixIcon: prefixIcon == null ? null : prefixIcon,
              isDense: false,
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              contentPadding:
                  EdgeInsets.only(left: 12, right: 12, top: contentPaddingTop),
              suffixIcon: validation == null ? null : validationWidget,
              hintText: hintText,
              labelText: labelText,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorsConstant.getColorBorder1(colorsInitialValue),
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorsConstant.getColorBorder1(colorsInitialValue),
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorsConstant.getColorBackground3(
                          colorsInitialValue),
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ),
        ));
  }
}

class AppTextFiledArabic extends StatelessWidget {
  AppTextFiledArabic(
      {Key? key,
      this.textInputAction = TextInputAction.done,
      required this.password,
      required this.validation,
      required this.hintText,
      required this.nextNode,
      required this.controller,
      required this.inputType,
      required this.labelText,
      required this.node,
      required this.validationWidget,
      this.width = 95,
      this.maxLines = 1,
      this.prefixIcon,
      this.coupon,
      this.scrollPadding = 0.0,
      required this.colorsInitialValue,
      this.textAlign = TextAlign.justify,
      this.enable = true,
      this.maxLength})
      : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FocusNode? node;
  final FocusNode? nextNode;
  final TextInputType inputType;
  final bool password;
  final bool? validation;
  final Widget validationWidget;
  final ColorsInitialValue colorsInitialValue;
  Widget? prefixIcon;
  TextAlign? textAlign;
  double? width;
  bool? enable;
  int? maxLength;
  double? scrollPadding;
  TextInputAction? textInputAction;
  Function()? coupon;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width?.w,
        child: Center(
          child: TextFormField(
            scrollPadding: EdgeInsets.only(bottom: scrollPadding!),
            maxLength: maxLength,
            enabled: enable,
            maxLines: maxLines,
            enableInteractiveSelection: true,
            textAlign: textAlign!,
            controller: controller,
            keyboardType: inputType,
            obscureText: password,
            focusNode: node,
            textInputAction: textInputAction,
            onFieldSubmitted: (data) {
              if (node != null) FocusScope.of(context).requestFocus(nextNode);
              coupon;
            },
            decoration: InputDecoration(
              suffixIcon: prefixIcon == null ? null : prefixIcon,
              isDense: false,
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              contentPadding:
                  const EdgeInsets.only(left: 12, right: 12, top: 12),
              prefixIcon: validation == null ? null : validationWidget,
              hintText: hintText,
              labelText: labelText,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorsConstant.getColorBorder1(colorsInitialValue),
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorsConstant.getColorBorder1(colorsInitialValue),
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorsConstant.getColorBackground3(
                          colorsInitialValue),
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ),
        ));
  }
}

class ValidateText extends StatelessWidget {
  const ValidateText({Key? key, required this.validation}) : super(key: key);
  final bool? validation;
  @override
  Widget build(BuildContext context) {
    return validation == true
        ? (const Icon(
            Icons.check_circle,
            color: Colors.green,
          ))
        : Transform.rotate(
            angle: -pi / 4,
            child: (const Icon(
              Icons.add_circle,
              color: Colors.red,
            )),
          );
  }
}
