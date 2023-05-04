import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/home_model.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/routing/pagination.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_cubit.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_state.dart';
import 'package:elnasser/screens/best_sales/best_sales_bloc/best_sales_bloc.dart';
import 'package:elnasser/screens/best_sales/best_sales_bloc/best_sales_event.dart';
import 'package:elnasser/screens/best_sales/best_sales_bloc/best_sales_status.dart';
import 'package:elnasser/screens/best_sales/best_seller.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/new_arrival_screen/new_arrival_bloc/new_arrival_bloc.dart';
import 'package:elnasser/screens/new_arrival_screen/new_arrival_bloc/new_arrival_event.dart';
import 'package:elnasser/screens/new_arrival_screen/new_arrival_bloc/new_arrival_state.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/product_details_suggestion_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_screen.dart';
import 'package:elnasser/widget/card/card_mop.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeProductSection extends StatelessWidget {
  HomeProductSection(
      {Key? key,
      required this.colorsValue,
      required this.sectionName,
      required this.productList,
      required this.theInitialModel,
      required this.onTap,
      required this.type})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String sectionName;
  final List<ProductClass>? productList;
  final TheInitialModel theInitialModel;
  final String type;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
        buildWhen: (prev, current) => current is FavoriteStateGetSuccess,
        builder: (context, state) {
          print('Product Section Current State $state');
          return SizedBox(
              height: 50.h,
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            text: sectionName,
                            style: TextStyleConstant.headerText(
                                context, colorsValue),
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: onTap,
                              child: CustomText(
                                text: "seeAll".tr().toString(),
                                style: TextStyleConstant.lightText(
                                    context, colorsValue),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 7,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: productList!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () {
                                  // PageNavigationNoRout(child: const ProductDetailsScreen());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsScreen(
                                                product: productList![index],
                                                theInitialModel:
                                                    theInitialModel,
                                                colorsValue: colorsValue,
                                              )));
                                  ProductDetailsSuggestionCubit.get(context)
                                      .productIds
                                      .add(productList![index].productsId!);
                                  ProductDetailsSuggestionCubit.get(context)
                                      .getProductDetails(context);
                                },
                                child: ProductCardMop(
                                  colorsValue: colorsValue,
                                  product: productList![index],
                                  type: type,
                                )),
                          );
                        },
                      )),
                ],
              ));
        },
        listener: (context, state) {
          if (state is FavoriteStateAddingSuccess) {
            HomeMobileCubit.get(context).getMobileHome(context);
            FavoriteCubit.get(context).getFavorite(context: context);
          }
        });
  }
}
