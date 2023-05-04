import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_state.dart';
import 'package:elnasser/widget/card/product_card_web.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';

class HomeWebScreen extends StatelessWidget {
  HomeWebScreen({Key? key, required this.colorsValue}) : super(key: key);
  ColorsInitialValue colorsValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          return Container(
            child: SafeArea(
              child: Scaffold(
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: Header(colorsValue: colorsValue),
                        ),
                        SliverToBoxAdapter(
                          child: xxx(context),
                        )
                      ],
                    ),
                    HomeCubit.get(context).showCatValue == true
                        ? Positioned(
                            top: 8.h,
                            left: 0,
                            child: MouseRegion(
                              onExit: (v) {
                                HomeCubit.get(context).showCat();
                              },
                              child: Container(
                                color: Colors.green,
                                width: MediaQuery.of(context).size.width,
                                height: 30.h,
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget xxx(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column(
          //   children: [
          //     Expanded(
          //         flex:1,
          //         child: Container(
          //           color: Colors.black,
          //           width: MediaQuery.of(context).size.width,
          //           child: Center(
          //             child: SizedBox(
          //               width: SizeDataConstant.webWidth(context),
          //               child: Row(
          //                 children: [
          //                   const  Icon(Icons.directions_car_outlined,size: 25,color: Colors.white,),
          //                   const SizedBox(width: 20,),
          //                   CustomText(text: "Free shipping on orders over 500 egp", style: TextStyleConstant.buttonText(context,colorsValue)),
          //                   const  Spacer(),
          //                   const  Icon(Icons.phone,size: 25,color: Colors.white,),
          //                   const  SizedBox(width: 10,),
          //                   CustomText(text: "19785", style: TextStyleConstant.buttonText(context,colorsValue)),
          //                   const  SizedBox(width: 10,),
          //                   Transform.scale(
          //                     scale: .5,
          //                     child:const VerticalDivider(
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   const  Icon(Icons.location_on_outlined,size: 25,color: Colors.white,),
          //                   const    SizedBox(width: 10,),
          //                   CustomText(text: "19785", style: TextStyleConstant.buttonText(context,colorsValue)),
          //                   const  SizedBox(width: 10,),
          //                   Transform.scale(
          //                     scale: .5,
          //                     child: const VerticalDivider(
          //                       color: Colors.white,
          //                     ),
          //                   ),  CustomText(text: "عربى", style: TextStyleConstant.buttonText(context,colorsValue)),
          //
          //                   Transform.scale(
          //                     scale: .5,
          //                     child:const VerticalDivider(
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   CustomText(text: "EG", style: TextStyleConstant.buttonText(context,colorsValue)),
          //                   const  Icon(Icons.flag,size: 25,color: Colors.white,),
          //                   const  Icon(Icons.keyboard_arrow_down,size: 25,color: Colors.white,),
          //
          //                 ],
          //               ),
          //             ),
          //           ),
          //         )),  Expanded(
          //         flex:4,
          //         child: SizedBox(
          //           width: SizeDataConstant.webWidth(context),
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Row(
          //                 children: const[
          //                   Icon(FontAwesomeIcons.facebook,),
          //                   SizedBox(width: 10,),
          //                   Icon(FontAwesomeIcons.twitter,),
          //                   SizedBox(width: 10,),
          //                   Icon(FontAwesomeIcons.youtube,),
          //                   SizedBox(width: 10,),
          //                   Icon(FontAwesomeIcons.instagram,),
          //                   SizedBox(width: 10,),
          //                   Icon(FontAwesomeIcons.apple,),
          //                   SizedBox(width: 10,),
          //                   Icon(FontAwesomeIcons.googlePlay,),
          //                   SizedBox(width: 10,),
          //                 ],
          //               ),
          //
          //               Spacer(),
          //               Image.asset(ImageConstants.alnasser_logo),
          //               Spacer(),
          //
          //               Row(
          //                 children: const [
          //
          //                   Icon(FontAwesomeIcons.shoppingBag,),
          //                   SizedBox(width: 10,),
          //                   Icon(FontAwesomeIcons.search,),
          //                   SizedBox(width: 10,),
          //                   Icon(FontAwesomeIcons.userCircle,),
          //                   SizedBox(width: 10,),
          //
          //                 ],
          //               ),
          //             ],
          //           ),
          //         )),
          //     Container(
          //       color: Colors.black,
          //       width: MediaQuery.of(context).size.width,
          //       child: Center(
          //         child: SizedBox(
          //           width: SizeDataConstant.webWidth(context),
          //
          //           child: Wrap(
          //             children: List.generate(22, (index) => MaterialButton(onPressed: (){},
          //               height: 50,
          //               child: CustomText(text: "Free shipping", style: TextStyleConstant.buttonText(context,colorsValue)),)),
          //           ),
          //         ),
          //       ),
          //     ),     Expanded(
          //         flex:10,
          //         child: Container(
          //           color: Colors.blue,
          //
          //         )),
          //   ],
          // ),

          Center(
            child: SizedBox(
              width: SizeDataConstant.webWidth(context),
              height: 8.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomText(text: "Daily deals ", style: TextStyle()),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomText(text: "Daily deals ", style: TextStyle()),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        HomeCubit.get(context).goToPrevious();
                      },
                      child: const Center(
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        HomeCubit.get(context).goToNext();
                      },
                      child: const Center(
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
                height: SizeDataConstant.webCardHeight(context),
                width: SizeDataConstant.webWidth(context),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      controller: HomeCubit.get(context).controller,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return AutoScrollTag(
                            controller: HomeCubit.get(context).controller,
                            index: index,
                            key: ValueKey(index),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProductCardWeb(
                                index: index + 1,
                                colorsValue: colorsValue,
                              ),
                            ));
                      },
                    ),
                  ],
                )),
          ),

          Container(
            color: Colors.red,
            height: 30.h,
          ),
          Container(
            color: Colors.greenAccent,
            height: 30.h,
          ),
          Container(
            color: Colors.red,
            height: 30.h,
          ),
          Container(
            color: Colors.white,
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class Header extends SliverPersistentHeaderDelegate {
  Header({required this.colorsValue});
  ColorsInitialValue colorsValue;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          return shrinkOffset >= (80.h - 15.h)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            MouseRegion(
                              onEnter: (v) {
                                HomeCubit.get(context).showCat();
                              },
                              onExit: (v) {
                                // HomeCubit.get(context).showCat();
                              },
                              child: Container(
                                  height: 7.h,
                                  width: 60,
                                  child: Center(
                                      child: const Text(
                                    "Home",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      shrinkOffset >= 250
                          ? Container()
                          : Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.black,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: SizedBox(
                                    width: SizeDataConstant.webWidth(context),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.directions_car_outlined,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        CustomText(
                                            text:
                                                "Free shipping on orders over 500 egp",
                                            style: TextStyleConstant.buttonText(
                                                context, colorsValue)),
                                        const Spacer(),
                                        const Icon(
                                          Icons.phone,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomText(
                                            text: "19785",
                                            style: TextStyleConstant.buttonText(
                                                context, colorsValue)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Transform.scale(
                                          scale: .5,
                                          child: const VerticalDivider(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomText(
                                            text: "19785",
                                            style: TextStyleConstant.buttonText(
                                                context, colorsValue)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Transform.scale(
                                          scale: .5,
                                          child: const VerticalDivider(
                                            color: Colors.white,
                                          ),
                                        ),
                                        CustomText(
                                            text: "عربى",
                                            style: TextStyleConstant.buttonText(
                                                context, colorsValue)),
                                        Transform.scale(
                                          scale: .5,
                                          child: const VerticalDivider(
                                            color: Colors.white,
                                          ),
                                        ),
                                        CustomText(
                                            text: "EG",
                                            style: TextStyleConstant.buttonText(
                                                context, colorsValue)),
                                        const Icon(
                                          Icons.flag,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                      shrinkOffset >= 450
                          ? Container()
                          : Expanded(
                              flex: 4,
                              child: SizedBox(
                                width: SizeDataConstant.webWidth(context),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          FontAwesomeIcons.facebook,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.twitter,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.youtube,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.instagram,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.apple,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.googlePlay,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Image.asset(ImageConstants.alnasser_logo),
                                    Spacer(),
                                    Row(
                                      children: const [
                                        Icon(
                                          FontAwesomeIcons.shoppingBag,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.search,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.userCircle,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                      Container(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: SizedBox(
                            width: SizeDataConstant.webWidth(context),
                            child: Wrap(
                              children: List.generate(
                                  22,
                                  (index) => MaterialButton(
                                        onPressed: () {},
                                        height: 50,
                                        child: CustomText(
                                            text: "Free shipping",
                                            style: TextStyleConstant.buttonText(
                                                context, colorsValue)),
                                      )),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 10,
                          child: Container(
                            color: Colors.blue,
                          )),
                    ],
                  ),
                );
        },
        listener: (context, state) {});
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 80.h;

  @override
  // TODO: implement minExtent
  double get minExtent => 8.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}
