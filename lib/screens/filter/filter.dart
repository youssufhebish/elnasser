import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';

import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit_state.dart';
import 'package:elnasser/screens/search_result_filter/search_result_bloc/search_result_bloc_filter_state.dart';
import 'package:elnasser/screens/search_result_filter/search_result_bloc/search_result_filter_bloc.dart';
import 'package:elnasser/screens/search_result_filter/search_result_bloc/search_result_filter_event.dart';
import 'package:elnasser/screens/search_result_filter/search_result_filter_screen.dart';

import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'filter_widget/filter_item.dart';
import 'filter_widget/slider_filter_range.dart';
import 'filter_widget/sort_by_widget.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;
  TreeController? _controller = TreeController(allNodesExpanded: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppButton(
        colorsInitialValue: colorsValue,
        textStyle: TextStyleConstant.whiteText(context, colorsValue),
        color: ColorsConstant.getColorBackground3(colorsValue),
        title: 'applyFilter'.tr().toString(),
        onPressed: () {
          FilterCubit.get(context).getFilterData().whenComplete(() {
            context
                .read<SearchResultBloc>()
                .emit(SearchResultBlocState(context: context));

            context.read<SearchResultBloc>().add(SearchResultFetchFilter());
          });

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchResultFilterScreen(
                        theInitialModel:
                            FilterCubit.get(context).theInitialModel,
                        colorsValue: colorsValue,
                      )));
        },
      ),
      body: SizedBox(
        height: 100.h - (AppBar().preferredSize.height * 2.5),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocConsumer<FilterCubit, FilterCubitState>(
            buildWhen: (prev, curent) => curent is FilterCubitStateSuccess,
            builder: (context, state) {
              print("FilterCubitState");
              print(state);
              print("state");
              if (state is FilterCubitStateSuccess ||
                  state is FilterCubitStateResetData ||
                  state is FilterCubitStateCat ||
                  state is FilterCubitStateGetData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    // SearchWidget(
                    //   colorsValue: colorsValue,
                    // ),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomText(
                                text: "sortBy".tr().toString(),
                                style: TextStyleConstant.headerText(
                                    context, colorsValue)),
                          ),
                          Expanded(
                              flex: 3,
                              child: SortByWidget(
                                colorsValue: colorsValue,
                              ))
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 5),
                      child: CustomText(
                          text: "priceRange".tr().toString(),
                          style: TextStyleConstant.headerText(
                              context, colorsValue)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: SliderRangeWidget(
                        colorsValue: colorsValue,
                      ),
                    ),
                    Divider(),
                    FilterItem(
                      title: 'popularBrand',
                      type: 'Brand',
                      colorsValue: colorsValue,
                    ),
                    Divider(),

                    Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          childrenPadding: EdgeInsets.all(8),
                          title: CustomText(
                              text: "categories".tr().toString(),
                              style: TextStyleConstant.headerText(
                                  context, colorsValue)),
                          children: [
                            BlocBuilder<FilterCubit, FilterCubitState>(
                                builder: (context, state) {
                              return TreeView(
                                indent: 30,
                                treeController: _controller,
                                nodes: List.generate(
                                    FilterCubit.get(context)
                                        .filterModel
                                        .data!
                                        .categories!
                                        .length,
                                    (index) => TreeNode(
                                        content: SizedBox(
                                          width: SizeDataConstant.customWidth(
                                              context, 1.2),
                                          child: BlocBuilder<FilterCubit,
                                              FilterCubitState>(
                                            builder: (context, state) {
                                              return CheckboxListTile(
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                value: FilterCubit.get(context)
                                                    .filterModel
                                                    .data!
                                                    .categories![index]
                                                    .isSelected,
                                                onChanged: (bool? value) {
                                                  FilterCubit.get(context)
                                                      .filterModel
                                                      .data!
                                                      .categories![index]
                                                      .isSelected = value!;
                                                  FilterCubit.get(context)
                                                      .getCategory(
                                                          FilterCubit.get(
                                                                  context)
                                                              .filterModel
                                                              .data!
                                                              .categories![
                                                                  index]
                                                              .categoriesId!,
                                                          value);
                                                },
                                                title: Text(
                                                    "${FilterCubit.get(context).filterModel.data!.categories![index].trans!.first.categoriesTitle}"),
                                              );
                                            },
                                          ),
                                        ),
                                        children: List.generate(
                                            FilterCubit.get(context)
                                                .filterModel
                                                .data!
                                                .categories![index]
                                                .subcategories!
                                                .length,
                                            (second) => TreeNode(
                                                content: SizedBox(
                                                  width: SizeDataConstant
                                                      .customWidth(
                                                          context, 1.4),
                                                  child: BlocBuilder<
                                                      FilterCubit,
                                                      FilterCubitState>(
                                                    builder: (context, state) {
                                                      return CheckboxListTile(
                                                        controlAffinity:
                                                            ListTileControlAffinity
                                                                .leading,
                                                        value: FilterCubit.get(
                                                                context)
                                                            .filterModel
                                                            .data!
                                                            .categories![index]
                                                            .subcategories![
                                                                second]
                                                            .isSelected,
                                                        onChanged:
                                                            (bool? value) {
                                                          FilterCubit.get(
                                                                      context)
                                                                  .filterModel
                                                                  .data!
                                                                  .categories![
                                                                      index]
                                                                  .subcategories![
                                                                      second]
                                                                  .isSelected =
                                                              value!;
                                                          FilterCubit.get(context).getCategory(
                                                              FilterCubit.get(
                                                                      context)
                                                                  .filterModel
                                                                  .data!
                                                                  .categories![
                                                                      index]
                                                                  .subcategories![
                                                                      second]
                                                                  .categoriesId,
                                                              value);
                                                        },
                                                        title: Text(
                                                            "${FilterCubit.get(context).filterModel.data!.categories![index].subcategories![second].trans!.first.categoriesTitle}"),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                children: List.generate(
                                                    FilterCubit.get(context)
                                                        .filterModel
                                                        .data!
                                                        .categories![index]
                                                        .subcategories![second]
                                                        .subcategories!
                                                        .length,
                                                    (thirdIndex) => TreeNode(
                                                          content: SizedBox(
                                                            width:
                                                                SizeDataConstant
                                                                    .customWidth(
                                                                        context,
                                                                        1.5),
                                                            child: BlocBuilder<
                                                                FilterCubit,
                                                                FilterCubitState>(
                                                              builder: (context,
                                                                  state) {
                                                                return CheckboxListTile(
                                                                  controlAffinity:
                                                                      ListTileControlAffinity
                                                                          .leading,
                                                                  value: FilterCubit
                                                                          .get(
                                                                              context)
                                                                      .filterModel
                                                                      .data!
                                                                      .categories![
                                                                          index]
                                                                      .subcategories![
                                                                          second]
                                                                      .subcategories![
                                                                          thirdIndex]
                                                                      .isSelected,
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    FilterCubit.get(
                                                                            context)
                                                                        .filterModel
                                                                        .data!
                                                                        .categories![
                                                                            index]
                                                                        .subcategories![
                                                                            second]
                                                                        .subcategories![
                                                                            thirdIndex]
                                                                        .isSelected = value!;
                                                                    FilterCubit.get(context).getCategory(
                                                                        FilterCubit.get(context)
                                                                            .filterModel
                                                                            .data!
                                                                            .categories![index]
                                                                            .subcategories![second]
                                                                            .subcategories![thirdIndex]
                                                                            .categoriesId,
                                                                        value);
                                                                  },
                                                                  title: Text(
                                                                      "${FilterCubit.get(context).filterModel.data!.categories![index].subcategories![second].subcategories![thirdIndex].trans!.first.categoriesTitle}"),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        )))))),
                              );
                            })
                          ],
                        )),
                    Divider(),
                    FilterItemAttribute(
                      title: 'attributes',
                      colorsValue: colorsValue,
                    ),
                    Divider(),
                    FilterItem(
                      title: 'offers',
                      type: 'Offer',
                      colorsValue: colorsValue,
                    ),
                    Divider(),
                    (FilterCubit.get(context).filterModel.data != null &&
                            FilterCubit.get(context)
                                .filterModel
                                .data!
                                .choices!
                                .isNotEmpty)
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: FilterCubit.get(context)
                                .filterModel
                                .data!
                                .choices!
                                .length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  FilterItem(
                                    title:
                                        '${FilterCubit.get(context).filterModel.data!.choices![index].trans!.first.choicesTitle}',
                                    type: 'Size',
                                    index: index,
                                    colorsValue: colorsValue,
                                  ),
                                  Divider(),
                                ],
                              );
                            })
                        : Container(),

                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                );
              } else if (state is FilterCubitStateFailed) {
                return Container(
                  child: Text("Connection Error"),
                );
              } else {
                return SizedBox(
                  height: 80.h,
                  child: Center(
                    child: SizedBox(
                      width: SizeDataConstant.customWidth(context, 2),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              }
            },
            listener: (context, state) {},
          ),
        ),
      ),
    );
  }
}
