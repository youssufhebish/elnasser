import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/advertisement.dart';
import 'package:elnasser/models/home_model/home_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/widget/image.dart';
import 'package:flutter/material.dart';

import 'banner_section.dart';

class BannerSectionWidget extends StatelessWidget {
  BannerSectionWidget(
      {Key? key,
      required this.bannersList,
      required this.colorsValue,
      required this.theInitialModel})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;
  final List<BannerClass>? bannersList;
  @override
  Widget build(BuildContext context) {
    return bannersList != null
        ? SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (bannersList!.length / 3).ceil(),
              itemBuilder: (context, index) {
                print("bannersList!.length - (index * 3)");
                print(bannersList!.length - (index * 3));
                return bannersList!.length - (index * 3) <= 2
                    ? Column(
                        children: List.generate(
                            bannersList!.length - (index * 3),
                            (secondIndex) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          SharedMethods.goForwardMethod(
                                              context: context,
                                              colorsValue: colorsValue,
                                              theInitialModel: theInitialModel,
                                              type: bannersList![bannersList!
                                                              .length ==
                                                          1
                                                      ? 0
                                                      : bannersList!.length == 2
                                                          ? secondIndex
                                                          : 3 + secondIndex]
                                                  .advertisementsType,
                                              value:
                                                  bannersList![3 + secondIndex]
                                                      .advertisementsValue,
                                              url: bannersList![3 + secondIndex]
                                                  .advertisementsUrl);
                                        },
                                        child: SizedBox(
                                          width: SizeDataConstant.fullWidth(
                                              context),
                                          height:
                                              SizeDataConstant.mopBannerHeight(
                                                  context),
                                          child: ApiImage(
                                            folderName: "advertisements",
                                            type: "original",
                                            image: bannersList![bannersList!
                                                            .length ==
                                                        1
                                                    ? 0
                                                    : bannersList!.length == 2
                                                        ? secondIndex
                                                        : 3 + secondIndex]
                                                .advertisementsMobileImg,
                                            borderRadius: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                      )
                    : BannerSectionItem(
                        bannersList: bannersList,
                        index: index,
                        colorsValue: colorsValue,
                        theInitialModel: theInitialModel,
                      );
              },
            ),
          )
        : Container();
  }
}
