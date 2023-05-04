import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/widget/card/card_bloc/card_cubit.dart';
import 'package:elnasser/widget/card/card_bloc/card_state.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';

import '../text_widget.dart';

class ProductCardWeb extends StatelessWidget {
  ProductCardWeb({Key? key, required this.index, required this.colorsValue})
      : super(key: key);
  int index;
  ColorsInitialValue colorsValue;

  bool show = false;
  bool showMenu = false;

  bool noChoose = true;
  static const List<String> stock = [
    "Exists",
    "out",
    "Exists",
    "out",
    "Exists",
    "Exists",
    "Exists"
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardCubit, CardState>(
        builder: (context, state) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (v) {
              show = true;
              BlocProvider.of<CardCubit>(context).showHover(show);
            },
            onExit: (v) {
              show = false;
              showMenu = false;
              BlocProvider.of<CardCubit>(context).closeHover(show);
            },
            child: Container(
              decoration: BoxDecoration(border: Border.all(width: .1)),
              width: Responsive.isDesktop(context)
                  ? SizeDataConstant.webCardWidth(context)
                  : MediaQuery.of(context).size.width / 2.2,
              child: Column(
                children: [
                  Expanded(
                      flex: 10,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          SizedBox(
                              width: Responsive.isDesktop(context)
                                  ? SizeDataConstant.webWidth(context) / 4
                                  : MediaQuery.of(context).size.width / 2.2,
                              child: Image.asset(
                                ImageConstants.product1,
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              color: Colors.white,
                              width: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: Center(
                                    child: CustomText(
                                      text: "Discount 20% Discount 20%",
                                      maxLie: 1,
                                      overflow: null,
                                      style: const TextStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          show == true
                              ? Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.favorite)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.notifications))
                                    ],
                                  ),
                                )
                              : Container(),
                          Positioned(
                            bottom: 0,
                            left: 10,
                            child: Center(
                                child: CustomText(
                              text:
                                  "Out of stock  $index    ${colorsValue..accountsColorsBackground1}  ",
                              style: TextStyleConstant
                                  .cardProductOutOfStockTextStyle(
                                      context, colorsValue),
                            )),
                          ),
                          showMenu == true
                              ? Positioned(
                                  left: 10,
                                  bottom: 20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(width: .2)),
                                    height: 20.h,
                                    width: 8.w,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: stock.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: 5.w,
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  width: .1),
                                                              bottom:
                                                                  BorderSide(
                                                                      width:
                                                                          .1))),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          stock[index] == "out"
                                                              ? SizedBox(
                                                                  height: 20,
                                                                  child: Center(
                                                                    child:
                                                                        CustomText(
                                                                      text:
                                                                          "95 USD ",
                                                                      style: TextStyleConstant.cardProductPriceDiscountTextStyle(
                                                                          context,
                                                                          colorsValue),
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox(
                                                                  height: 20,
                                                                  child: Row(
                                                                    children: [
                                                                      CustomText(
                                                                        text:
                                                                            "95 USD ",
                                                                        style: TextStyleConstant.cardProductPriceDiscountTextStyle(
                                                                            context,
                                                                            colorsValue),
                                                                      ),
                                                                      Spacer(),
                                                                      Transform.scale(
                                                                          scale:
                                                                              .8,
                                                                          child: Checkbox(
                                                                              value: true,
                                                                              onChanged: (v) {})),
                                                                    ],
                                                                  ),
                                                                )),
                                                );
                                              },
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                            width: 8.w,
                                            child: MaterialButton(
                                              onPressed: () {},
                                              child: CustomText(
                                                text: "Add to Cart",
                                                style: TextStyleConstant
                                                    .cardProductPriceDiscountTextStyle(
                                                        context, colorsValue),
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      )),
                  SizedBox(
                    height: 1.h,
                  ),
                  show == true
                      ? noChoose == true
                          ? Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                  child: MaterialButton(
                                    child: CustomText(
                                      style: const TextStyle(),
                                      text: 'Shop',
                                    ),
                                    color: Colors.blue,
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ))
                          : Expanded(
                              flex: 2,
                              child: SizedBox(
                                  width: Responsive.isDesktop(context)
                                      ? SizeDataConstant.webWidth(context) / 4
                                      : MediaQuery.of(context).size.width / 2.2,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ListView.builder(
                                        itemCount: 10,
                                        scrollDirection: Axis.horizontal,
                                        controller:
                                            CardCubit.get(context).controller,
                                        itemBuilder: (context, index) {
                                          return AutoScrollTag(
                                            controller: CardCubit.get(context)
                                                .controller,
                                            index: index,
                                            key: ValueKey(index),
                                            child: InkWell(
                                              onTap: () {
                                                showMenu = true;
                                                CardCubit.get(context)
                                                    .showMenu(showMenu);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 3.5.w,
                                                  height: 7.h,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.asset(
                                                        ImageConstants.product1,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Positioned(
                                        right: 3,
                                        top: 6.h / 2,
                                        child: InkWell(
                                          onTap: () {
                                            CardCubit.get(context).goToNext();
                                          },
                                          child: const Center(
                                            child: Icon(
                                              Icons.chevron_right,
                                              color: Colors.grey,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 3,
                                        top: 6.h / 2,
                                        child: InkWell(
                                          onTap: () {
                                            CardCubit.get(context)
                                                .goToPrevious();
                                          },
                                          child: const Center(
                                            child: Icon(
                                              Icons.chevron_left,
                                              color: Colors.grey,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )))
                      : Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: Responsive.isDesktop(context)
                                ? SizeDataConstant.webWidth(context) / 4
                                : MediaQuery.of(context).size.width / 2.2,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Expanded(
                                    child: CustomText(
                                  text:
                                      "mkgg gdffgf gff dderec fdfddd e ddsdd ddee ddds eeeescxcxdssdc dddd sddee ddds eeeescxcxdssdc dddddweef ddd ",
                                  style: TextStyleConstant
                                      .cardProductNameTextStyle(
                                          context, colorsValue),
                                  maxLie: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ],
                            ),
                          ),
                        ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: Responsive.isDesktop(context)
                          ? SizeDataConstant.webWidth(context) / 4
                          : MediaQuery.of(context).size.width / 2.2,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomText(
                            text: "95 USD ",
                            style: TextStyleConstant
                                .cardProductPriceDiscountTextStyle(
                                    context, colorsValue),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
