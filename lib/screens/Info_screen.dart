import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen(
      {Key? key,
      required this.data,
      required this.title,
      required this.colorsValue})
      : super(key: key);
  final String data;
  final String title;
  final ColorsInitialValue colorsValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: CustomText(
              text: "$title".tr().toString(),
              style: TextStyleConstant.headerText(context, colorsValue),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Html(
              data: """$data""",
            ),
          ),
        ),
      ),
    );
  }
}
