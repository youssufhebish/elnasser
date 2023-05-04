import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/products_page_navigation_model/products_page_navigation_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_cubit.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_state.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/no_item_widget.dart';
import 'package:elnasser/widget/product_grid_list.dart';
import 'package:elnasser/widget/search_widget/search_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'special_products_bloc/special_products_bloc.dart';
import 'special_products_bloc/special_products_event.dart';
import 'special_products_bloc/special_products_state.dart';

class SpecialProductScreen extends StatelessWidget {
  SpecialProductScreen(
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
                  text:
                      "${SplashCubit.get(context).theInitialModel.data!.setting!.homeProductsTitle}",
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
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SearchWidget(
                      isCat: false,
                      colorsValue: colorsValue,
                      hideFilter: false,
                    ),
                  ),
                ),
              ),
              body: BlocConsumer<SpecialProductsBloc, SpecialProductsBlocState>(
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
                      context
                          .read<SpecialProductsBloc>()
                          .add(SpecialProductsReset());
                      await Future.delayed(Duration(seconds: 4));

                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await Future.delayed(Duration(seconds: 0));
                      context
                          .read<SpecialProductsBloc>()
                          .add(SpecialProductsFetch());

                      _refreshController.loadComplete();
                    },
                    child: (state.status == SpecialProductsStatus.success &&
                            state.specialProductList.isNotEmpty)
                        ? BlocConsumer<FavoriteCubit, FavoriteState>(
                            buildWhen: (prev, current) =>
                                current is FavoriteStateGetSuccess,
                            builder: (context, state) {
                              return ProductGrid(
                                product: context
                                    .read<SpecialProductsBloc>()
                                    .state
                                    .specialProductList,
                                colorsValue: colorsValue,
                                theInitialModel: theInitialModel,
                              );
                            },
                            listener: (context, state) {
                              if (state is FavoriteStateAddingSuccess) {
                                HomeMobileCubit.get(context)
                                    .getMobileHome(context);
                                // context.read<BestSalesBloc>().add(BestSalesReset());
                                context
                                    .read<SpecialProductsBloc>()
                                    .add(SpecialProductsFetch());
                              }
                            })
                        : (state.status == SpecialProductsStatus.success &&
                                state.specialProductList.isEmpty)
                            ? NoItemWidget(
                                colorsValue: colorsValue,
                              )
                            : Center(child: CircularProgressIndicator()),
                  );
                },
                listener: (context, state) {
                  if (state.status == SpecialProductsStatus.success) {
                    x = 0;
                  }
                  if (state.status == SpecialProductsStatus.refresh) {
                    print(state.status);
                    x++;
                    context
                        .read<SpecialProductsBloc>()
                        .add(SpecialProductsFetch());
                    if (x == 2) {}
                  }
                },
              ),
            ),
          ),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        // context.read<SpecialProductsBloc>().add(SpecialProductsReset());
        // context.read<SpecialProductsBloc>().add(SpecialProductsFetch());
      }
    });
  }
}
