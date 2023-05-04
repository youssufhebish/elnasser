import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit_state.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_chip_attribute.dart';
import 'filter_chips_items.dart';

class FilterItem extends StatelessWidget {
  FilterItem(
      {Key? key,
      required this.colorsValue,
      required this.type,
      this.index,
      required this.title})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String title;
  final String type;
  int? index;
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.all(8),
          title: CustomText(
              text: "$title".tr().toString(),
              style: TextStyleConstant.headerText(context, colorsValue)),
          children: [
            BlocBuilder<FilterCubit, FilterCubitState>(
                builder: (context, state) {
              return FilterChipsWidget(
                index: index,
                colorsValue: colorsValue,
                filterModel: FilterCubit.get(context).filterModel,
                type: type,
              );
            })
          ],
        ));
  }
}

class FilterItemAttribute extends StatelessWidget {
  FilterItemAttribute(
      {Key? key, required this.colorsValue, required this.title})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.all(8),
          title: CustomText(
              text: "$title".tr().toString(),
              style: TextStyleConstant.headerText(context, colorsValue)),
          children: [
            FilterChipsAttributeWidget(
              colorsValue: colorsValue,
              filterModel: FilterCubit.get(context).filterModel,
            )
          ],
        ));
  }
}
