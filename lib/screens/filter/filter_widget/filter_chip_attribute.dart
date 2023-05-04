import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/filter_model/chips_model.dart';
import 'package:elnasser/models/filter_model/filter_model.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/widget/image.dart';
import 'package:flutter/material.dart';

class FilterChipsAttributeWidget extends StatefulWidget {
  FilterChipsAttributeWidget(
      {Key? key, required this.colorsValue, required this.filterModel})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final FilterModel filterModel;
  @override
  _FilterChipsAttributeWidgetState createState() =>
      _FilterChipsAttributeWidgetState();
}

class _FilterChipsAttributeWidgetState
    extends State<FilterChipsAttributeWidget> {
  List<FilterChipAttributeData> filterChipsList = [];
  final double spacing = 4;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.filterModel.data!.attributes!.forEach((element) {
      filterChipsList.add(FilterChipAttributeData(
          image: element.attributesImage!,
          color: ColorsConstant.getColorBackground3(widget.colorsValue),
          id: element.attributesId!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        runSpacing: 0,
        spacing: spacing,
        children: filterChipsList
            .map((filterChip) => FilterChip(
                  padding: EdgeInsets.all(0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  label: SizedBox(
                    width: 40,
                    height: 35,
                    child: ApiImage(
                      type: "original",
                      folderName: "attributes",
                      image: filterChip.image,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  onSelected: (isSelected) => setState(() {
                    FilterCubit.get(context)
                        .getAttribute(filterChip.id, isSelected);

                    filterChipsList = filterChipsList.map((otherChip) {
                      return filterChip == otherChip
                          ? otherChip.copy(isSelected: isSelected)
                          : otherChip;
                    }).toList();
                  }),
                  selected: filterChip.isSelected,
                  checkmarkColor: filterChip.color,
                  showCheckmark: false,
                  selectedColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        width: 2,
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
