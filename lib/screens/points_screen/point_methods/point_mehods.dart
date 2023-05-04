import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PointMethods {
  getStatusWidget(int? id) {
    switch (id) {
      case 9:
        return ImageView(
          path: ImageConstants.bronzePoint,
          width: 10.h,
          height: 10.h,
        );
      case 10:
        return ImageView(
          path: ImageConstants.silverPoint,
          width: 10.h,
          height: 10.h,
        );
      case 11:
        return ImageView(
          path: ImageConstants.goldPoint,
          width: 10.h,
          height: 10.h,
        );
      case null:
        return Container();
      default:
        {
          return ImageView(
            path: ImageConstants.goldPoint,
            width: 10.h,
            height: 10.h,
          );
        }
    }
  }
}
