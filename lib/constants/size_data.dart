import 'package:elnasser/responsive/check_responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5

class SizeDataConstant {

  static webWidth(BuildContext context) =>
      (MediaQuery.of(context).size.width >= 1200
          ? 1140
          : MediaQuery.of(context).size.width);
  static webCardWidth(BuildContext context) =>
      (webWidth(context) - (17 * 4)) / 4;
  static webCardHeight(BuildContext context) => 66.h;

  /// mop ///

  static mopCategoryCardWidth(BuildContext context) =>
      ((MediaQuery.of(context).size.width) /
          ((Responsive.isTablet(context) ? 7 : 3.6)));
  static mopCardWidth(BuildContext context) =>
      (MediaQuery.of(context).size.width /
          (Responsive.isTablet(context) ? 3.2 : 2.2));
  static mopBannerHeight(BuildContext context) =>
      (Responsive.isTablet(context) ? 45.h : 25.h);

  /// full width///

  static fullWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static customWidth(BuildContext context, double value) =>
      (MediaQuery.of(context).size.width / value);
  static customWidthRate(BuildContext context, double value) =>
      ((MediaQuery.of(context).size.width - 100) / value);
}
