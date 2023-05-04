import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/filter_model/chips_model.dart';
import 'package:elnasser/models/filter_model/filter_model.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:flutter/material.dart';

class FilterChipsWidget extends StatefulWidget {
  FilterChipsWidget(
      {Key? key,
      this.index,
      required this.colorsValue,
      required this.filterModel,
      required this.type})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final FilterModel filterModel;
  final String type;
  int? index;

  @override
  _FilterChipsWidgetState createState() => _FilterChipsWidgetState();
}

class _FilterChipsWidgetState extends State<FilterChipsWidget> {
  List<FilterChipData> filterChipsList = [];
  final double spacing = 4;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    switch (widget.type) {
      case "Brand":
        widget.filterModel.data!.brands!.forEach((element) {
          filterChipsList.add(FilterChipData(
              color: ColorsConstant.getColorBackground3(widget.colorsValue),
              label: '${element.brandsName!}',
              id: element.brandsId!));
        });
        break;
      case "Size":

        ///  See After Edit API V002
        widget.filterModel.data!.choices![widget.index!].subchoices!
            .forEach((element) {
          filterChipsList.add(FilterChipData(
              color: ColorsConstant.getColorBackground3(widget.colorsValue),
              label: '${element.trans!.first.choicesTitle}',
              id: element.choicesId!));
        });
        widget.filterModel.data!.choices!.forEach((element) {
          element.subchoices!.forEach((element) {});
        });
        break;
      case "Category":
        widget.filterModel.data!.categories!.forEach((element) {
          filterChipsList.add(FilterChipData(
              color: ColorsConstant.getColorBackground3(widget.colorsValue),
              label: '${element.trans!.first.categoriesTitle}',
              id: element.categoriesId!));
        });
        break;
      case "Offer":
        widget.filterModel.data!.offers!.forEach((element) {
          filterChipsList.add(FilterChipData(
              color: ColorsConstant.getColorBackground3(widget.colorsValue),
              label: '${element.trans!.first.offersTitle}',
              id: element.offersId!));
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        runSpacing: spacing,
        spacing: spacing,
        children: filterChipsList
            .map((filterChip) => FilterChip(
                  padding: EdgeInsets.zero,
                  label: Text(filterChip.label),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: filterChip.isSelected == true
                        ? filterChip.color
                        : ColorsConstant.getColorText4(widget.colorsValue),
                  ),
                  backgroundColor: Colors.white,
                  onSelected: (isSelected) => setState(() {
                    switch (widget.type) {
                      case "Brand":
                        FilterCubit.get(context)
                            .getBrands(filterChip.id, isSelected);
                        break;
                      case "Size":
                        FilterCubit.get(context)
                            .getSizes(filterChip.id, isSelected);
                        break;
                      case "Category":
                        FilterCubit.get(context)
                            .getCategory(filterChip.id, isSelected);
                        break;
                      case "Offer":
                        FilterCubit.get(context)
                            .getOffer(filterChip.id, isSelected);
                        break;
                    }
                    filterChipsList = filterChipsList.map((otherChip) {
                      return filterChip == otherChip
                          ? otherChip.copy(isSelected: isSelected)
                          : otherChip;
                    }).toList();
                  }),
                  selected: filterChip.isSelected,
                  checkmarkColor: filterChip.color,
                  selectedColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: filterChip.isSelected == true
                            ? ColorsConstant.getColorBorder2(widget.colorsValue)
                            : ColorsConstant.getColorBorder1(
                                widget.colorsValue),
                      )),
                ))
            .toList(),
      ),
    );
  }
}
