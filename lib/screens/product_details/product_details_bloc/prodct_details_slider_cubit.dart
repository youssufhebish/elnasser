import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/home_model/product_images_list.dart';
import 'package:elnasser/models/product_details.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/product_details/product_data_provider/product_details_api_suggestion.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../product_details_screen.dart';
import 'product_details_suggestion_cubit.dart';

class ProductDetailsSliderCubit extends Cubit<ProductDetailsSliderState> {
  ProductDetailsSliderCubit() : super(ProductDetailsSliderInitialState()) {
    scrollController = SwiperController();
  }

  static ProductDetailsSliderCubit get(BuildContext context) => BlocProvider.of(context);

  SwiperController? scrollController;
  int changeSliderIndexValue = -1;
  int choiceIndexValue = -1;
  int attributeChoiceValue = -1;
  int activeIndicator = 0;
  int? atributId;
  changeActiveIndicator(int value) {
    activeIndicator = value;
    emit(ProductDetailsSliderActiveIndicatorState());
  }

  ProductDetails productDetails = ProductDetails();
  Future<void> getProduct(BuildContext context, int productId) async {
    Loader.showLoader(context);
    emit(ProductDetailsStateLoading());

    Response? response = await ProductDetailsApiSuggestion.getProductDetailsApi(context: context, productId: productId);

    productDetails = ProductDetails.fromJson(response?.data);

    if (productDetails.status == 200) {
      emit(ProductDetailsStateSuccess());
      Loader.hideLoader(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                    product: ProductDetailsSliderCubit.get(context).productDetails.data!.product,
                    theInitialModel: SplashCubit.get(context).theInitialModel,
                    colorsValue: SplashCubit.get(context).theInitialModel.data!.account!.mobileAppColors!,
                  ))).whenComplete(() {});
      ProductDetailsSuggestionCubit.get(context).productIds.add(productId);

      ProductDetailsSuggestionCubit.get(context).getProductDetails(context);
    } else {
      emit(ProductDetailsStateFail());
      Loader.hideLoader(context);
    }
  }

  ///  New Api V002;

  // int productChoiceID  ;

  int sliderListAttribute = -1;
  List<int> productsChoicesIds = [];
  List<int> productsChoicesImagesIds = [];

  getSliderAttributeIndex(
      {required int index,
      required List<int> productsChoicesIdsList,
      required List<int> productsChoicesImagesIdsList,
      required List<ProductsChoice> productsChoiceList,
      required List<ProductImagesList> ProductImagesList}) {
    activeIndicator = 0;
    attributeChoiceValue = index;
    choiceIndexValue = -1;
    sliderListAttribute = index;
    productsChoicesIds = productsChoicesIdsList;
    productsChoicesImagesIds = productsChoicesImagesIdsList;
    emit(SliderListAttributeState());
    print('Lists');
    print(productsChoicesImagesIds.toSet().toList());
    print('Lists');
    getAttributeChoice(productsChoiceList);
    getAttributeImages(ProductImagesList, productsChoicesImagesIds.toSet().toList(), index);
  }

  List<ProductsChoice> ProductsChoiceDisplayList = [];

  List<ProductsChoice> getAttributeChoice(List<ProductsChoice> productsChoiceList) {
    ProductsChoiceDisplayList.clear();
    productsChoiceList.forEach((productsChoiceListElement) {
      productsChoicesIds.forEach((element) {
        if (element == productsChoiceListElement.productsChoicesId) {
          ProductsChoiceDisplayList.add(productsChoiceListElement);
        }
      });
    });

    emit(GetAttributeChoiceState());
    return ProductsChoiceDisplayList.toSet().toList();
  }

  bool haveSize = true;
  getProductChoseIdAtributeNoChoise(BuildContext context, int id, List<ProductsChoice> list) {
    print(id);
    list.forEach((element) {
      if (element.productsChoicesId == id) {
        haveSize = element.choices!.isNotEmpty;
      }
    });
    if (haveSize != true) {
      AddToCartCubit.get(context).getProductChoiceID("$id");
    }
    print("haveSize:$haveSize");
    emit(GetAttributeChoiceState());
  }

  List<ProductImagesList> ProductImagesDisplayList = [];
  List<ProductImagesList> getAttributeImages(List<ProductImagesList> ProductImagesList, List<int> images, int index) {
    sliderListAttribute = index;
    ProductImagesDisplayList.clear();
    ProductImagesList.forEach((ProductImagesListElement) {
      images.forEach((element) {
        if (element == ProductImagesListElement.productsImagesId) {
          ProductImagesDisplayList.add(ProductImagesListElement);
        }
      });
    });

    print(ProductImagesDisplayList.toSet());
    emit(GetAttributeChoiceState());
    return ProductImagesDisplayList.toSet().toList();
  }

  clearData() {
    sliderListAttribute = -1;
    productsChoicesIds = [];
    productsChoicesImagesIds = [];
    ProductsChoiceDisplayList = [];
    choiceIndexValue = -1;
    atributId = null;
    emit(GetAttributeChoiceState());
  }

  getAtributeID(int id) {
    atributId = id;
    emit(GetAttributeChoiceState());
  }

  choiceIndex(int value) {
    WidgetsFlutterBinding.ensureInitialized();
    scrollController!.move(0);
    choiceIndexValue = value;
    print(value);
    emit(ProductDetailsSliderChoiceState());
  }

  /// ProductChoicesNoAttributes
}
