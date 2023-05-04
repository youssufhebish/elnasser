import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/atributes.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/home_model/product_images_list.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:flutter/material.dart';

import '../add_to_cart_bottom_sheet.dart';

class showDraggableSheet {
  showSheet(
      {required BuildContext context,
      required ProductClass productClass,
      required TheInitialModel theInitialModel,
      required ColorsInitialValue colorsValue,
      required List<ProductImagesList> images,
      required List<AttributeElement>? attribute,
      required List<ProductsChoice>? attributeProductsChoice,
      required String? productImage}) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8), topLeft: Radius.circular(8))),
        context: context,
        builder: (context) => AddToCartBottomSheet(
              colorsValue: colorsValue,
              theInitialModel: theInitialModel,
              product: productClass,
              images: images,
              attribute: attribute,
              attributeProductsChoice: attributeProductsChoice,
              productImage: productImage,
            ));
  }
}
