import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/address_model/address_model.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/address/add_new_address.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import 'image_widget.dart';

class AddressItemWidget extends StatelessWidget {
  const AddressItemWidget(
      {Key? key,
      required this.colorsValue,
      required this.index,
      required this.currentIndex,
      required this.address,
      required this.showDeleteIcon})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final int index;
  final int currentIndex;
  final AddressDataModel address;
  final bool showDeleteIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 20.h,
        decoration: BoxDecoration(
          border: Border.all(
              color: index == currentIndex
                  ? ColorsConstant.getColorBorder2(colorsValue)
                  : ColorsConstant.getColorBorder1(colorsValue)),
          borderRadius: BorderRadius.circular(8),
          color: index == currentIndex
              ? ColorsConstant.getColorBackground3(colorsValue)
              : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomText(
                        text: "${address.customerAddressesName}",
                        style: index == currentIndex
                            ? TextStyleConstant.bodyTextWhiteBold(
                                context, colorsValue)
                            : TextStyleConstant.bodyTextGreyBold(
                                context, colorsValue)),
                  ),
                  IconButton(
                      onPressed: () {
                        AddressCubit.get(context)
                            .getTappedLocation(LatLng(
                                double.parse(
                                    "${address.customerAddressesGps!.split(",")[0]}"),
                                double.parse(
                                    "${address.customerAddressesGps!.split(",")[1]}")))
                            .whenComplete(() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddNewAddress(
                                          address: address,
                                          colorsValue: colorsValue,
                                          edit: true,
                                        ))));
                      },
                      icon: ImageView(
                        path: ImageConstants.edit,
                        color: index == currentIndex
                            ? ColorsConstant.getColorBackground5(colorsValue)
                            : ColorsConstant.getColorBorder1(colorsValue),
                      ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomText(
                        text: "${address.customerAddressesAddress}",
                        style: index == currentIndex
                            ? TextStyleConstant.whiteText(context, colorsValue)
                            : TextStyleConstant.bodyTextGrey(
                                context, colorsValue)),
                  ),
                  showDeleteIcon == true
                      ? IconButton(
                          onPressed: () {
                            DataErrorAlert.deleteAddress(
                                colorValue: colorsValue,
                                context: context,
                                id: "${address.customerAddressesId}");
                          },
                          icon: ImageView(
                            path: ImageConstants.delete,
                            color: index == currentIndex
                                ? ColorsConstant.getColorBackground5(
                                    colorsValue)
                                : ColorsConstant.getColorBorder1(colorsValue),
                          ))
                      : Container(
                          width: 0,
                        ),
                ],
              ),
              CustomText(
                  text: "${address.customerAddressesPhone}",
                  style: index == currentIndex
                      ? TextStyleConstant.whiteText(context, colorsValue)
                      : TextStyleConstant.bodyTextGrey(context, colorsValue)),
            ],
          ),
        ),
      ),
    );
  }
}
