import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/models/cart_model/cart_model.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:elnasser/screens/cart/cart_screen.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'alert.dart';
import 'image_widget.dart';

class CartCounterWidget extends StatelessWidget {
  CartCounterWidget({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (SplashCubit.get(context).theInitialModel.data!.setting!.stopOrder ==
            "0") {
          DataErrorAlert.showError(
              data: SplashCubit.get(context)
                  .theInitialModel
                  .data!
                  .setting!
                  .stopOrderMsg!,
              title: "",
              colorValue: colorsValue,
              context: context);
        } else {
          AddToCartCubit.get(context).getCart(context: context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CartScreen(
                        colorsValue: colorsValue,
                      )));
        }
      },
      child: Container(
        width: 50,
        height: AppBar().preferredSize.height,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    print(
                        "object ${SplashCubit.get(context).theInitialModel.data!.setting!.stopOrder}");
                    if (SplashCubit.get(context)
                            .theInitialModel
                            .data!
                            .setting!
                            .stopOrder ==
                        "0") {
                      DataErrorAlert.showError(
                          data: SplashCubit.get(context)
                              .theInitialModel
                              .data!
                              .setting!
                              .stopOrderMsg!,
                          title: "",
                          colorValue: colorsValue,
                          context: context);
                    } else {
                      AddToCartCubit.get(context).getCart(context: context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen(
                                    colorsValue: colorsValue,
                                  )));
                    }
                  },
                  icon: ImageView(
                    path: ImageConstants.cart,
                    color: ColorsConstant.getColorText1(colorsValue),
                    fit: BoxFit.scaleDown,
                    width: 15.w,
                    height: 6.h,
                  ),
                )),
            Positioned(
              top: 10,
              left: 5,
              child: CircleAvatar(
                radius: 10,
                child: BlocBuilder<AddToCartCubit, AddToCartState>(
                  buildWhen: (prev, current) {
                    print("current$current");
                    print(current is CartStateSuccess);
                    return (current is CartStateSuccess ||
                            current is CartStateDeleteSuccess)
                        ? true
                        : false;
                  },
                  builder: (context, state) {
                    return Text(
                      (AddToCartCubit.get(context).cartModel.data != null &&
                              AddToCartCubit.get(context)
                                      .cartModel
                                      .data!
                                      .cart !=
                                  null)
                          ? "${AddToCartCubit.get(context).cartModel.data!.cart!.cartsProductsTotalCount}"
                          : "0",
                      style: TextStyle(fontSize: 12),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
