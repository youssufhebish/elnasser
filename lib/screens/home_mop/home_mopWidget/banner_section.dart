import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/advertisement.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/widget/image.dart';
import 'package:flutter/material.dart';

class BannerSectionItem extends StatelessWidget {
  const BannerSectionItem(
      {Key? key,
      required this.bannersList,
      required this.index,
      required this.colorsValue,
      required this.theInitialModel})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;
  final List<BannerClass>? bannersList;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              SharedMethods.goForwardMethod(
                  context: context,
                  colorsValue: colorsValue,
                  theInitialModel: theInitialModel,
                  type: bannersList![bannersList!.length * index == 0
                          ? 0
                          : bannersList!.length - index * 3]
                      .advertisementsType,
                  value: bannersList![bannersList!.length * index == 0
                          ? 0
                          : bannersList!.length - index * 3]
                      .advertisementsValue,
                  url: bannersList![bannersList!.length * index == 0
                          ? 0
                          : bannersList!.length - index * 3]
                      .advertisementsUrl);
            },
            child: SizedBox(
              width: SizeDataConstant.fullWidth(context),
              height: SizeDataConstant.mopBannerHeight(context),
              child: ApiImage(
                folderName: "advertisements",
                type: "original",
                image: bannersList![bannersList!.length * index == 0
                        ? 0
                        : bannersList!.length - index * 3]
                    .advertisementsMobileImg,
                borderRadius: 0,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    SharedMethods.goForwardMethod(
                        context: context,
                        colorsValue: colorsValue,
                        theInitialModel: theInitialModel,
                        type: bannersList![bannersList!.length * index == 0
                                ? 1
                                : bannersList!.length - index * 2]
                            .advertisementsType,
                        value: bannersList![bannersList!.length * index == 0
                                ? 1
                                : bannersList!.length - index * 2]
                            .advertisementsValue,
                        url: bannersList![bannersList!.length * index == 0
                                ? 1
                                : bannersList!.length - index * 2]
                            .advertisementsUrl);
                  },
                  child: SizedBox(
                    width: SizeDataConstant.fullWidth(context),
                    height: SizeDataConstant.mopBannerHeight(context),
                    child: ApiImage(
                      folderName: "advertisements",
                      type: "original",
                      image: bannersList![bannersList!.length * index == 0
                              ? 1
                              : bannersList!.length - index * 2]
                          .advertisementsMobileImg,
                      borderRadius: 0,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    SharedMethods.goForwardMethod(
                        context: context,
                        colorsValue: colorsValue,
                        theInitialModel: theInitialModel,
                        type: bannersList![bannersList!.length * index == 0
                                ? 2
                                : bannersList!.length - index * 1]
                            .advertisementsType,
                        value: bannersList![bannersList!.length * index == 0
                                ? 2
                                : bannersList!.length - index * 1]
                            .advertisementsValue,
                        url: bannersList![bannersList!.length * index == 0
                                ? 2
                                : bannersList!.length - index * 1]
                            .advertisementsUrl);
                  },
                  child: SizedBox(
                    width: SizeDataConstant.fullWidth(context),
                    height: SizeDataConstant.mopBannerHeight(context),
                    child: ApiImage(
                      folderName: "advertisements",
                      type: "original",
                      image: bannersList![bannersList!.length * index == 0
                              ? 2
                              : bannersList!.length - index * 1]
                          .advertisementsMobileImg,
                      borderRadius: 0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
