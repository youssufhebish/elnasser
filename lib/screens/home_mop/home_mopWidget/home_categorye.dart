import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/home_model/category.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/image.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory(
      {Key? key, required this.category, required this.colorsValue})
      : super(key: key);
  final List<CategoryClass> category;
  final ColorsInitialValue colorsValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    text: "categories".tr().toString(),
                    style: TextStyleConstant.headerText(context, colorsValue),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        HomeCubit.get(context).changeHomePage(1, context);
                      },
                      child: CustomText(
                        text: "showAll".tr().toString(),
                        style:
                            TextStyleConstant.lightText(context, colorsValue),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )),
          Expanded(
              flex: 7,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            onTap: () {
                              FilterCubit.get(context).resetFilterData(false);
                              FilterCubit.get(context)
                                  .filterModel
                                  .data!
                                  .categories![index]
                                  .isSelected = true;
                              FilterCubit.get(context).getCategory(
                                  FilterCubit.get(context)
                                      .filterModel
                                      .data!
                                      .categories![index]
                                      .categoriesId,
                                  true);
                              SharedMethods.openCategory(
                                  context: context,
                                  title: category[index]
                                      .trans!
                                      .first
                                      .categoriesTitle!,
                                  catId: "${category[index].categoriesId!}",
                                  colorsValue: colorsValue,
                                  theInitialModel:
                                      SplashCubit.get(context).theInitialModel);
                            },
                            child: Container(
                              width: SizeDataConstant.mopCategoryCardWidth(
                                  context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ApiImage(
                                folderName: "categories",
                                type: "medium",
                                image: category[index].categoriesImg,
                                borderRadius: 8,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                              child: CustomText(
                            text: category[index].trans!.first.categoriesTitle,
                            style: TextStyleConstant.bodyText(
                                context, colorsValue),
                          )),
                        ),
                      ],
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
