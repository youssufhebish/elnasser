import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:flutter/material.dart';

class LogoRegister extends StatelessWidget {
  const LogoRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: SizeDataConstant.customWidth(
            context, Responsive.isTablet(context) ? 2.5 : 1.5),
        child: Image.asset(
          ImageConstants.blueLogo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
