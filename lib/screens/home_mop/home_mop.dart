import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:elnasser/screens/filter/filter.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_state.dart';
import 'dart:math' as math; // import this

import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/cart_ounter_widget.dart';
import 'package:elnasser/widget/home_drawer_widget.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/notificationCounter.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeMobileScreen extends StatelessWidget {
  HomeMobileScreen({
    Key? key,
    required this.colorsValue,
  }) : super(key: key);
  ColorsInitialValue colorsValue;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          DataErrorAlert.ExitApp(colorValue: colorsValue, context: context);
          return true;
        },
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              key: scaffoldKey,

              bottomNavigationBar: SizedBox(
                height: 7.h,
                width: SizeDataConstant.fullWidth(context),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CurvedNavigationBar(
                      onTap: (index) {
                        HomeCubit.get(context).changeHomePage(index, context);
                      },
                      index: HomeCubit.get(context).currentIndex,
                      backgroundColor: Colors.transparent,
                      buttonBackgroundColor: Colors.white, //#707070
                      animationCurve: Curves.easeInOut,
                      animationDuration: Duration(milliseconds: 600),
                      height: Responsive.isTablet(context) ? 70 : 8.h,
                      items: <Widget>[
                        BottomBarItemWidget(
                          colorsValue: colorsValue,
                          index: 0,
                          path: ImageConstants.home,
                        ),
                        BottomBarItemWidget(
                          colorsValue: colorsValue,
                          index: 1,
                          path: ImageConstants.category,
                        ),
                        BottomBarItemWidget(
                          colorsValue: colorsValue,
                          index: 2,
                          path: ImageConstants.discount,
                        ),
                        BottomBarItemWidget(
                          colorsValue: colorsValue,
                          index: 3,
                          path: ImageConstants.user,
                        ),
                        BottomBarItemWidget(
                          colorsValue: colorsValue,
                          index: 4,
                          path: ImageConstants.support,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: SizedBox(
                        width: SizeDataConstant.fullWidth(context),
                        child: Row(
                          children: [
                            BottomBarText(
                              colorsValue: colorsValue,
                              index: 0,
                              text: 'home',
                            ),
                            BottomBarText(
                              colorsValue: colorsValue,
                              index: 1,
                              text: 'categories',
                            ),
                            BottomBarText(
                              colorsValue: colorsValue,
                              index: 2,
                              text: 'offers',
                            ),
                            BottomBarText(
                              colorsValue: colorsValue,
                              index: 3,
                              text: 'me',
                            ),
                            BottomBarText(
                              colorsValue: colorsValue,
                              index: 4,
                              text: 'support',
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              appBar: HomeCubit.get(context).currentIndex == 3 ||
                      HomeCubit.get(context).currentIndex == 4
                  ? null
                  : AppBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      shadowColor: Colors.transparent,
                      iconTheme: IconThemeData(color: Colors.black87),
                      leading: null,
                      elevation: 0,
                      centerTitle: false,
                      title: Container(
                        width: SizeDataConstant.customWidth(
                            context, (Responsive.isTablet(context) ? 6 : 3)),
                        child: Image.asset(
                          ImageConstants.blueLogo,
                          fit: BoxFit.contain,
                        ),
                      ),
                      actions: [
                        NotificationCounter(colorsValue: colorsValue),
                        BlocBuilder<AddToCartCubit, AddToCartState>(
                            builder: (context, state) {
                          return CartCounterWidget(colorsValue: colorsValue);
                        }),
                      ],
                    ),
              // drawer: Drawer(child: DrawerWidget(colorsValue: colorsValue,),),
              body: HomeCubit.get(context).showSearch == true
                  ? FilterScreen(colorsValue: colorsValue)
                  : HomeCubit.get(context).homeWidget(
                      colorsValue)[HomeCubit.get(context).currentIndex],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      // NotificationCubit.get(context).getNotification(context);
    });
  }
}

class BottomBarItemWidget extends StatelessWidget {
  BottomBarItemWidget(
      {Key? key,
      required this.colorsValue,
      required this.path,
      required this.index})
      : super(key: key);
  ColorsInitialValue colorsValue;
  final int index;
  final String path;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ImageView(
        path: path,
        color: HomeCubit.get(context).currentIndex == index
            ? ColorsConstant.getColorBackground3(colorsValue)
            : ColorsConstant.getColorBackground6(colorsValue),
        fit: BoxFit.contain,
      ),
    );
  }
}

class BottomBarText extends StatelessWidget {
  BottomBarText(
      {Key? key,
      required this.colorsValue,
      required this.text,
      required this.index})
      : super(key: key);
  ColorsInitialValue colorsValue;
  final int index;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeDataConstant.customWidth(context, 5),
        child: Center(
            child: CustomText(
          text: "$text".tr().toString(),
          style: TextStyleConstant.BottomBarTextStyle(
              index: index,
              currentIndex: HomeCubit.get(context).currentIndex,
              context: context,
              colorValue: colorsValue),
        )));
  }
}
