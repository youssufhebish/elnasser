import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/advertisement.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/widget/image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:sizer/sizer.dart';

class HomePageSlider extends StatelessWidget {
  HomePageSlider(
      {required this.advertisements,
      required this.colorsValue,
      required this.theInitialModel});
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;
  Advertisements? advertisements;
  @override
  Widget build(BuildContext context) {
    return advertisements!.homeBanner != null
        ? SizedBox(
            height: (Responsive.isTablet(context) ? 40.h : 30.h),
            width: MediaQuery.of(context).size.width,
            child: Swiper(
              itemCount: advertisements!.homeBanner!.length,
              // pagination: new SwiperPagination(),
              fade: .2,
              scale: .85,
              viewportFraction: 0.8,
              indicatorLayout: PageIndicatorLayout.COLOR,
              pagination: SwiperPagination(
                  margin: const EdgeInsets.all(0.0),
                  builder: SwiperCustomPagination(builder:
                      (BuildContext context, SwiperPluginConfig config) {
                    return const DotSwiperPaginationBuilder(
                            color: Colors.black12,
                            activeColor: Colors.black,
                            size: 10.0,
                            activeSize: 20.0)
                        .build(context, config);
                  })),
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    SharedMethods.goForwardMethod(
                        context: context,
                        colorsValue: colorsValue,
                        theInitialModel: theInitialModel,
                        type: advertisements!
                            .homeBanner![index].advertisementsType,
                        value: advertisements!
                            .homeBanner![index].advertisementsValue,
                        url: advertisements!
                            .homeBanner![index].advertisementsUrl);
                  },
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                          ),
                          child: ApiImage(
                            folderName: "advertisements",
                            type: "original",
                            image: advertisements!
                                .homeBanner![index].advertisementsMobileImg,
                            borderRadius: 8,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : Container();
  }
}
