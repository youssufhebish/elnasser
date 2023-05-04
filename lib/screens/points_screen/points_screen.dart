import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/points_screen/point_bloc/point_state.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:elnasser/widget/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'point_bloc/point_cubit.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;
  @override
  Widget build(BuildContext context) {
    print(SizeDataConstant.fullWidth(context));

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: CustomText(
              text: "points".tr().toString(),
              style: TextStyleConstant.bodyTextWhiteBold(context, colorsValue),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: ColorsConstant.getColorBackground3(colorsValue),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<PointCubit, PointState>(builder: (context, state) {
                  if (state is PointStateSuccess) {
                    return Container(
                      width: SizeDataConstant.fullWidth(context),
                      height: 50.h * 1.8157201166180759,
                      child: CustomPaint(
                        size: Size(
                            SizeDataConstant.fullWidth(context),
                            (50.h * 1.8157201166180759)
                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: TicketWidget(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            // PointMethods().getStatusWidget(PointCubit.get(context).pointModel.data!.customerLevel!.pointsLevelsId!),
                            PointCubit.get(context)
                                        .pointModel
                                        .data!
                                        .customerLevel !=
                                    null
                                ? PointCubit.get(context).points[
                                    PointCubit.get(context)
                                        .pointModel
                                        .data!
                                        .pointLevels!
                                        .indexWhere((element) => (element
                                                .pointsLevelsId ==
                                            PointCubit.get(context)
                                                .pointModel
                                                .data!
                                                .customerLevel
                                                ?.pointsLevelsId))]
                                : Container(),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomText(
                                text: "yourPoints".tr().toString(),
                                style: TextStyleConstant.headerTextLargeBlack(
                                    context, colorsValue)),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomText(
                                text:
                                    "${PointCubit.get(context).pointModel.data!.customerPoints}",
                                style: TextStyleConstant.headerTextMainColor(
                                    context, colorsValue)),
                            SizedBox(
                              height: 1.h,
                            ),
                            PointCubit.get(context)
                                        .pointModel
                                        .data!
                                        .customerLevel !=
                                    null
                                ? CustomText(
                                    text: "every100Point".tr().toString(),
                                    style: TextStyleConstant.optionalText(
                                        context, colorsValue))
                                : Container(),
                            SizedBox(
                              height: 1.h,
                            ),
                            PointCubit.get(context)
                                        .pointModel
                                        .data!
                                        .customerLevel !=
                                    null
                                ? CustomText(
                                    text:
                                        "${PointCubit.get(context).pointModel.data!.customerLevel!.pointsLevelsValue} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                    style: TextStyleConstant.bodyText(
                                        context, colorsValue))
                                : Container(),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              width: SizeDataConstant.customWidth(context, 1.2),
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  final boxWidth = constraints.constrainWidth();
                                  final dashWidth = 4.0;
                                  final dashHeight = 2;
                                  final dashCount =
                                      (boxWidth / (2 * dashWidth)).floor();
                                  return Flex(
                                    children: List.generate(dashCount, (_) {
                                      return SizedBox(
                                        width: dashWidth,
                                        height: 2,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: ColorsConstant
                                                  .getColorBorder1(
                                                      colorsValue)),
                                        ),
                                      );
                                    }),
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    direction: Axis.horizontal,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            SizedBox(
                              width: SizeDataConstant.customWidth(context, 1.2),
                              child: Row(
                                children: [Spacer()],
                              ),
                            ),

                            // ListView.builder(
                            //      itemCount: PointCubit.get(context).nextPointLevel.length,
                            //     itemBuilder: (context,index){
                            //      return SizedBox(
                            //        width: SizeDataConstant.fullWidth(context)-70,
                            //        height: 10.h,
                            //        child: Row(
                            //          children: [
                            //
                            //          ],
                            //        ),
                            //      );
                            //     }),

                            // ( PointCubit.get(context)
                            //      .pointModel
                            //      .data!.pointLevels![0].pointsLevelsId !=
                            //      PointCubit.get(context)
                            //          .pointModel
                            //          .data!
                            //          .customerLevel!
                            //          .pointsLevelsId )?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorsConstant.getColorBackground5(
                                        colorsValue)),
                                width:
                                    SizeDataConstant.customWidth(context, 1.2),
                                height: 11.h,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: 5.h,
                                      height: 5.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ImageView(
                                          path: ImageConstants.bronzePoint,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Spacer(),
                                        Row(
                                          children: [
                                            CustomText(
                                              text:
                                                  "${PointCubit.get(context).pointModel.data!.pointLevels![0].pointsLevelsName}",
                                              style: TextStyleConstant
                                                  .bodyTextPoint(
                                                      context, colorsValue),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CustomText(
                                                text:
                                                    "${PointCubit.get(context).pointModel.data!.pointLevels![0].pointsLevelsFrom}-${PointCubit.get(context).pointModel.data!.pointLevels![0].pointsLevelsTo}",
                                                style: TextStyleConstant
                                                    .bodyTextMainColor(
                                                        context, colorsValue)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            CustomText(
                                                text: "every100Point"
                                                    .tr()
                                                    .toString(),
                                                style: TextStyleConstant
                                                    .optionalText(
                                                        context, colorsValue)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CustomText(
                                                text:
                                                    "${PointCubit.get(context).pointModel.data!.pointLevels![0].pointsLevelsValue} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                                style: TextStyleConstant
                                                    .bodyTextMainColor(
                                                        context, colorsValue)),
                                          ],
                                        ),
                                        Spacer()
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            // :Container(),

                            // ( PointCubit.get(context)
                            //     .pointModel
                            //     .data!.pointLevels![1].pointsLevelsId !=
                            //     PointCubit.get(context)
                            //         .pointModel
                            //         .data!
                            //         .customerLevel!
                            //         .pointsLevelsId )?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorsConstant.getColorBackground5(
                                        colorsValue)),
                                width:
                                    SizeDataConstant.customWidth(context, 1.2),
                                height: 11.h,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: 5.h,
                                      height: 5.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ImageView(
                                          path: ImageConstants.silverPoint,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Spacer(),
                                        Container(
                                          child: Wrap(
                                            children: [
                                              CustomText(
                                                text:
                                                    "${PointCubit.get(context).pointModel.data!.pointLevels![1].pointsLevelsName}",
                                                style: TextStyleConstant
                                                    .bodyTextPoint(
                                                        context, colorsValue),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              CustomText(
                                                  text:
                                                      "${PointCubit.get(context).pointModel.data!.pointLevels![1].pointsLevelsFrom}-${PointCubit.get(context).pointModel.data!.pointLevels![1].pointsLevelsTo}",
                                                  style: TextStyleConstant
                                                      .bodyTextMainColor(
                                                          context,
                                                          colorsValue)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            CustomText(
                                                text: "every100Point"
                                                    .tr()
                                                    .toString(),
                                                style: TextStyleConstant
                                                    .optionalText(
                                                        context, colorsValue)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CustomText(
                                                text:
                                                    "${PointCubit.get(context).pointModel.data!.pointLevels![1].pointsLevelsValue} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                                style: TextStyleConstant
                                                    .bodyTextMainColor(
                                                        context, colorsValue)),
                                          ],
                                        ),
                                        Spacer()
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            // :Container(),
                            // ( PointCubit.get(context)
                            //     .pointModel
                            //     .data!.pointLevels![2].pointsLevelsId !=
                            //     PointCubit.get(context)
                            //         .pointModel
                            //         .data!
                            //         .customerLevel!
                            //         .pointsLevelsId )?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorsConstant.getColorBackground5(
                                        colorsValue)),
                                width:
                                    SizeDataConstant.customWidth(context, 1.2),
                                height: 11.h,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: 5.h,
                                      height: 5.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ImageView(
                                          path: ImageConstants.goldPoint,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Spacer(),
                                        Row(
                                          children: [
                                            CustomText(
                                              text:
                                                  "${PointCubit.get(context).pointModel.data!.pointLevels![2].pointsLevelsName}",
                                              style: TextStyleConstant
                                                  .bodyTextPoint(
                                                      context, colorsValue),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            CustomText(
                                                text:
                                                    "${PointCubit.get(context).pointModel.data!.pointLevels![2].pointsLevelsFrom}-${PointCubit.get(context).pointModel.data!.pointLevels![2].pointsLevelsTo}",
                                                style: TextStyleConstant
                                                    .bodyTextMainColor(
                                                        context, colorsValue)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            CustomText(
                                                text: "every100Point"
                                                    .tr()
                                                    .toString(),
                                                style: TextStyleConstant
                                                    .optionalText(
                                                        context, colorsValue)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CustomText(
                                                text:
                                                    "${PointCubit.get(context).pointModel.data!.pointLevels![2].pointsLevelsValue} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                                style: TextStyleConstant
                                                    .bodyTextMainColor(
                                                        context, colorsValue)),
                                          ],
                                        ),
                                        Spacer()
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            )
                            // :Container(),
                          ],
                        ),
                      ),
                    );
                  } else if (state is PointStateLoading) {
                    return Container(
                      height: 90.h,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Container(
                      width: SizeDataConstant.fullWidth(context),
                      height: 90.h,
                      color: Colors.white,
                      child: Center(
                          child: CustomText(
                        text: "noOperationNow".tr().toString(),
                        style: TextStyleConstant.bodyTextLarge(
                            context, colorsValue),
                      )),
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
