import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/models/branches_model/branches_model.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/beanches/branches_data_provider/branches_methods.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class BranchesWidget extends StatelessWidget {
  const BranchesWidget({
    Key? key,
    required this.branch,
    required this.colorsValue,
  }) : super(key: key);
  final ColorsInitialValue colorsValue;
  final Branch branch;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: key,
      initialChildSize: .30,
      maxChildSize: .40,
      minChildSize: .2,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          child: SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomText(
                        text: "${branch.branchesTitle}",
                        style: TextStyleConstant.headerTextMainColor(
                            context, colorsValue)),
                    SizedBox(
                      height: 2.h,
                    ),
                    branch.branchesWhatsapp != null
                        ? InkWell(
                            onTap: () {
                              BranchesMethods()
                                  .launchWithURLWhats(branch.branchesWhatsapp!);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: ColorsConstant.getColorBackground3(
                                      colorsValue),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: CustomText(
                                        text: "${branch.branchesWhatsapp}",
                                        style: TextStyleConstant.bodyText(
                                            context, colorsValue)))
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 2.h,
                    ),
                    branch.branchesMobile != null
                        ? InkWell(
                            onTap: () {
                              BranchesMethods()
                                  .launchTel(branch.branchesMobile!);
                            },
                            child: Row(
                              children: [
                                ImageView(
                                  path: ImageConstants.phone,
                                  color: ColorsConstant.getColorBackground3(
                                      colorsValue),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: CustomText(
                                        text: "${branch.branchesMobile}",
                                        style: TextStyleConstant.bodyText(
                                            context, colorsValue)))
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 2.h,
                    ),
                    branch.branchesAddress != null
                        ? InkWell(
                            onTap: () {
                              SharedMethods.launchMap(
                                  lat: branch.branchesGps!.split(",").first,
                                  long: branch.branchesGps!.split(",").last);
                            },
                            child: Row(
                              children: [
                                ImageView(
                                  path: ImageConstants.map,
                                  color: ColorsConstant.getColorBackground3(
                                      colorsValue),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: CustomText(
                                        text: "${branch.branchesAddress}",
                                        style: TextStyleConstant.bodyText(
                                            context, colorsValue)))
                              ],
                            ),
                          )
                        : Container(),
                    branch.branchesText != null
                        ? Divider()
                        : SizedBox(
                            height: 0.h,
                          ),
                    branch.branchesText != null
                        ? Row(
                            children: [
                              Expanded(
                                  child: CustomText(
                                      text: "    ${branch.branchesText}",
                                      style: TextStyleConstant.bodyText(
                                          context, colorsValue)))
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
