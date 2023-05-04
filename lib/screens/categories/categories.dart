import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/responsive/check_responsive.dart';
import 'package:elnasser/screens/categories/category_bloc/category_cubit.dart';
import 'package:elnasser/screens/categories/category_bloc/category_state.dart';
import 'package:elnasser/screens/categories/category_bloc/sup_category_state.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/image.dart';
import 'package:elnasser/widget/search_widget/search_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'category_bloc/sup_category_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        vsync: this,
        length: CategoryListCubit.get(context)
            .categoriesModel
            .data!
            .categories!
            .length);
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return SizedBox(
        height: 100.h - (AppBar().preferredSize.height * 2.5),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              SearchWidget(
                colorsValue: widget.colorsValue,
                hideFilter: false,
                isCat: false,
              ),
              BlocConsumer<CategoryListCubit, CategoryListState>(
                  builder: (context, state) {
                    print("state>>>>>>>>");
                    if (state is CategoryListStateSuccess) {
                      return DefaultTabController(
                        length: CategoryListCubit.get(context)
                            .categoriesModel
                            .data!
                            .categories!
                            .length,
                        child: SizedBox(
                          height: 100.h -
                              (10.h + (AppBar().preferredSize.height * 2.5)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: BlocBuilder<SupCategoryCubit,
                                    SupCategoryState>(
                                  builder: (context, state) {
                                    return AppBar(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      elevation: 0,
                                      bottom: TabBar(
                                        controller: _controller,
                                        onTap: (index) {
                                          SupCategoryCubit.get(context)
                                              .getMainCategoryIndex(index);
                                        },
                                        indicatorColor:
                                            ColorsConstant.getColorBackground3(
                                                widget.colorsValue),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        unselectedLabelColor:
                                            ColorsConstant.getColorText3(
                                                widget.colorsValue),
                                        labelColor:
                                            ColorsConstant.getColorBackground3(
                                                widget.colorsValue),
                                        physics: BouncingScrollPhysics(),
                                        isScrollable: true,
                                        tabs: List.generate(
                                          CategoryListCubit.get(context)
                                              .categoriesModel
                                              .data!
                                              .categories!
                                              .length,
                                          (index) => Tab(
                                            child: CategoryListCubit.get(
                                                            context)
                                                        .categoriesModel
                                                        .data!
                                                        .categories!
                                                        .length <=
                                                    5
                                                ? SizedBox(
                                                    width: SizeDataConstant
                                                        .customWidth(
                                                            context,
                                                            double.parse(
                                                                "${CategoryListCubit.get(context).categoriesModel.data!.categories!.length}")),
                                                    child: Center(
                                                      child: CustomText(
                                                          text: CategoryListCubit
                                                                  .get(context)
                                                              .categoriesModel
                                                              .data!
                                                              .categories![
                                                                  index]
                                                              .trans!
                                                              .first
                                                              .categoriesTitle,
                                                          style: SupCategoryCubit
                                                                          .get(
                                                                              context)
                                                                      .mainCategoryIndex ==
                                                                  index
                                                              ? TextStyleConstant
                                                                  .bodyTextMainColor(
                                                                      context,
                                                                      widget
                                                                          .colorsValue)
                                                              : TextStyleConstant
                                                                  .bodyTextGrey(
                                                                      context,
                                                                      widget
                                                                          .colorsValue)),
                                                    ),
                                                  )
                                                : CustomText(
                                                    text: CategoryListCubit.get(
                                                            context)
                                                        .CategoriesList[index]
                                                        .trans!
                                                        .first
                                                        .categoriesTitle,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                    controller: _controller,

                                    // physics: NeverScrollableScrollPhysics(),
                                    children: List.generate(
                                      CategoryListCubit.get(context)
                                          .categoriesModel
                                          .data!
                                          .categories!
                                          .length,
                                      (index) => SizedBox(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: SizedBox(
                                                  height: 100.h -
                                                      (8.h +
                                                          (AppBar()
                                                                  .preferredSize
                                                                  .height *
                                                              2.5)),
                                                  child: SingleChildScrollView(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    child: BlocBuilder<
                                                        SupCategoryCubit,
                                                        SupCategoryState>(
                                                      builder:
                                                          (context, state) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children:
                                                              List.generate(
                                                                  CategoryListCubit
                                                                          .get(
                                                                              context)
                                                                      .CategoriesList[
                                                                          index]
                                                                      .subcategories!
                                                                      .length,
                                                                  (secondIndex) =>
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          SupCategoryCubit.get(context)
                                                                              .getSupCategoryIndex(secondIndex);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 4.0,
                                                                              bottom: 4.0),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                6.3.h,
                                                                            color: SupCategoryCubit.get(context).supCategoryIndex == secondIndex
                                                                                ? ColorsConstant.getColorBackground5(widget.colorsValue)
                                                                                : Theme.of(context).scaffoldBackgroundColor,
                                                                            child: Center(
                                                                                child: CustomText(
                                                                              text: CategoryListCubit.get(context).CategoriesList[index].subcategories![secondIndex].trans!.first.categoriesTitle,
                                                                              style: SupCategoryCubit.get(context).supCategoryIndex == secondIndex ? TextStyleConstant.bodyTextMainColor(context, widget.colorsValue) : TextStyleConstant.bodyTextGrey(context, widget.colorsValue),
                                                                              textAlign: TextAlign.center,
                                                                            )),
                                                                          ),
                                                                        ),
                                                                      )),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 6,
                                                child: SingleChildScrollView(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  child: BlocBuilder<
                                                      SupCategoryCubit,
                                                      SupCategoryState>(
                                                    builder: (context, state) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          CategoryListCubit.get(
                                                                      context)
                                                                  .CategoriesList[
                                                                      index]
                                                                  .subcategories!
                                                                  .isNotEmpty
                                                              ? ((CategoryListCubit.get(context).CategoriesList[index].subcategories![SupCategoryCubit.get(context).supCategoryIndex >= CategoryListCubit.get(context).CategoriesList[index].subcategories!.length ? CategoryListCubit.get(context).CategoriesList[index].subcategories!.length - 1 : SupCategoryCubit.get(context).supCategoryIndex].categoriesBannerImg !=
                                                                          null ||
                                                                      CategoryListCubit.get(context)
                                                                              .CategoriesList[index]
                                                                              .subcategories![SupCategoryCubit.get(context).supCategoryIndex]
                                                                              .categoriesBannerImg !=
                                                                          ""))
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              8,
                                                                          bottom:
                                                                              8,
                                                                          top:
                                                                              4),
                                                                      child: Center(
                                                                          child: InkWell(
                                                                              onTap: () {
                                                                                FilterCubit.get(context).resetFilterData(false);
                                                                                FilterCubit.get(context).filterModel.data!.categories![index].subcategories![SupCategoryCubit.get(context).supCategoryIndex >= CategoryListCubit.get(context).CategoriesList[index].subcategories!.length ? CategoryListCubit.get(context).CategoriesList[index].subcategories!.length - 1 : SupCategoryCubit.get(context).supCategoryIndex].isSelected = true;

                                                                                FilterCubit.get(context).getCategory(FilterCubit.get(context).filterModel.data!.categories![index].subcategories![SupCategoryCubit.get(context).supCategoryIndex >= CategoryListCubit.get(context).CategoriesList[index].subcategories!.length ? CategoryListCubit.get(context).CategoriesList[index].subcategories!.length - 1 : SupCategoryCubit.get(context).supCategoryIndex].categoriesId, true);
                                                                                SharedMethods.openCategory(context: context, title: CategoryListCubit.get(context).CategoriesList[index].subcategories![SupCategoryCubit.get(context).supCategoryIndex].trans!.first.categoriesTitle!, catId: "${CategoryListCubit.get(context).CategoriesList[index].subcategories![SupCategoryCubit.get(context).supCategoryIndex].categoriesId!}", colorsValue: widget.colorsValue, theInitialModel: SplashCubit.get(context).theInitialModel);
                                                                              },
                                                                              child: ApiImage(
                                                                                image: CategoryListCubit.get(context).CategoriesList[index].subcategories![SupCategoryCubit.get(context).supCategoryIndex >= CategoryListCubit.get(context).CategoriesList[index].subcategories!.length ? CategoryListCubit.get(context).CategoriesList[index].subcategories!.length - 1 : SupCategoryCubit.get(context).supCategoryIndex].categoriesBannerImg,
                                                                                folderName: 'categories',
                                                                                type: 'medium',
                                                                                boxFit: BoxFit.contain,
                                                                                borderRadius: 8,
                                                                              ))),
                                                                    )
                                                                  : Container()
                                                              : Container(),
                                                          CategoryListCubit.get(
                                                                      context)
                                                                  .CategoriesList[
                                                                      index]
                                                                  .subcategories!
                                                                  .isNotEmpty
                                                              ? GridView
                                                                  .builder(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  physics:
                                                                      const BouncingScrollPhysics(),
                                                                  itemCount: CategoryListCubit
                                                                          .get(
                                                                              context)
                                                                      .CategoriesList[
                                                                          index]
                                                                      .subcategories![SupCategoryCubit.get(context).supCategoryIndex >= CategoryListCubit.get(context).CategoriesList[index].subcategories!.length
                                                                          ? CategoryListCubit.get(context).CategoriesList[index].subcategories!.length -
                                                                              1
                                                                          : SupCategoryCubit.get(context)
                                                                              .supCategoryIndex]
                                                                      .subcategories!
                                                                      .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  gridDelegate:
                                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount: (orientation ==
                                                                                Orientation.portrait &&
                                                                            (Responsive.isTablet(context)))
                                                                        ? 3
                                                                        : (orientation == Orientation.landscape && (Responsive.isTablet(context)))
                                                                            ? 4
                                                                            : 3,
                                                                    childAspectRatio:
                                                                        3 / 5.3,
                                                                  ),
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int listIndex) {
                                                                    var data = CategoryListCubit.get(
                                                                            context)
                                                                        .CategoriesList[
                                                                            index]
                                                                        .subcategories![SupCategoryCubit.get(context).supCategoryIndex >= CategoryListCubit.get(context).CategoriesList[index].subcategories!.length
                                                                            ? CategoryListCubit.get(context).CategoriesList[index].subcategories!.length -
                                                                                1
                                                                            : SupCategoryCubit.get(context).supCategoryIndex]
                                                                        .subcategories;
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            "sssssssssssssssssssssss");
                                                                        FilterCubit.get(context)
                                                                            .resetFilterData(false);
                                                                        FilterCubit.get(context)
                                                                            .filterModel
                                                                            .data!
                                                                            .categories![
                                                                                index]
                                                                            .subcategories![SupCategoryCubit.get(context).supCategoryIndex >= CategoryListCubit.get(context).CategoriesList[index].subcategories!.length
                                                                                ? CategoryListCubit.get(context).CategoriesList[index].subcategories!.length - 1
                                                                                : SupCategoryCubit.get(context).supCategoryIndex]
                                                                            .subcategories![listIndex]
                                                                            .isSelected = true;
                                                                        FilterCubit.get(context).getCategory(
                                                                            data![listIndex].categoriesId,
                                                                            true);

                                                                        SharedMethods.openCategory(
                                                                            context:
                                                                                context,
                                                                            title: data[listIndex]
                                                                                .trans!
                                                                                .first
                                                                                .categoriesTitle!,
                                                                            catId:
                                                                                "${data[listIndex].categoriesId!}",
                                                                            colorsValue:
                                                                                widget.colorsValue,
                                                                            theInitialModel: SplashCubit.get(context).theInitialModel);
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                  color: ColorsConstant.getColorBackground5(widget.colorsValue),
                                                                                ),
                                                                                child: ApiImage(
                                                                                  image: data![listIndex].categoriesImg,
                                                                                  folderName: 'categories',
                                                                                  type: 'medium',
                                                                                  boxFit: BoxFit.cover,
                                                                                  borderRadius: 8,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Center(
                                                                                  child: CustomText(
                                                                                text: data[listIndex].trans!.first.categoriesTitle,
                                                                                style: TextStyleConstant.blackCaption12(context: context, colorValue: widget.colorsValue),
                                                                                maxLie: 2,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              )),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : Container()
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 100.h -
                            (8.h + (AppBar().preferredSize.height * 2.5)),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                  listener: (context, tate) {})
            ],
          ),
        ));
  }
}
