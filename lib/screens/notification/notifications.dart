import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/screens/notification/notification_data_provider/notification_method.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/notification/notification_bloc/notificationEvent.dart';
import 'package:elnasser/screens/notification/notification_bloc/notificationState.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'notification_bloc/notification_bloc.dart';
import 'notification_bloc/notification_cubit.dart';
import 'notification_data_provider/notification_data_provider.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<void> readAll() async {
    Response? response =
        await NotificationDataProvider.readAll(context: context);
    print('Read all Response');
    print(response!.data);
  }

  convertDate(String date) {
    DateTime localDate = DateTime.parse("$date").toLocal();
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse("$localDate").toLocal();
    var inputDate = DateTime.parse(parseDate.toString()).toLocal();
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate).toLocale();
    return outputDate;
  }

  @override
  void didChangeDependencies() {
    Future<void> future;
    Timer(Duration(milliseconds: 100), () {
      future = readAll().whenComplete(() {
        NotificationCubit.get(context).changeCounter();
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<NotificationBloc>()
        .emit(NotificationBlocState(context: context));

    context.read<NotificationBloc>().add(NotificationFetch());
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: CustomText(
              text: "notifications".tr().toString(),
              style: TextStyleConstant.headerText(context, widget.colorsValue),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          body: BlocConsumer<NotificationBloc, NotificationBlocState>(
            buildWhen: (prev, current) =>
                current.status == NotificationStatus.success,
            builder: (context, state) {
              return SmartRefresher(
                physics: BouncingScrollPhysics(),
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (context, mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = state.hasReachedMax == true
                          ? Container()
                          : Center(
                              child:
                                  CircularProgressIndicator(strokeWidth: 1.5));
                    } else if (mode == LoadStatus.loading) {
                      body = Center(
                          child: CircularProgressIndicator(strokeWidth: 1.5));
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: () async {
                  context.read<NotificationBloc>().add(NotificationReset());
                  await Future.delayed(Duration(seconds: 4));

                  _refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await Future.delayed(Duration(seconds: 0));
                  context.read<NotificationBloc>().add(NotificationFetch());

                  _refreshController.loadComplete();
                },
                child: state.status == NotificationStatus.success
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.NotificationList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                {
                                  NotificationMethod().GoTo(
                                      orderId:
                                          "${state.NotificationList[index].data!.data!.orderId}",
                                      type: state
                                          .NotificationList[index].data!.type!,
                                      context: context,
                                      colorsInitialValue: widget.colorsValue);
                                }
                              },
                              child: Container(
                                color: ColorsConstant.getColorBackground5(
                                    widget.colorsValue),
                                height: 15.h,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      height: 8.h,
                                      width: 7.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorsConstant
                                              .getColorBackground3(
                                                  widget.colorsValue)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: ImageView(
                                          fit: BoxFit.cover,
                                          path: ImageConstants.notification,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: SizeDataConstant.customWidth(
                                          context, 1.4),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Spacer(),
                                          NotificationMethod().Title(
                                              type: state
                                                  .NotificationList[index]
                                                  .data!
                                                  .type!,
                                              context: context,
                                              colorValue: widget.colorsValue),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          CustomText(
                                            text:
                                                "${convertDate("${state.NotificationList[index].createdAt}")}",
                                            // "dcvdcv",
                                            style:
                                                TextStyleConstant.bodyTextGrey(
                                                    context,
                                                    widget.colorsValue),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomText(
                                                  text: EasyLocalization.of(
                                                                  context)!
                                                              .currentLocale!
                                                              .languageCode ==
                                                          "en"
                                                      ? "${state.NotificationList[index].data!.data!.en}"
                                                          .replaceAll(
                                                              "NotificationsText.",
                                                              "")
                                                      : "${state.NotificationList[index].data!.data!.ar}",
                                                  style: TextStyleConstant
                                                      .bodyTextGrey(context,
                                                          widget.colorsValue),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : state.status == NotificationStatus.initial
                        ? Center(child: CircularProgressIndicator())
                        : state.status == NotificationStatus.refresh
                            ? Center(child: CircularProgressIndicator())
                            : Center(child: Text("Errro")),
              );
            },
            listener: (context, state) {
              print('State StTE $state');
              if (state.status == NotificationStatus.refresh ||
                  state.status == NotificationStatus.initial) {
                context.read<NotificationBloc>().add(NotificationFetch());

                print(state.status);
              }
            },
          ),
        ),
      ),
    );
  }
}
