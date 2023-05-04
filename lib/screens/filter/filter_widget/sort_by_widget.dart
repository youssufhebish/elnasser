import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SortByWidget extends StatefulWidget {
  SortByWidget({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;

  @override
  State<SortByWidget> createState() => _SortByWidgetState();
}

class _SortByWidgetState extends State<SortByWidget> {
  List<String> sortByData = [
    "sortByPopularity",
    "recently",
    "highestPrice",
    "lowestPrice",
    "highestRating",
    "bestSelling"
  ];
  String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      hint: CustomText(
          text: "sortBy".tr().toString(),
          style: TextStyleConstant.headerText(context, widget.colorsValue)),
      value: value,
      items: sortByData.map(items).toList(),
      onChanged: (v) {
        setState(() {
          this.value = v;

          FilterCubit.get(context).getSortBy(sortByData.indexOf(v!));
        });
      },
    );
  }

  DropdownMenuItem<String> items(String item) => DropdownMenuItem(
        value: item,
        child: CustomText(
          text: item.tr().toString(),
          style: TextStyle(
              fontSize: 16,
              color: ColorsConstant.getColorText1(widget.colorsValue)),
        ),
      );
}
