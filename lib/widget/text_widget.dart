import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {Key? key,
      required this.text,
      required this.style,
      this.overflow,
      this.maxLie,
      this.textAlign})
      : super(key: key);
  String? text;
  TextStyle style;
  int? maxLie;
  TextOverflow? overflow;
  TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: style,
      maxLines: maxLie,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
