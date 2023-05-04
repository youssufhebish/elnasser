import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/wallet/wallet_widget/wallet_wave_two.dart';
import 'package:elnasser/widget/cart_ounter_widget.dart';
import 'package:elnasser/widget/no_item_widget.dart';
import 'package:elnasser/widget/notificationCounter.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import 'wallet_bloc/wallet_bloc.dart';
import 'wallet_bloc/wallet_bloc_state.dart';
import 'wallet_bloc/wallet_event.dart';
import 'wallet_widget/wallet_item.dart';
import 'wallet_widget/wallet_wave_one.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState

    context.read<WalletBloc>().emit(WalletBlocState(context: context));
    context.read<WalletBloc>().add(WalletReset());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool showNoItem = false;
    int x = 0;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor:
              ColorsConstant.getColorBackground3(widget.colorsValue),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: CustomText(
              text: "wallet".tr().toString(),
              style: TextStyleConstant.bodyTextWhiteBold(
                  context, widget.colorsValue),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                // ProductDetailsSuggestionCubit.get(context).getProductDetails(context, product!.productsId!);
              },
            ),
          ),
          body: BlocConsumer<WalletBloc, WalletBlocState>(
            buildWhen: (prev, current) {
              print("current");
              print(current.status);
              if (prev != current && (current.status == WalletStatus.success)) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if (state.status == WalletStatus.success) {
                return state.walletModel!.data != null
                    ? Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 25.h,
                                width: SizeDataConstant.fullWidth(context),
                                color: ColorsConstant.getColorBackground3(
                                    widget.colorsValue),
                                child: Column(
                                  children: [
                                    Spacer(),
                                    CustomText(
                                      text:
                                          "${state.walletModel!.data!.customersWallet} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                                      style: TextStyleConstant
                                          .headerTextLargeWhite(
                                              context, widget.colorsValue),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  child: CustomPaint(
                                    size: Size(
                                        SizeDataConstant.fullWidth(context),
                                        (400 * 0.5833333333333334)
                                            .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                    painter: WaveOne(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  child: CustomPaint(
                                    size: Size(
                                        SizeDataConstant.fullWidth(context),
                                        (400 * 0.5833333333333334)
                                            .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                    painter: WaveTwo(),
                                  ),
                                ),
                              ),
                              EasyLocalization.of(context)!
                                          .currentLocale!
                                          .languageCode ==
                                      "en"
                                  ? Positioned(
                                      left: 16,
                                      top: 10.h,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomText(
                                            text: "myBalance".tr().toString(),
                                            style: TextStyleConstant
                                                .headerTextLargeWhite(context,
                                                    widget.colorsValue),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Positioned(
                                      right: 16,
                                      top: 10.h,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomText(
                                            text: "myBalance".tr().toString(),
                                            style: TextStyleConstant
                                                .headerTextLargeWhite(context,
                                                    widget.colorsValue),
                                          ),
                                        ),
                                      ),
                                    ),
                              // Positioned(
                              //   left: 16,
                              //   top: 14.5.h,
                              //   child: Container(
                              //     width: 35,
                              //       height: 3,
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(8)
                              //
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Expanded(
                              child: Container(
                            padding:
                                EdgeInsets.only(left: 16, right: 16, top: 0),
                            width: SizeDataConstant.fullWidth(context),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  height: 100.h -
                                      (AppBar().preferredSize.height + 33.5.h),
                                  child: SmartRefresher(
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
                                                      CircularProgressIndicator(
                                                          strokeWidth: 1.5));
                                        } else if (mode == LoadStatus.loading) {
                                          body = Center(
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 1.5));
                                        } else if (mode == LoadStatus.failed) {
                                          body =
                                              Text("Load Failed!Click retry!");
                                        } else {
                                          body = Text("No more Data");
                                        }
                                        return Center(child: body);
                                      },
                                    ),
                                    controller: _refreshController,
                                    onRefresh: () async {
                                      context
                                          .read<WalletBloc>()
                                          .add(WalletReset());
                                      await Future.delayed(
                                          Duration(seconds: 4));

                                      _refreshController.refreshCompleted();
                                    },
                                    onLoading: () async {
                                      await Future.delayed(
                                          Duration(seconds: 0));
                                      context
                                          .read<WalletBloc>()
                                          .add(WalletFetch());

                                      _refreshController.loadComplete();
                                    },
                                    child: (state.status ==
                                                WalletStatus.success &&
                                            state.clientOperations.isNotEmpty)
                                        ? WalletWidgetItem(
                                            colorsValue: widget.colorsValue,
                                            clientOperations:
                                                state.clientOperations,
                                          )
                                        : (showNoItem == true &&
                                                state.clientOperations.isEmpty)
                                            ? Container(
                                                width:
                                                    SizeDataConstant.fullWidth(
                                                        context),
                                                height: 88.h,
                                                color: Colors.white,
                                                child: Center(
                                                    child: CustomText(
                                                  text: "noOperationNow"
                                                      .tr()
                                                      .toString(),
                                                  style: TextStyleConstant
                                                      .bodyTextLarge(context,
                                                          widget.colorsValue),
                                                )),
                                              )
                                            : Container(
                                                width:
                                                    SizeDataConstant.fullWidth(
                                                        context),
                                                height: 88.h,
                                                color: Colors.white,
                                                child: Center(
                                                    child: CustomText(
                                                  text: "noOperationNow"
                                                      .tr()
                                                      .toString(),
                                                  style: TextStyleConstant
                                                      .bodyTextLarge(context,
                                                          widget.colorsValue),
                                                )),
                                              ),
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: SizeDataConstant.fullWidth(context),
                            height: 88.h,
                            color: Colors.white,
                            child: Center(
                                child: CustomText(
                              text: "noOperationNow".tr().toString(),
                              style: TextStyleConstant.bodyTextLarge(
                                  context, widget.colorsValue),
                            )),
                          ),
                        ],
                      );
              } else {
                return Container(
                  width: SizeDataConstant.fullWidth(context),
                  height: 100.h,
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
            listener: (context, state) {
              if (state.status == WalletStatus.success) {
                x = 0;
              }
              if (state.status == WalletStatus.refresh) {
                print(state.status);
                x++;
                context.read<WalletBloc>().add(WalletFetch());
                if (x == 2) {
                  state.clientOperations.isEmpty
                      ? showNoItem = true
                      : showNoItem = false;
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
