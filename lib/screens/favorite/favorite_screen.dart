import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_cubit.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_state.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/no_item_widget.dart';
import 'package:elnasser/widget/product_grid_list.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: CustomText(
            text: "myFavorites".tr().toString(),
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              BlocConsumer<FavoriteCubit, FavoriteState>(
                buildWhen: (rev, current) =>
                    rev != current && current is FavoriteStateGetSuccess,
                builder: (context, state) {
                  print(state);
                  if (state is FavoriteStateGetSuccess) {
                    return SizedBox(
                      height: 100.h - (AppBar().preferredSize.height),
                      child: SmartRefresher(
                        physics: BouncingScrollPhysics(),
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropHeader(),
                        footer: CustomFooter(
                          builder: (context, mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = true == true
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
                          await Future.delayed(Duration(seconds: 1));
                          FavoriteCubit.get(context)
                              .getFavorite(context: context);
                          _refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await Future.delayed(Duration(seconds: 0));

                          _refreshController.loadComplete();
                        },
                        child: FavoriteCubit.get(context)
                                .favoriteModel
                                .data!
                                .favs!
                                .isNotEmpty
                            ? ProductGrid(
                                product: FavoriteCubit.get(context)
                                    .favoriteModel
                                    .data!
                                    .favs!,
                                colorsValue: colorsValue,
                                theInitialModel:
                                    SplashCubit.get(context).theInitialModel,
                              )
                            : NoItemWidget(
                                colorsValue: colorsValue,
                              ),
                      ),
                    );
                  } else if (state is FavoriteStateGetLoading) {
                    return SizedBox(
                      height: 80.h,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return SizedBox(
                        height: 80.h,
                        child: Center(
                            child: NoItemWidget(colorsValue: colorsValue)));
                  }
                },
                listener: (context, state) {
                  if (state is FavoriteStateAddingSuccess) {
                    HomeMobileCubit.get(context).getMobileHome(context);
                    // FavoriteCubit.get(context).getFavorite(context: context);
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
