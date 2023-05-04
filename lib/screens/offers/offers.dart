import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_bloc.dart';
import 'package:elnasser/widget/no_item_widget.dart';
import 'package:elnasser/widget/product_grid_list.dart';
import 'package:elnasser/widget/search_widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import 'offer_bloc/offer_bloc_state.dart';
import 'offer_bloc/offer_event.dart';

class OffersScreen extends StatelessWidget {
  OffersScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h - (AppBar().preferredSize.height * 2.5),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            SearchWidget(
              colorsValue: colorsValue,
              hideFilter: false,
              isCat: false,
            ),
            SizedBox(
              height: 1.h,
            ),
            BlocConsumer<OfferBloc, OfferBlocState>(
              buildWhen: (prev, current) {
                print("current");
                print(current.status);
                if (prev != current &&
                    (current.status == OfferStatus.refresh ||
                        current.status == OfferStatus.initial ||
                        current.status == OfferStatus.failure ||
                        current.status == OfferStatus.success)) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                print("current${state.status}");
                return SizedBox(
                  height: 100.h - (AppBar().preferredSize.height * 3.5),
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
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1.5));
                        } else if (mode == LoadStatus.loading) {
                          body = Center(
                              child:
                                  CircularProgressIndicator(strokeWidth: 1.5));
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
                      context.read<OfferBloc>().add(OfferReset());
                      await Future.delayed(Duration(seconds: 4));

                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await Future.delayed(Duration(seconds: 0));
                      context.read<OfferBloc>().add(OfferFetch());

                      _refreshController.loadComplete();
                    },
                    child: state.status == OfferStatus.success
                        ? state.productOfferList.isNotEmpty
                            ? ProductGrid(
                                product: state.productOfferList,
                                colorsValue: colorsValue,
                                theInitialModel:
                                    SplashCubit.get(context).theInitialModel,
                              )
                            : NoItemWidget(
                                colorsValue: colorsValue,
                              )
                        : state.status == OfferStatus.initial
                            ? Center(child: CircularProgressIndicator())
                            : state.status == OfferStatus.refresh
                                ? Center(child: CircularProgressIndicator())
                                : Center(
                                    child:
                                        Text("pullToRefresh".tr().toString())),
                  ),
                );
              },
              listener: (context, state) {
                if (state.status == OfferStatus.refresh) {
                  print(state.status);
                  context.read<OfferBloc>().add(OfferFetch());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
