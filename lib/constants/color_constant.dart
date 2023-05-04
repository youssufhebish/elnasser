import 'package:elnasser/models/colors_colors_value.dart';
import 'package:flutter/cupertino.dart';

class ColorsConstant {
  // 'MainColor': GetHexClorCode(colors['MainColor'], 'FF'),
  // 'MainColorOpacity': GetHexClorCode(colors['MainColor'], '7F'),
  // 'AppbarBGColor': GetHexClorCode(colors['AppbarBGColor'], 'FF'),
  // 'SearchBGColor': GetHexClorCode(colors['SearchBGColor'], 'FF'),
  // 'bottomNavigationBarBGColor': GetHexClorCode(
  // colors['bottomNavigationBarBGColor'], 'FF'),
  // 'BGColor': GetHexClorCode(colors['BGColor'], 'FF'),
  // 'TextHeaderColor': GetHexClorCode(colors['TextHeaderColor'], 'FF'),
  // 'TextdetailsColor': GetHexClorCode(colors['TextdetailsColor'], 'FF'),
  // 'BorderColor': GetHexClorCode(colors['BorderColor'], 'FF'),
  // 'NavigBarBorderColor': GetHexClorCode(
  // colors['NavigBarBorderColor'], 'FF'),
  // 'TextOnMainColor': GetHexClorCode(colors['TextOnMainColor'], 'FF'),

  static String getHexColorCode(String code, String ops) {
    var hexColor = code.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = ops + hexColor;
    }
    if (hexColor.length == 8) {
      return "0x$hexColor";
    } else {
      return "";
    }
  }

  static getColorBackground1(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsBackground1!, "FF")));
  static getColorBackground2(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsBackground2!, "FF")));
  static getColorBackground3(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsBackground3!, "FF")));
  static getColorBackground4(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsBackground4!, "FF")));
  static getColorBackground5(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsBackground5!, "FF")));
  static getColorBackground6(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsBackground6!, "FF")));
  static getColorText1(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsText1!, "FF")));
  static getColorText2(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsText2!, "FF")));
  static getColorText3(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsText3!, "FF")));
  static getColorText4(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsText4!, "FF")));
  static getColorText5(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsText5!, "FF")));
  static getColorText6(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsText6!, "FF")));
  static getColorText7(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsText7!, "FF")));
  static getColorBorder1(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsBorder1!, "FF")));
  static getColorBorder2(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsBorder2!, "FF")));
  static getColorShadow1(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsShadow1!, "FF")));
  static getColorShadow2(ColorsInitialValue color) =>
      Color(int.parse(getHexColorCode(color.accountsColorsShadow2!, "FF")));
}
