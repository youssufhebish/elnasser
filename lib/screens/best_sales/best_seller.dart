import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_cubit.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_state.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/product_grid_list.dart';
import 'package:elnasser/widget/search_widget/search_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';
import 'best_sales_bloc/best_sales_bloc.dart';
import 'best_sales_bloc/best_sales_event.dart';
import 'best_sales_bloc/best_sales_status.dart';

class BestSalesScreen extends StatelessWidget {
  BestSalesScreen(
      {Key? key, required this.colorsValue, required this.theInitialModel})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
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
                  text: "bestSeller".tr().toString(),
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
                      colorsValue: colorsValue,
                      isCat: false,
                      hideFilter: false,
                    ),
                  ),
                ),
              ),
              body: BlocConsumer<BestSalesBloc, BestSalesBlocState>(
                buildWhen: (prev, current) =>
                    current.status == BestSalesStatus.success,
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
                      context.read<BestSalesBloc>().add(BestSalesReset());
                      await Future.delayed(Duration(seconds: 4));

                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await Future.delayed(Duration(seconds: 0));
                      context.read<BestSalesBloc>().add(BestSalesFetch());

                      _refreshController.loadComplete();
                    },
                    child: (state.status == BestSalesStatus.success &&
                            state.bestSalesList.isNotEmpty)
                        ? BlocConsumer<FavoriteCubit, FavoriteState>(
                            buildWhen: (prev, current) =>
                                current is FavoriteStateGetSuccess,
                            builder: (context, state) {
                              return ProductGrid(
                                product: context
                                    .read<BestSalesBloc>()
                                    .state
                                    .bestSalesList,
                                colorsValue: colorsValue,
                                theInitialModel: theInitialModel,
                              );
                            },
                            listener: (context, state) {
                              if (state is FavoriteStateAddingSuccess) {}
                            })
                        : state.status == BestSalesStatus.initial
                            ? Center(child: CircularProgressIndicator())
                            : state.status == BestSalesStatus.refresh
                                ? Center(child: CircularProgressIndicator())
                                : Center(child: Text("Errro")),
                  );
                },
                listener: (context, state) {
                  if (state.status == BestSalesStatus.refresh) {
                    context.read<BestSalesBloc>().add(BestSalesFetch());
                  }
                },
              ),
            ),
          ),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        //  context.read<NewArrivalBloc>().emit(NewArrivalBlocState(context: context));
        //  context.read<NewArrivalBloc>().add(NewArrivalReset());
        //  context.read<NewArrivalBloc>().add(NewArrivalFetch());
        //  HomeCubit.get(context).getData();
        // HomeMobileCubit.get(context).getData(context);
        // HomeMobileCubit.get(context).getMobileHome(context);
      }
    });
  }
}
