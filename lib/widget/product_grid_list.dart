import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/product_details_suggestion_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_screen.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'card/card_mop.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid(
      {Key? key,
      required this.colorsValue,
      required this.product,
      required this.theInitialModel})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final TheInitialModel theInitialModel;
  List<ProductClass> product;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    print('SizeOf tablet ${MediaQuery.of(context).size.width}');
    print('SizeOf tablet ${45.h}');
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: product.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (orientation == Orientation.landscape &&
                Responsive.isTablet(context))
            ? 4
            : (orientation == Orientation.portrait &&
                    Responsive.isTablet(context))
                ? 3
                : 2,
        childAspectRatio: 3 / 4.3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Material(
          child: InkWell(
            onTap: () {
              AddToCartCubit.get(context).resetData();

              ProductDetailsSuggestionCubit.get(context)
                  .productIds
                  .add(product[index].productsId!);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                            product: product[index],
                            theInitialModel: theInitialModel,
                            colorsValue: colorsValue,
                          )));
              ProductDetailsSuggestionCubit.get(context)
                  .getProductDetails(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductCardMop(
                  colorsValue: colorsValue, product: product[index]),
            ),
          ),
        );
      },
    );
  }
}
