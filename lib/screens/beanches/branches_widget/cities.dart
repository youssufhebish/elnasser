import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/branches_model/branches_model.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/beanches/branches_bloc/branches_cubit.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';

class CitiesWidget extends StatefulWidget {
  CitiesWidget(
      {Key? key, required this.colorsValue, required this.contactSubject})
      : super(key: key);
  final ColorsInitialValue colorsValue;

  final List<CityModel> contactSubject;

  @override
  State<CitiesWidget> createState() => _CitiesWidgetState();
}

class _CitiesWidgetState extends State<CitiesWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<CityModel>(
      underline: Container(),
      //isDense: true,
      hint: CustomText(
        text: 'cities'.tr().toString(),
        style: TextStyleConstant.bodyText(context, widget.colorsValue),
      ),
      value: BranchesCubit.get(context).value,
      iconSize: 24,

      elevation: 16,
      isExpanded: true,
      style: TextStyleConstant.dropDown(context, widget.colorsValue),

      onChanged: (newValue) {
        setState(() {
          BranchesCubit.get(context).value = newValue;
          // ContactUsCubit.get(context).getID(value!.contactsSubjectsId!);
          BranchesCubit.get(context)
              .getCityBranchesLatLong(newValue!.citiesId!);
        });
      },
      items: widget.contactSubject.map<DropdownMenuItem<CityModel>>((value) {
        return DropdownMenuItem<CityModel>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CustomText(
              text: value.citiesTitle,
              style: TextStyleConstant.bodyText(context, widget.colorsValue),
            ),
          ),
        );
      }).toList(),
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
