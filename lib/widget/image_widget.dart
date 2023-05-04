import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageView extends StatelessWidget {
  ImageView(
      {Key? key,
      required this.path,
      this.color,
      this.fit = BoxFit.scaleDown,
      this.width = 20,
      this.height = 20})
      : super(key: key);
  final String path;
  Color? color;
  double? width;
  double? height;
  BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return path.contains(".svg")
        ? SvgPicture.asset(
            path,
            width: width,
            height: height,
            fit: fit,
            color: color,
          )
        : Image.asset(
            path,
            height: 10,
            width: 10,
            fit: fit,
          );
  }
}
