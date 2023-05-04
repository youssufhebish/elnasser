import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/best_sales/best_sales_bloc/best_sales_bloc.dart';
import 'package:elnasser/screens/best_sales/best_sales_bloc/best_sales_event.dart';
import 'package:elnasser/screens/best_sales/best_sales_bloc/best_sales_status.dart';
import 'package:elnasser/screens/best_sales/best_seller.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/categories/category_bloc/category_cubit.dart';
import 'package:elnasser/screens/favorite/favorite_bloc/favorite_cubit.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobile_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/new_arrival_screen/new_arrival_bloc/new_arrival_bloc.dart';
import 'package:elnasser/screens/new_arrival_screen/new_arrival_bloc/new_arrival_event.dart';
import 'package:elnasser/screens/new_arrival_screen/new_arrival_bloc/new_arrival_state.dart';
import 'package:elnasser/screens/new_arrival_screen/new_arrival_screen.dart';
import 'package:elnasser/screens/notification/notification_bloc/notification_cubit.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_bloc.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_bloc_state.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_event.dart';
import 'package:elnasser/screens/points_screen/point_bloc/point_cubit.dart';
import 'package:elnasser/screens/special_products_screen/special_products_bloc/special_products_bloc.dart';
import 'package:elnasser/screens/special_products_screen/special_products_bloc/special_products_event.dart';
import 'package:elnasser/screens/special_products_screen/special_products_bloc/special_products_state.dart';
import 'package:elnasser/screens/special_products_screen/special_products_screen.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/image.dart';
import 'package:elnasser/widget/search_widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import 'banner_section_widget.dart';
import 'home_categorye.dart';
import 'home_product_section.dart';
import 'home_slider.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeMopScreenWidget extends StatelessWidget {
  HomeMopScreenWidget({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeMobileCubit, HomeMobileState>(
      /// use buildWhen to determine when you would build this widget

      buildWhen: (prev, current) =>
          prev != current && current is HomeMobileSuccessState,

      builder: (context, state) {
        if (state is HomeMobileLoadingState) {
          /// your loading widget
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeMobileSuccessState) {
          return SizedBox(
            height: 100.h - (AppBar().preferredSize.height * 2.5),
            width: SizeDataConstant.fullWidth(context),
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
                            child: CircularProgressIndicator(strokeWidth: 1.5));
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
                await Future.delayed(Duration(seconds: 2));
                HomeMobileCubit.get(context).getMobileHome(context);

                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                await Future.delayed(Duration(seconds: 0));
                // context.read<BestSalesBloc>().add(BestSalesFetch());

                _refreshController.loadComplete();
              },
              child: ListView(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  SearchWidget(
                    isCat: false,
                    colorsValue: colorsValue,
                    hideFilter: true,
                  ),
                  SizedBox(
                    height: 2.h,
                  ), // Text("${HomeCubit.get(context).theInitialModel.data?.account?.accountsCountry}",style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.red) )
                  HomePageSlider(
                    advertisements: HomeMobileCubit.get(context)
                        .homeModel
                        .data!
                        .advertisements,
                    colorsValue: colorsValue,
                    theInitialModel: SplashCubit.get(context).theInitialModel,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  HomeMobileCubit.get(context)
                          .homeModel
                          .data!
                          .categories!
                          .isNotEmpty
                      ? HomeCategory(
                          category: HomeMobileCubit.get(context)
                              .homeModel
                              .data!
                              .categories!,
                          colorsValue: colorsValue,
                        )
                      : Container(),
                  HomeMobileCubit.get(context)
                          .homeModel
                          .data!
                          .categories!
                          .isNotEmpty
                      ? const Divider()
                      : Container(),
                  HomeMobileCubit.get(context)
                          .homeModel
                          .data!
                          .bestSales!
                          .isNotEmpty
                      ? HomeProductSection(
                          colorsValue: colorsValue,
                          type: "bestSale",
                          sectionName: "bestSeller".tr().toString(),
                          productList: HomeMobileCubit.get(context)
                              .homeModel
                              .data!
                              .bestSales,
                          theInitialModel:
                              SplashCubit.get(context).theInitialModel,
                          onTap: () {
                            context
                                .read<BestSalesBloc>()
                                .emit(BestSalesBlocState(context: context));

                            context.read<BestSalesBloc>().add(BestSalesFetch());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BestSalesScreen(
                                          theInitialModel:
                                              SplashCubit.get(context)
                                                  .theInitialModel,
                                          colorsValue: colorsValue,
                                        )));
                          },
                        )
                      : Container(),
                  SizedBox(
                    height: 2.h,
                  ),

                  HomeMobileCubit.get(context).homeModel.data!.advertisements !=
                          null
                      ? BannerSectionWidget(
                          bannersList: HomeMobileCubit.get(context)
                              .homeModel
                              .data!
                              .advertisements!
                              .sectionalBanners,
                          colorsValue: colorsValue,
                          theInitialModel:
                              SplashCubit.get(context).theInitialModel,
                        )
                      : Container(),

                  SizedBox(
                    height: 2.h,
                  ),
                  HomeMobileCubit.get(context)
                          .homeModel
                          .data!
                          .lastArrivedProducts!
                          .isNotEmpty
                      ? HomeProductSection(
                          colorsValue: colorsValue,
                          type: "newArrivals",
                          sectionName: "newArrivals".tr().toString(),
                          productList: HomeMobileCubit.get(context)
                              .homeModel
                              .data!
                              .lastArrivedProducts,
                          theInitialModel:
                              SplashCubit.get(context).theInitialModel,
                          onTap: () {
                            context
                                .read<NewArrivalBloc>()
                                .emit(NewArrivalBlocState(context: context));

                            context
                                .read<NewArrivalBloc>()
                                .add(NewArrivalFetch());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewArrivalScreen(
                                          theInitialModel:
                                              SplashCubit.get(context)
                                                  .theInitialModel,
                                          colorsValue: colorsValue,
                                        )));
                          },
                        )
                      : Container(),
                  SizedBox(
                    height: 2.h,
                  ),

                  HomeMobileCubit.get(context)
                              .homeModel
                              .data!
                              .advertisements!
                              .homeCenter !=
                          null
                      ? SizedBox(
                          height: 30.h,
                          width: SizeDataConstant.fullWidth(context),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: HomeMobileCubit.get(context)
                                .homeModel
                                .data!
                                .advertisements!
                                .homeCenter!
                                .length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    height: 30.h,
                                    width: SizeDataConstant.customWidth(
                                        context, 1.04),
                                    child: InkWell(
                                        onTap: () {
                                          SharedMethods.goForwardMethod(
                                              context: context,
                                              colorsValue: colorsValue,
                                              theInitialModel:
                                                  SplashCubit.get(context)
                                                      .theInitialModel,
                                              type: HomeMobileCubit.get(context)
                                                  .homeModel
                                                  .data!
                                                  .advertisements!
                                                  .homeCenter![index]
                                                  .advertisementsType,
                                              value:
                                                  HomeMobileCubit.get(context)
                                                      .homeModel
                                                      .data!
                                                      .advertisements!
                                                      .homeCenter![index]
                                                      .advertisementsValue,
                                              url: HomeMobileCubit.get(context)
                                                  .homeModel
                                                  .data!
                                                  .advertisements!
                                                  .homeCenter![index]
                                                  .advertisementsUrl);
                                        },
                                        child: ApiImage(
                                          folderName: "advertisements",
                                          type: "original",
                                          image: HomeMobileCubit.get(context)
                                              .homeModel
                                              .data!
                                              .advertisements!
                                              .homeCenter![index]
                                              .advertisementsMobileImg,
                                          borderRadius: 0,
                                        ))),
                              );
                            },
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 2.h,
                  ),
                  HomeMobileCubit.get(context)
                          .homeModel
                          .data!
                          .homeProducts!
                          .isNotEmpty
                      ? HomeProductSection(
                          colorsValue: colorsValue,
                          type: "",
                          sectionName:
                              "${SplashCubit.get(context).theInitialModel.data!.setting!.homeProductsTitle}",
                          productList: HomeMobileCubit.get(context)
                              .homeModel
                              .data!
                              .homeProducts,
                          onTap: () {
                            context.read<SpecialProductsBloc>().emit(
                                SpecialProductsBlocState(context: context));
                            context
                                .read<SpecialProductsBloc>()
                                .add(SpecialProductsReset());
                            context
                                .read<SpecialProductsBloc>()
                                .add(SpecialProductsFetch());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpecialProductScreen(
                                          theInitialModel:
                                              SplashCubit.get(context)
                                                  .theInitialModel,
                                          colorsValue: colorsValue,
                                        )));
                          },
                          theInitialModel:
                              SplashCubit.get(context).theInitialModel,
                        )
                      : Container(),

                  SizedBox(
                    height: 2.h,
                  ),

                  HomeMobileCubit.get(context)
                              .homeModel
                              .data!
                              .advertisements!
                              .homeEnd !=
                          null
                      ? SizedBox(
                          height: 30.h,
                          width: SizeDataConstant.fullWidth(context),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: HomeMobileCubit.get(context)
                                .homeModel
                                .data!
                                .advertisements!
                                .homeEnd!
                                .length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    SharedMethods.goForwardMethod(
                                        context: context,
                                        colorsValue: colorsValue,
                                        theInitialModel:
                                            SplashCubit.get(context)
                                                .theInitialModel,
                                        type: HomeMobileCubit.get(context)
                                            .homeModel
                                            .data!
                                            .advertisements!
                                            .homeEnd![index]
                                            .advertisementsType,
                                        value: HomeMobileCubit.get(context)
                                            .homeModel
                                            .data!
                                            .advertisements!
                                            .homeEnd![index]
                                            .advertisementsValue,
                                        url: HomeMobileCubit.get(context)
                                            .homeModel
                                            .data!
                                            .advertisements!
                                            .homeEnd![index]
                                            .advertisementsUrl);
                                  },
                                  child: SizedBox(
                                      height: 30.h,
                                      width: SizeDataConstant.customWidth(
                                          context, 1.04),
                                      child: ApiImage(
                                        folderName: "advertisements",
                                        type: "original",
                                        image: HomeMobileCubit.get(context)
                                            .homeModel
                                            .data!
                                            .advertisements!
                                            .homeEnd![index]
                                            .advertisementsMobileImg,
                                        borderRadius: 0,
                                      )),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          );
        } else {
          ///   write your error widget
          return Center(
            child: SizedBox(
              width: SizeDataConstant.customWidth(context, 2),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is HomeMobileSuccessState) {
          context.read<OfferBloc>().emit(OfferBlocState(context: context));

          context.read<OfferBloc>().add(OfferFetch());

          AddToCartCubit.get(context).getCart(context: context);

          if (HomeMobileCubit.get(context).isUserLogin == true) {
            NotificationCubit.get(context).getNotification(context);

            AddressCubit.get(context).getAddressAndPaymentMethods(context);
            PointCubit.get(context).getPoints(context);
            // FavoriteCubit.get(context).getFavorite(context: context);
            if (HomeMobileCubit.get(context).homeModel.data!.orderRating == 1) {
              DataErrorAlert.RateOrder(
                  colorValue: colorsValue,
                  orderDetailsModel:
                      HomeMobileCubit.get(context).homeModel.data!.order!,
                  context: context);
            }
          }
        }

        /// make an action according to the state you want
      },
    );
  }
}
