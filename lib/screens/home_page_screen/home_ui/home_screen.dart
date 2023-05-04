// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/home_mop/home_mop.dart';
import 'package:elnasser/screens/home_page_screen/home_ui/home_widget/web_widget/home_web.dart';
import 'package:elnasser/screens/notification/notification_bloc/notification_bloc.dart';
import 'package:elnasser/screens/notification/notification_bloc/notification_cubit.dart';
import 'package:elnasser/screens/orders_screen/Order_screen.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_bloc.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_bloc_state.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_event.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key, required this.theInitialModel}) : super(key: key);
  TheInitialModel? theInitialModel;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  Future<void> fetchNotifiction(BuildContext context) async {
    await Future.delayed(Duration.zero, () {
      NotificationCubit.get(context).getNotification(context);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification remoteNotification = message.notification!;

      final Map<String, dynamic> data = json.decode(message.data["data"]);

      print("message.notification!.body");
      print(message.notification!.titleLocArgs);
      print(message.notification!.android);

      Platform.isAndroid
          ? flutterLocalNotificationsPlugin
              .show(
                  remoteNotification.hashCode,
                  // remoteNotification.title,
                  "Alnasser",
                  EasyLocalization.of(context)!.currentLocale!.languageCode == "en" ? data["en"] : data["ar"],
                  NotificationDetails(
                    android: AndroidNotificationDetails(
                      channel.id,
                      channel.name,
                      color: Colors.blue,
                      playSound: true,
                      priority: Priority.max,
                      icon: '@mipmap/ic_launcher',
                    ),
                  ))
              .whenComplete(() => fetchNotifiction(context))
          : flutterLocalNotificationsPlugin
              .show(
                  remoteNotification.hashCode,
                  // remoteNotification.title,
                  "Alnasser",
                  EasyLocalization.of(context)!.currentLocale!.languageCode == "en" ? data["en"] : data["ar"],
                  NotificationDetails(
                    iOS: IOSNotificationDetails(),
                  ))
              .whenComplete(() => fetchNotifiction(context));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;

      print(message);

      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                actions: [],
                title: Row(
                  children: [
                    Text(notification.title!),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close)),
                  ],
                ),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!),
                      TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                        onPressed: () {
                          context.read<OrderBloc>().emit(OrderBlocState(context: context));
                          // context.read<OrderBloc>().add(OrderReset());
                          context.read<OrderBloc>().add(OrderFetch());
                          Navigator.of(context, rootNavigator: true).pop();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderScreen(colorsValue: widget.theInitialModel!.data!.account!.mobileAppColors!)));
                        },
                        child: Text(
                          "ok".tr().toString(),
                          style: Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    NotificationBloc(context).close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionCubit, InternetState>(builder: (context, state) {
      if (state is InternetDisconnectedState) {
        return NoInterNetWidget();
      } else {
        return Responsive(
          mobile: HomeMobileScreen(
            colorsValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
          ),
          tablet: HomeMobileScreen(
            colorsValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
          ),
          desktop: HomeWebScreen(
            colorsValue: widget.theInitialModel!.data!.account!.websiteColors!,
          ),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        // print('Current internet State $state');
        // SplashCubit.get(context).getInitial(context);
        // HomeMobileCubit.get(context).getData(context);
        // HomeMobileCubit.get(context).getMobileHome(context);
      }
    });
  }
}
