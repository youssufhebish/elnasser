import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class TextStyleConstant {
  static cardProductNameTextStyle(
          BuildContext context, ColorsInitialValue color) =>
      Responsive.isMobile(context)
          ? Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: ColorsConstant.getColorText1(color))
          : Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: ColorsConstant.getColorText1(color));

  static cardProductPriceDiscountTextStyle(
          BuildContext context, ColorsInitialValue color) =>
      Responsive.isMobile(context)
          ? Theme.of(context).textTheme.subtitle2?.copyWith(
              color: ColorsConstant.getColorText4(color),
              decoration: TextDecoration.lineThrough)
          : Theme.of(context).textTheme.subtitle1?.copyWith(
              color: ColorsConstant.getColorText4(color),
              decoration: TextDecoration.lineThrough);
  static stepGrey(BuildContext context, ColorsInitialValue color) =>
      Theme.of(context).textTheme.bodyText2?.copyWith(
            color: ColorsConstant.getColorText4(color),
          );
  static stepMain(BuildContext context, ColorsInitialValue color) =>
      Theme.of(context).textTheme.bodyText2?.copyWith(
            color: ColorsConstant.getColorText7(color),
          );
  static cardProductPriceTextStyle(
          BuildContext context, ColorsInitialValue color) =>
      Responsive.isMobile(context)
          ? Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: ColorsConstant.getColorText3(color))
          : Theme.of(context).textTheme.headline6?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorsConstant.getColorText3(color));
  static cardProductPriceTextStyleMainColor(
          BuildContext context, ColorsInitialValue color) =>
      Theme.of(context)
          .textTheme
          .subtitle2
          ?.copyWith(color: ColorsConstant.getColorText7(color));

  static cardProductOutOfStockTextStyle(
          BuildContext context, ColorsInitialValue color) =>
      Theme.of(context)
          .textTheme
          .bodyText2
          ?.copyWith(color: ColorsConstant.getColorText3(color));

  static buttonText(BuildContext context, ColorsInitialValue colorValue) =>
      Theme.of(context)
          .textTheme
          .bodyText2
          ?.copyWith(color: ColorsConstant.getColorText2(colorValue));
  static buttonTextMainColor(
          BuildContext context, ColorsInitialValue colorValue) =>
      Responsive.isMobile(context)
          ? Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: ColorsConstant.getColorText7(colorValue))
          : Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: ColorsConstant.getColorText7(colorValue));

  ///
  ///
  static cartItemDiscount(BuildContext context, ColorsInitialValue color) =>
      Theme.of(context).textTheme.caption?.copyWith(
          color: ColorsConstant.getColorText4(color),
          decoration: TextDecoration.lineThrough,
          fontWeight: Responsive.isMobile(context)
              ? FontWeight.normal
              : FontWeight.bold,
          fontSize: Responsive.isMobile(context) ? 11.5 : 16);
  static cartItemPrice(BuildContext context, ColorsInitialValue color) =>
      Theme.of(context).textTheme.caption?.copyWith(
          color: ColorsConstant.getColorText1(color),
          fontSize: Responsive.isMobile(context) ? 13 : 18);

  ///

  static headerText(BuildContext context, ColorsInitialValue colorValue) =>
      Responsive.isMobile(context)
          ? Theme.of(context).textTheme.subtitle1?.copyWith(
              color: ColorsConstant.getColorText1(colorValue),
              fontWeight: FontWeight.w500)
          : Theme.of(context).textTheme.headline5?.copyWith(
              color: ColorsConstant.getColorText1(colorValue),
              fontWeight: FontWeight.w500);
  static headerTextMainColor(
          BuildContext context, ColorsInitialValue colorValue) =>
      Responsive.isMobile(context)
          ? Theme.of(context).textTheme.headline6?.copyWith(
              color: ColorsConstant.getColorText7(colorValue),
              fontWeight: FontWeight.w500)
          : Theme.of(context).textTheme.headline5?.copyWith(
              color: ColorsConstant.getColorText7(colorValue),
              fontWeight: FontWeight.w500);
  static headerTextLargeBlack(
          BuildContext context, ColorsInitialValue colorValue) =>
      Theme.of(context).textTheme.headline6?.copyWith(
          color: ColorsConstant.getColorText1(colorValue),
          fontWeight: FontWeight.w500);
  static headerTextLargeError(
          BuildContext context, ColorsInitialValue colorValue) =>
      Theme.of(context).textTheme.headline6?.copyWith(
          color: ColorsConstant.getColorText5(colorValue),
          fontWeight: FontWeight.w500);
  static headerTextLargeWhite(
          BuildContext context, ColorsInitialValue colorValue) =>
      Theme.of(context).textTheme.headline5?.copyWith(
          color: ColorsConstant.getColorText2(colorValue),
          fontWeight: FontWeight.bold);
  static bodyText(BuildContext context, ColorsInitialValue colorsValue) =>
      Responsive.isMobile(context)
          ? Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 16, color: ColorsConstant.getColorText1(colorsValue))
          : Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: ColorsConstant.getColorText1(colorsValue));
  static bodyTextPoint(BuildContext context, ColorsInitialValue colorsValue) =>
      Responsive.isMobile(context)
          ? Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 14, color: ColorsConstant.getColorText1(colorsValue))
          : Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: ColorsConstant.getColorText1(colorsValue));
  static dropDown(BuildContext context, ColorsInitialValue colorsValue) =>
      Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 15, color: ColorsConstant.getColorText1(colorsValue));
  static bodyTextSmall(BuildContext context, ColorsInitialValue colorsValue) =>
      Theme.of(context).textTheme.bodyText2?.copyWith(
          fontWeight: FontWeight.bold,
          color: ColorsConstant.getColorText1(colorsValue));
  static bodyTextLarge(BuildContext context, ColorsInitialValue colorsValue) =>
      Theme.of(context).textTheme.subtitle2?.copyWith(
          fontWeight: FontWeight.bold,
          color: ColorsConstant.getColorText1(colorsValue));
  static bodyTextMainColor(
          BuildContext context, ColorsInitialValue colorsValue) =>
      Responsive.isMobile(context)
          ? Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: ColorsConstant.getColorText7(colorsValue))
          : Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: ColorsConstant.getColorText7(colorsValue));
  static bodyTextMainColorRate(
          BuildContext context, ColorsInitialValue colorsValue) =>
      Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(color: ColorsConstant.getColorText7(colorsValue));
  static bodyTextLogOut(BuildContext context, ColorsInitialValue colorsValue) =>
      Theme.of(context)
          .textTheme
          .bodyText1
          ?.copyWith(color: ColorsConstant.getColorText5(colorsValue));
  static bodyTextGreyBold(
          BuildContext context, ColorsInitialValue colorsValue) =>
      Theme.of(context).textTheme.subtitle1?.copyWith(
          fontWeight: FontWeight.w500,
          color: ColorsConstant.getColorText3(colorsValue));
  static bodyTextWhiteBold(
          BuildContext context, ColorsInitialValue colorsValue) =>
      Theme.of(context).textTheme.subtitle1?.copyWith(
          fontWeight: FontWeight.w500,
          color: ColorsConstant.getColorText2(colorsValue));
  static bodyTextWhiteBoldName(
          BuildContext context, ColorsInitialValue colorsValue) =>
      Responsive.isMobile(context)
          ? Theme.of(context).textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: ColorsConstant.getColorText2(colorsValue))
          : Theme.of(context).textTheme.headline6?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: ColorsConstant.getColorText2(colorsValue));

  static bodyTextGrey(BuildContext context, ColorsInitialValue colorsValue) =>
      Responsive.isMobile(context)
          ? Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: ColorsConstant.getColorText3(colorsValue))
          : Theme.of(context).textTheme.headline6?.copyWith(
              fontSize: 18, color: ColorsConstant.getColorText3(colorsValue));
  static bodyTextGreyDate(
          BuildContext context, ColorsInitialValue colorsValue) =>
      Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(color: ColorsConstant.getColorText3(colorsValue));

  static lightText(BuildContext context, ColorsInitialValue colorValue) =>
      Responsive.isMobile(context)
          ? Theme.of(context)
              .textTheme
              .button
              ?.copyWith(color: ColorsConstant.getColorText3(colorValue))
          : Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: ColorsConstant.getColorText3(colorValue));
  static optionalText(BuildContext context, ColorsInitialValue colorValue) =>
      Theme.of(context)
          .textTheme
          .button
          ?.copyWith(color: ColorsConstant.getColorText3(colorValue));
  static whiteText(BuildContext context, ColorsInitialValue colorValue) =>
      Theme.of(context).textTheme.button?.copyWith(
          fontSize: Responsive.isMobile(context) ? 14 : 20,
          color: ColorsConstant.getColorText2(colorValue));
  static whiteTextPatch(BuildContext context, ColorsInitialValue colorValue) =>
      Responsive.isMobile(context)
          ? Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: ColorsConstant.getColorText2(colorValue))
          : Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: ColorsConstant.getColorText2(colorValue));
  static errorText(BuildContext context, ColorsInitialValue colorValue) =>
      Theme.of(context)
          .textTheme
          .button
          ?.copyWith(color: ColorsConstant.getColorText5(colorValue));
  static backGroundText(BuildContext context, ColorsInitialValue colorValue) =>
      Theme.of(context)
          .textTheme
          .button
          ?.copyWith(color: ColorsConstant.getColorText7(colorValue));
  static subText(BuildContext context, ColorsInitialValue colorValue) =>
      Theme.of(context)
          .textTheme
          .button
          ?.copyWith(color: ColorsConstant.getColorText3(colorValue));

  static captionMainColor(
          BuildContext context, ColorsInitialValue colorsValue) =>
      Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(color: ColorsConstant.getColorText7(colorsValue));

  static BottomBarTextStyle(
          {required BuildContext context,
          required int index,
          required int currentIndex,
          required ColorsInitialValue colorValue}) =>
      Responsive.isMobile(context)
          ? Theme.of(context).textTheme.caption?.copyWith(
              color: currentIndex == index
                  ? ColorsConstant.getColorBackground3(colorValue)
                  : ColorsConstant.getColorBackground6(colorValue))
          : Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: currentIndex == index
                  ? ColorsConstant.getColorBackground3(colorValue)
                  : ColorsConstant.getColorBackground6(colorValue));
  static blackCaption12(
          {required BuildContext context,
          required ColorsInitialValue colorValue}) =>
      Theme.of(context).textTheme.caption?.copyWith(
          fontSize: Responsive.isMobile(context) ? 12 : 18,
          color: ColorsConstant.getColorText1(colorValue));

  /// No InterNet
  static headerNoInterNetText(
    BuildContext context,
  ) =>
      Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(color: Color(0xff1D2427), fontWeight: FontWeight.w500);

  static lightNoInterNetText(BuildContext context) =>
      Theme.of(context).textTheme.button?.copyWith(color: Color(0xff727272));
  static buttonTextNoInterNet(BuildContext context) =>
      Theme.of(context).textTheme.bodyText2?.copyWith(color: Color(0xffffffff));
}
