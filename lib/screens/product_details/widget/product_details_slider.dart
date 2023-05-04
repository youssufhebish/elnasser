import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/product_class.dart';
import 'package:elnasser/models/home_model/product_images_list.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/notify_me/notify_me_bloc/notfy_me_state.dart';
import 'package:elnasser/screens/notify_me/notify_me_bloc/notify_me_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_cubit.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_state.dart';
import 'package:elnasser/widget/Video.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ProductDetalSliderWidget extends StatefulWidget {
  ProductDetalSliderWidget(
      {required this.images,
      this.video,
      required this.attribute,
      required this.attributeProductsChoice,
      required this.productImage,
      required this.favorite,
      required this.colorsValue,
      required this.product});
  final List<ProductImagesList> images;
  final List<AttributeElement>? attribute;
  final List<ProductsChoice>? attributeProductsChoice;
  final String? productImage;
  int favorite;
  double? height;
  final ColorsInitialValue colorsValue;
  String? video;
  final ProductClass product;

  @override
  State<ProductDetalSliderWidget> createState() => _ProductDetalSliderWidgetState();
}

class _ProductDetalSliderWidgetState extends State<ProductDetalSliderWidget> {
  late YoutubePlayerController _controller;
  bool color = false;
  bool notify = false;

  List<String> sliderList = [];
  void initState() {
    super.initState();
    ProductDetailsSliderCubit.get(context).clearData();

    if (widget.productImage != null) {
      print('widget.productImage ${widget.productImage}');
      sliderList.add(widget.productImage!);
    }
    widget.images.forEach((element) {
      sliderList.add(element.productsImagesName!);
    });

    if (widget.video != null) {
      sliderList.add(widget.video!);
    }

    if (widget.video != null) {
      var video = widget.video!.split("/");

      _controller = YoutubePlayerController(
        initialVideoId: '${widget.video}',
        params: YoutubePlayerParams(
          playlist: ["${video.last}"],
          startAt: const Duration(minutes: 1, seconds: 36),
          showControls: true,
          showFullscreenButton: true,
          desktopMode: true,
          privacyEnhanced: true,
          useHybridComposition: true,
        ),
      );
      _controller.onEnterFullscreen = () {};
      _controller.onExitFullscreen = () {};
    }

    // TODO: implement initState
    color = widget.product.isFav == 1 ? true : false;
    notify = widget.product.isNotify == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return sliderList.isNotEmpty
        ? BlocBuilder<ProductDetailsSliderCubit, ProductDetailsSliderState>(
            buildWhen: (previous, current) =>
                previous != current &&
                (current is ProductDetailsSliderIndexState ||
                    current is ProductDetailsSliderChoiceState ||
                    current is GetAttributeChoiceState),
            builder: (context, state) {
              WidgetsFlutterBinding.ensureInitialized();
              return SizedBox(
                  height: 45.h,
                  width: SizeDataConstant.fullWidth(context),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      /// After change V002
                      CarouselSlider.builder(
                        // itemCount: ProductDetailsSliderCubit.get(context)
                        //             .changeSliderIndexValue ==
                        //         -1
                        //     ? sliderList.length
                        //     : (widget.attribute!.isNotEmpty)
                        //         ? widget
                        //                 .attribute![
                        //                     ProductDetailsSliderCubit.get(context)
                        //                         .changeSliderIndexValue]
                        //                 .productsChoices![0]
                        //                 .images!
                        //                 .isNotEmpty
                        //             ? widget
                        //                 .attribute![
                        //                     ProductDetailsSliderCubit.get(context)
                        //                         .changeSliderIndexValue]
                        //                 .productsChoices![0]
                        //                 .images!
                        //                 .length
                        //             : sliderList.length
                        //         : (widget.attributeProductsChoice!.isNotEmpty)
                        //             ? widget
                        //                     .attributeProductsChoice![
                        //                         ProductDetailsSliderCubit.get(
                        //                                 context)
                        //                             .changeSliderIndexValue]
                        //                     .images!
                        //                     .isNotEmpty
                        //                 ? widget
                        //                     .attributeProductsChoice![
                        //                         ProductDetailsSliderCubit.get(
                        //                                 context)
                        //                             .changeSliderIndexValue]
                        //                     .images!
                        //                     .length
                        //                 : sliderList.length
                        //             : sliderList.length,
                        itemCount: ProductDetailsSliderCubit.get(context).sliderListAttribute == -1
                            ? sliderList.length
                            : ProductDetailsSliderCubit.get(context).ProductImagesDisplayList.length,
                        itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                          const player = YoutubePlayerIFrame(
                            aspectRatio: 18 / 10,
                          );
                          return Column(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child: (sliderList.length - 1 == index &&
                                          widget.video != null &&
                                          ProductDetailsSliderCubit.get(context).changeSliderIndexValue == -1)
                                      ? (Platform.isIOS
                                          ? YoutubeCustomWidget(video: widget.video!.split("/").last)
                                          : Container(
                                              width: SizeDataConstant.fullWidth(context),
                                              margin: const EdgeInsets.only(left: 0, right: 0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5.5.h,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: YoutubePlayerControllerProvider(
                                                      // Passing controller to widgets below.
                                                      controller: _controller,
                                                      child: Container(
                                                        child: player,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 7.h,
                                                  ),
                                                ],
                                              ),
                                            ))
                                      : ApiImage(
                                          folderName: "products",
                                          type: "original",
                                          boxFit: BoxFit.contain,
                                          image: ProductDetailsSliderCubit.get(context).sliderListAttribute == -1
                                              ? sliderList[index]
                                              : ProductDetailsSliderCubit.get(context).ProductImagesDisplayList.isNotEmpty
                                                  ? ProductDetailsSliderCubit.get(context)
                                                      .ProductImagesDisplayList[index]
                                                      .productsImagesName
                                                  : widget.product.productsImg,

                                          // ProductDetailsSliderCubit.get(context).changeSliderIndexValue ==-1? sliderList[index] :
                                          // ( widget.attribute !=null && widget.attribute!.isNotEmpty  )?widget.attribute![ProductDetailsSliderCubit.get(context).changeSliderIndexValue].productsChoices![0].images!.isNotEmpty?  widget.attribute![ProductDetailsSliderCubit.get(context).changeSliderIndexValue].productsChoices![0].images![index].productsImagesName:sliderList[index]:
                                          // widget.attributeProductsChoice![ProductDetailsSliderCubit.get(context).changeSliderIndexValue].images!.isNotEmpty? widget.attributeProductsChoice![ProductDetailsSliderCubit.get(context).changeSliderIndexValue].images![index].productsImagesName:sliderList[index],
                                          //

                                          borderRadius: 0,
                                        ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: Container(),
                              // )  ,
                            ],
                          );
                        },
                        options: CarouselOptions(
                          height: 45.h,
                          aspectRatio: 18 / 5,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false,
                          onPageChanged: (value, reason) {
                            ProductDetailsSliderCubit.get(context).changeActiveIndicator(value);
                          },
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: IconButton(
                              onPressed: () async {
                                // fav.fetchFavoriteProduct(context);

                                if (HomeMobileCubit.get(context).isUserLogin == false) {
                                  DataErrorAlert.showLogin(
                                      colorValue: widget.colorsValue,
                                      title: 'YouNeedToLogin'.tr().toString(),
                                      data: 'pleaseLoginFirst'.tr().toString(),
                                      context: context);
                                } else {
                                  setState(() {
                                    color = !color;
                                  });
                                  if (widget.product.isFav == 1) {
                                    widget.product.isFav = 0;
                                  } else {
                                    widget.product.isFav = 1;
                                  }

                                  FavoriteCubit.get(context).addToFavorite(context: context, productId: "${widget.product.productsId}");
                                  // onFavSubmit(_meals);

                                  // var res = await updateFavsItem(
                                  //     EasyLocalization.of(context)
                                  //         .currentLocale
                                  //         .languageCode,
                                  //     widget.token,
                                  //     widget.product.productsId,context);
                                  // if (res.status == 200) {
                                  //   SuccDialogAlertStaySameLayout(
                                  //       context, res.message,ValueKey("Product${widget.product.productsId}"));
                                  // } else {
                                  //   if (res.status == 401) {
                                  //     SystemControls().LogoutSetUserData(
                                  //         context,
                                  //         EasyLocalization.of(context)
                                  //             .currentLocale
                                  //             .languageCode);
                                  //   }

                                  if (widget.product.isFav == 1) {
                                    widget.product.isFav = 0;
                                  } else {
                                    widget.product.isFav = 1;
                                  }
                                  // onFavSubmit(_meals);

                                  // ErrorDialogAlert(context, res.message);
                                  // }
                                }
                                // home.notifyListeners();
                              },
                              icon: Icon(
                                color == true ? Icons.favorite : Icons.favorite_border,
                                color: color == true ? ColorsConstant.getColorText5(widget.colorsValue) : null,
                              )),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 70,
                        child: BlocConsumer<NotifyMeCubit, NotifyMeCubitState>(
                          builder: (context, state) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: IconButton(
                                  onPressed: () async {
                                    // fav.fetchFavoriteProduct(context);

                                    if (HomeMobileCubit.get(context).isUserLogin == false) {
                                      DataErrorAlert.showLogin(
                                          colorValue: widget.colorsValue,
                                          title: 'YouNeedToLogin'.tr().toString(),
                                          data: 'pleaseLoginFirst'.tr().toString(),
                                          context: context);
                                    } else {
                                      setState(() {
                                        notify = !notify;
                                      });
                                      if (widget.product.isNotify == 1) {
                                        widget.product.isNotify = 0;
                                      } else {
                                        widget.product.isNotify = 1;
                                      }

                                      NotifyMeCubit.get(context).addToNotify(context: context, productId: "${widget.product.productsId}");
                                      // onFavSubmit(_meals);

                                      // var res = await updateFavsItem(
                                      //     EasyLocalization.of(context)
                                      //         .currentLocale
                                      //         .languageCode,
                                      //     widget.token,
                                      //     widget.product.productsId,context);
                                      // if (res.status == 200) {
                                      //   SuccDialogAlertStaySameLayout(
                                      //       context, res.message,ValueKey("Product${widget.product.productsId}"));
                                      // } else {
                                      //   if (res.status == 401) {
                                      //     SystemControls().LogoutSetUserData(
                                      //         context,
                                      //         EasyLocalization.of(context)
                                      //             .currentLocale
                                      //             .languageCode);
                                      //   }

                                      if (widget.product.isNotify == 1) {
                                        widget.product.isNotify = 0;
                                      } else {
                                        widget.product.isNotify = 1;
                                      }
                                      // onFavSubmit(_meals);

                                      // ErrorDialogAlert(context, res.message);
                                      // }
                                    }
                                    // home.notifyListeners();
                                  },
                                  icon: Icon(
                                    notify == true ? Icons.notifications_active : Icons.notifications,
                                    color: notify == true ? ColorsConstant.getColorBackground3(widget.colorsValue) : null,
                                  )),
                            );
                          },
                          listener: (context, state) {
                            if (state is NotifyMeCubitStateSuccess) {
                              HomeMobileCubit.get(context).getMobileHome(context);
                            }
                          },
                        ),
                      ),

                      /// After change V002
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: BlocBuilder<ProductDetailsSliderCubit, ProductDetailsSliderState>(
                          builder: (context, state) {
                            return AnimatedSmoothIndicator(
                              effect: JumpingDotEffect(
                                  dotWidth: 10,
                                  dotHeight: 10,
                                  spacing: 3,
                                  activeDotColor: ColorsConstant.getColorBackground3(widget.colorsValue)),
                              activeIndex: ProductDetailsSliderCubit.get(context).activeIndicator,
                              count: ProductDetailsSliderCubit.get(context).sliderListAttribute == -1
                                  ? sliderList.length
                                  : ProductDetailsSliderCubit.get(context).ProductImagesDisplayList.length,
                            );
                          },
                        ),
                      ),
                    ],
                  ));
            },
          )
        : Container();
  }
}
