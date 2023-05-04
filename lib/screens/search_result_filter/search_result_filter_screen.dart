import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
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
import 'search_result_bloc/search_result_filter_bloc.dart';
import 'search_result_bloc/search_result_bloc_filter_state.dart';
import 'search_result_bloc/search_result_filter_event.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchResultFilterScreen extends StatelessWidget {
  SearchResultFilterScreen(
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
                    Navigator.pop(context);
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
                      colorsValue: colorsValue,
                      filterScreen: true,
                      searchTitleScreen: true,
                      hideFilter: false,
                      searchFilter: true,
                      isCat: true,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocConsumer<SearchResultBloc, SearchResultBlocState>(
                      buildWhen: (prev, current) {
                        if (prev != current &&
                            (current.status == SearchResultStatus.refresh ||
                                current.status == SearchResultStatus.failure ||
                                current.status == SearchResultStatus.success)) {
                          return true;
                        } else {
                          return false;
                        }
                      },
                      builder: (context, state) {
                        print('Search Result State $state');
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
                              x = 0;
                              context
                                  .read<SearchResultBloc>()
                                  .add(SearchResultReset());
                              await Future.delayed(Duration(seconds: 4));

                              _refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await Future.delayed(Duration(seconds: 0));
                              context
                                  .read<SearchResultBloc>()
                                  .add(SearchResultFetchFilter());

                              _refreshController.loadComplete();
                            },
                            child: (state.status ==
                                        SearchResultStatus.success &&
                                    state.prdouctSearchResultList.isNotEmpty)
                                ? ProductGrid(
                                    product: state.prdouctSearchResultList,
                                    colorsValue: colorsValue,
                                    theInitialModel: theInitialModel,
                                  )
                                : (state.status == SearchResultStatus.success &&
                                        state.prdouctSearchResultList.isEmpty)
                                    ? NoItemWidget(
                                        colorsValue: colorsValue,
                                      )
                                    : Center(
                                        child: CircularProgressIndicator()),
                          ),
                        );
                      },
                      listener: (context, state) {
                        if (state.status == SearchResultStatus.success) {
                          x = 0;
                        }
                        if (state.status == SearchResultStatus.refresh) {
                          x++;
                          context
                              .read<SearchResultBloc>()
                              .add(SearchResultFetchFilter());
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
        //     .read<SearchResultBloc>()
        //     .add(SearchResultReset());
        // context
        //     .read<SearchResultBloc>()
        //     .add(SearchResultFetchFilter());
      }
    });
  }
}
