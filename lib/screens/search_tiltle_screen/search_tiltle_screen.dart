import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/no_item_widget.dart';
import 'package:elnasser/widget/product_grid_list.dart';
import 'package:elnasser/widget/search_widget/search_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import 'search_tiltle_bloc/search_tiltle_bloc.dart';
import 'search_tiltle_bloc/search_tiltle_bloc_event.dart';
import 'search_tiltle_bloc/search_tiltle_bloc_state.dart';

class SearchTitleResult extends StatelessWidget {
  SearchTitleResult(
      {Key? key, required this.colorsValue, required this.theInitialModel})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    int x = 0;

    return BlocConsumer<ConnectionCubit, InternetState>(
        builder: (context, state) {
      print('Current State $state');
      if (state is InternetDisconnectedState) {
        return NoInterNetWidget();
      } else {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                title: CustomText(
                  text: "searchResult".tr().toString(),
                  style: TextStyleConstant.headerText(context, colorsValue),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SearchWidget(
                      isCat: false,
                      colorsValue: colorsValue,
                      filterScreen: false,
                      searchTitleScreen: true,
                      hideFilter: false,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocConsumer<SearchResultTitleBloc,
                        SearchResultTitleBlocState>(
                      buildWhen: (prev, current) {
                        print("current");
                        print(current.status);
                        if (prev != current &&
                            (current.status ==
                                    SearchResultTitleStatus.refresh ||
                                current.status ==
                                    SearchResultTitleStatus.failure ||
                                current.status ==
                                    SearchResultTitleStatus.success)) {
                          return true;
                        } else {
                          return false;
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 100.h - (AppBar().preferredSize.height * 2.5),
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
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.5));
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
                              context
                                  .read<SearchResultTitleBloc>()
                                  .add(SearchResultTitleReset());
                              await Future.delayed(Duration(seconds: 4));

                              _refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await Future.delayed(Duration(seconds: 0));
                              context
                                  .read<SearchResultTitleBloc>()
                                  .add(SearchResultTitleFetch());

                              _refreshController.loadComplete();
                            },
                            child: (state.status ==
                                        SearchResultTitleStatus.success &&
                                    state.productSearchResultTitleList
                                        .isNotEmpty)
                                ? ProductGrid(
                                    product: state.productSearchResultTitleList,
                                    colorsValue: colorsValue,
                                    theInitialModel: theInitialModel,
                                  )
                                : (state.status ==
                                            SearchResultTitleStatus.success &&
                                        state.productSearchResultTitleList
                                            .isEmpty)
                                    ? NoItemWidget(
                                        colorsValue: colorsValue,
                                      )
                                    : Center(
                                        child: CircularProgressIndicator()),
                          ),
                        );
                      },
                      listener: (context, state) {
                        if (state.status == SearchResultTitleStatus.success) {
                          x = 0;
                        }
                        if (state.status == SearchResultTitleStatus.refresh) {
                          print(state.status);
                          x++;
                          context
                              .read<SearchResultTitleBloc>()
                              .add(SearchResultTitleFetch());
                          if (x == 2) {}
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        // context
        //     .read<SearchResultTitleBloc>()
        //     .add(SearchResultTitleReset());
        // context
        //     .read<SearchResultTitleBloc>()
        //     .add(SearchResultTitleFetch());
      }
    });
  }
}
