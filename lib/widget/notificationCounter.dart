import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/models/colors_colors_value.dart';

import 'package:elnasser/screens/notification/notification_bloc/notification_cubit.dart';
import 'package:elnasser/screens/notification/notification_bloc/notification_cubit_state.dart';
import 'package:elnasser/screens/notification/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'image_widget.dart';

class NotificationCounter extends StatelessWidget {
  NotificationCounter({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationScreen(
                      colorsValue: colorsValue,
                    )));
      },
      child: Container(
        width: 50,
        height: AppBar().preferredSize.height,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen(
                                  colorsValue: colorsValue,
                                )));
                  },
                  icon: ImageView(
                    path: ImageConstants.notification,
                    color: ColorsConstant.getColorText1(colorsValue),
                    fit: BoxFit.scaleDown,
                    width: 15.w,
                    height: 6.h,
                  ),
                )),
            Positioned(
              top: 10,
              left: 5,
              child: CircleAvatar(
                radius: 10,
                child: BlocBuilder<NotificationCubit, NotificationCubitState>(
                  builder: (context, state) {
                    print("StateNotification $state");

                    return Text(
                      "${NotificationCubit.get(context).x}",
                      style: TextStyle(fontSize: 12),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
