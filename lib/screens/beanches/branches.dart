import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/beanches/branches_bloc/branches_cubit.dart';
import 'package:elnasser/screens/beanches/branches_bloc/branches_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import 'branches_widget/cities.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({Key? key}) : super(key: key);
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 10.4746,
  );

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
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
              text: "branches".tr().toString(),
              style: TextStyleConstant.headerText(
                  context,
                  SplashCubit.get(context)
                      .theInitialModel
                      .data!
                      .account!
                      .mobileAppColors!),
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
          body: BlocBuilder<BranchesCubit, BranchesState>(
            builder: (context, state) {
              if (state is BranchesStateBranchesSuccess ||
                  state is BranchesStateNearest ||
                  state is BranchesStateGetCity ||
                  state is BranchesStateGetController ||
                  state is BranchesStateGetLocation) {
                return Stack(
                  children: [
                    GoogleMap(
                      onTap: (v) {},
                      mapType: MapType.normal,
                      initialCameraPosition: BranchesScreen._kGooglePlex,
                      compassEnabled: true,
                      markers: BranchesCubit.get(context).branches.toSet(),
                      onMapCreated: (GoogleMapController controller) {
                        BranchesCubit.get(context)
                            .getController(controller, context);
                      },
                    ),
                    BranchesCubit.get(context)
                            .branchesModel
                            .data!
                            .cities!
                            .isNotEmpty
                        ? Positioned(
                            top: 5,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Row(
                                children: [
                                  AppButton(
                                      widthRatio: 2.8,
                                      colorsInitialValue:
                                          SplashCubit.get(context)
                                              .theInitialModel
                                              .data!
                                              .account!
                                              .mobileAppColors!,
                                      color: ColorsConstant.getColorBackground3(
                                          SplashCubit.get(context)
                                              .theInitialModel
                                              .data!
                                              .account!
                                              .mobileAppColors!),
                                      textStyle: TextStyleConstant.buttonText(
                                          context,
                                          SplashCubit.get(context)
                                              .theInitialModel
                                              .data!
                                              .account!
                                              .mobileAppColors!),
                                      title: "nearestBranch".tr().toString(),
                                      onPressed: () {
                                        BranchesCubit.get(context)
                                            .getNearestPoint(context);
                                      }),
                                  Spacer(),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                      ),
                                      width: SizeDataConstant.customWidth(
                                          context, 1.7),
                                      child: CitiesWidget(
                                        contactSubject:
                                            BranchesCubit.get(context)
                                                .branchesModel
                                                .data!
                                                .cities!,
                                        colorsValue: SplashCubit.get(context)
                                            .theInitialModel
                                            .data!
                                            .account!
                                            .mobileAppColors!,
                                      )),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    // Positioned(
                    //   bottom: 30,
                    //   right: 5,
                    //   child:,
                    // ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
