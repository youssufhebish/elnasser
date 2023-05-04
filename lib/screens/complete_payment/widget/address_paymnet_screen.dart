import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/widget/address_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddressPaymentListScreen extends StatelessWidget {
  const AddressPaymentListScreen({Key? key, required this.colorsValue})
      : super(key: key);
  final ColorsInitialValue colorsValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h - (36.h),
      child: SingleChildScrollView(
        child: AddressListWidget(
          colorsValue: colorsValue,
          showDeleteIcon: false,
        ),
      ),
    );
  }
}
