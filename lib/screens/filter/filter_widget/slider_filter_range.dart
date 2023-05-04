import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

class SliderRangeWidget extends StatefulWidget {
  SliderRangeWidget({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;
  @override
  _SliderRangeWidgetState createState() => _SliderRangeWidgetState();
}

class _SliderRangeWidgetState extends State<SliderRangeWidget> {
  RangeValues rangeValues = RangeValues(0, 5000);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  CustomText(
                      text: "${"from".tr().toString()} ",
                      style: TextStyleConstant.headerText(
                          context, widget.colorsValue)),
                  CustomText(
                      text:
                          "${rangeValues.start.round().toString()} ${FilterCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                      style: TextStyleConstant.bodyTextMainColor(
                          context, widget.colorsValue)),
                ],
              ),
            ),
            Spacer(
              flex: 7,
            ),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  CustomText(
                      text: "${"to".tr().toString()} ",
                      style: TextStyleConstant.headerText(
                          context, widget.colorsValue)),
                  CustomText(
                      text:
                          "${rangeValues.end.round().toString()} ${FilterCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                      style: TextStyleConstant.bodyTextMainColor(
                          context, widget.colorsValue)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            CustomText(
                text: "   0   ",
                style: TextStyleConstant.bodyTextMainColor(
                    context, widget.colorsValue)),
            Expanded(
              flex: 1,
              child: SliderTheme(
                  data: SliderThemeData(
                    activeTickMarkColor: Colors.transparent,
                    valueIndicatorShape: SliderComponentShape.noThumb,
                    inactiveTickMarkColor: Colors.transparent,
                    valueIndicatorColor: ColorsConstant.getColorBackground3(
                        widget.colorsValue), // This is what you are asking for
                  ),
                  child: RangeSlider(
                    values: rangeValues,
                    onChanged: (v) {
                      setState(() {
                        this.rangeValues = v;
                        FilterCubit.get(context)
                            .getMaxPrice(rangeValues.end.round().toString());
                        FilterCubit.get(context)
                            .getMinPrice(rangeValues.start.round().toString());
                      });
                    },
                    min: 0,
                    activeColor:
                        ColorsConstant.getColorBackground3(widget.colorsValue),
                    inactiveColor:
                        ColorsConstant.getColorBackground5(widget.colorsValue),
                    max: 5000,
                    divisions: 5000,
                    labels: RangeLabels(
                      rangeValues.start.round().toString(),
                      rangeValues.end.round().toString(),
                    ),
                  )),
            ),
            CustomText(
                text: "5000",
                style: TextStyleConstant.bodyTextMainColor(
                    context, widget.colorsValue)),
          ],
        ),
      ],
    );
  }
}
