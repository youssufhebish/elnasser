import 'package:elnasser/models/cart_model/cart_model.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:flutter/cupertino.dart';

class CartRepository {
  CartRepository({required this.context});
  final BuildContext context;

  Future<void> get getCart =>
      AddToCartCubit.get(context).getCart(context: context);
}
