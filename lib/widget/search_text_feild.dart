import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'search_widget/search_widget_bloc/search_widget_cubit.dart';

class AppSearchTextFiled extends StatelessWidget {
  AppSearchTextFiled(
      {Key? key,
      required this.onSubmit,
      required this.hintText,
      required this.controller,
      required this.inputType,
      this.width = 90,
      this.prefixIcon,
      required this.colorsInitialValue,
      this.textAlign = TextAlign.justify,
      this.enable = true,
      this.maxLength})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;

  final TextInputType inputType;
  final ColorsInitialValue colorsInitialValue;
  final Function(String) onSubmit;
  Widget? prefixIcon;
  TextAlign? textAlign;
  double? width;
  bool? enable;
  int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
          width: width?.w,
          child: Center(
            child: TextField(
              maxLength: maxLength,
              enabled: enable,
              maxLines: 1,
              enableInteractiveSelection: true,
              textAlign: textAlign!,
              controller: controller,
              keyboardType: inputType,
              onChanged: SearchWidgetCubit.get(context).getSearchText,
              onSubmitted: onSubmit,
              decoration: InputDecoration(
                prefixIcon: prefixIcon == null ? null : prefixIcon,

                isDense: false,

                filled: true,
                fillColor:
                    ColorsConstant.getColorBackground5(colorsInitialValue),

                contentPadding: const EdgeInsets.only(left: 12, right: 12),
                hintText: hintText,
                // labelText: labelText,

                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            ColorsConstant.getColorBorder1(colorsInitialValue),
                        width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            ColorsConstant.getColorBorder1(colorsInitialValue),
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
          )),
    );
  }
}
