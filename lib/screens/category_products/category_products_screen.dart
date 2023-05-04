import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/category_products/category_products_bloc/category_products_bloc.dart';
import 'package:elnasser/screens/category_products/category_products_bloc/category_products_bloc_event.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/no_item_widget.dart';
import 'package:elnasser/widget/product_grid_list.dart';
import 'package:elnasser/widget/search_widget/search_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'category_products_bloc/category_products_bloc_state.dart';
import 'category_products_bloc/category_products_cubit.dart';

class CategoryProductsScreen extends StatelessWidget {
  CategoryProductsScreen(
      {Key? key, required this.colorsValue, required this.theInitialModel})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    bool showNoItem = false;
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
                  text: "${CategoryProductsCubit.get(context).vale}",
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
                child: BlocConsumer<CategoryProductsBloc,
                    CategoryProductsBlocState>(
                  buildWhen: (prev, current) {
                    print('Current State $state');
                    print(current.status);
                    if (prev != current &&
                        (current.status == CategoryProductsStatus.refresh ||
                            current.status == CategoryProductsStatus.failure ||
                            current.status == CategoryProductsStatus.success)) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      height: 100.h - (AppBar().preferredSize.height * 1.8),
                      child: Column(
                        children: [
                          SearchWidget(
                            colorsValue: colorsValue,
                            filterScreen: true,
                            searchTitleScreen: true,
                            hideFilter: false,
                            isCat: true,
                          ),
                          // SizedBox(height: 2.h,),
                          Container(
                            height: 0,
                            color: Colors.green,
                          ),
                          Expanded(
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
                                  .read<CategoryProductsBloc>()
                                  .add(CategoryProductsReset());
                              await Future.delayed(Duration(seconds: 4));
                              x = 0;
                              _refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await Future.delayed(Duration(seconds: 0));
                              context
                                  .read<CategoryProductsBloc>()
                                  .add(CategoryProductsFetch());

                              _refreshController.loadComplete();
                            },
                            child: (state.status ==
                                        CategoryProductsStatus.success &&
                                    state.categoryProductsList.isEmpty)
                                ? NoItemWidget(
                                    colorsValue: colorsValue,
                                  )
                                : (state.status ==
                                            CategoryProductsStatus.success &&
                                        state.categoryProductsList.isNotEmpty)
                                    ? ProductGrid(
                                        product: state.categoryProductsList,
                                        colorsValue: colorsValue,
                                        theInitialModel: theInitialModel,
                                      )
                                    : Center(
                                        child: CircularProgressIndicator()),
                          ))
                        ],
                      ),
                    );
                  },
                  listener: (context, state) {
                    print('Your State ${state}');
                    if (state.status == CategoryProductsStatus.success) {
                      x = 0;
                    }
                    if (state.status == CategoryProductsStatus.refresh) {
                      x++;
                      context
                          .read<CategoryProductsBloc>()
                          .add(CategoryProductsFetch());
                      if (x == 2) {}
                    }
                  },
                ),
              ),
            ),
          ),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        // context
        //     .read<CategoryProductsBloc>()
        //     .emit(CategoryProductsBlocState(context: context));
        // context.read<CategoryProductsBloc>().add(CategoryProductsReset());
        // context.read<CategoryProductsBloc>().add(CategoryProductsFetch());
      }
    });
  }
}
