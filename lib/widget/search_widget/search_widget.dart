import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/filter/filter_widget/sort_by_widget.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/search_result_filter/search_result_bloc/search_result_bloc_filter_state.dart';
import 'package:elnasser/screens/search_tiltle_screen/search_tiltle_bloc/search_tiltle_bloc.dart';
import 'package:elnasser/screens/search_tiltle_screen/search_tiltle_bloc/search_tiltle_bloc_event.dart';
import 'package:elnasser/screens/search_tiltle_screen/search_tiltle_bloc/search_tiltle_bloc_state.dart';
import 'package:elnasser/screens/search_tiltle_screen/search_tiltle_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../image_widget.dart';
import '../search_text_feild.dart';
import 'search_widget_bloc/search_widget_cubit.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget(
      {Key? key,
      required this.colorsValue,
      required this.isCat,
      this.filterScreen = false,
      this.searchTitleScreen = false,
      required this.hideFilter,
      this.searchFilter = false})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  TextEditingController searchController = TextEditingController();
  bool filterScreen;
  bool searchTitleScreen;
  bool searchFilter;
  bool hideFilter;
  bool isCat;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "SearchWidgetTag",
      child: SizedBox(
        width: SizeDataConstant.fullWidth(context),
        child: Row(
          children: [
            Spacer(),
            AppSearchTextFiled(
              width: hideFilter == true ? 95 : 78,
              colorsInitialValue: colorsValue,
              controller: searchController,
              hintText: 'search'.tr().toString(),
              prefixIcon: IconButton(
                onPressed: () {
                  print(SearchWidgetCubit.get(context).searchText);
                  context
                      .read<SearchResultTitleBloc>()
                      .emit(SearchResultTitleBlocState(context: context));
                  context.read<SearchResultTitleBloc>()
                    ..add(SearchResultTitleFetch());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchTitleResult(
                                theInitialModel:
                                    FilterCubit.get(context).theInitialModel,
                                colorsValue: colorsValue,
                              ))).whenComplete(
                      () => SearchWidgetCubit.get(context).clearSearchText());
                },
                icon: Icon(
                  Icons.search,
                  color: ColorsConstant.getColorText1(colorsValue),
                ),
              ),
              inputType: TextInputType.text,
              onSubmit: (String data) {
                Navigator.popUntil(context, (route) => route.isFirst);
                context
                    .read<SearchResultTitleBloc>()
                    .emit(SearchResultTitleBlocState(context: context));
                context.read<SearchResultTitleBloc>()
                  ..add(SearchResultTitleFetch());

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchTitleResult(
                              theInitialModel:
                                  FilterCubit.get(context).theInitialModel,
                              colorsValue: colorsValue,
                            ))).whenComplete(
                    () => SearchWidgetCubit.get(context).clearSearchText());
              },
            ),
            SizedBox(
              width: hideFilter == true ? 0 : 3.w,
            ),
            hideFilter == true
                ? Container()
                : Material(
                    child: InkWell(
                      onTap: () {
                        if (isCat == false) {
                          FilterCubit.get(context).resetFilterData(false);
                        }
                        // FilterCubit.get(context).getFilter(context);
                        if (searchFilter == true) {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        } else {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          HomeCubit.get(context).showSearchEmit(context);
                        }
                        // SortByWidgetState().initState();
                        // print(SortByWidgetState().value);
                      },
                      child: Container(
                        width: 14.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  ColorsConstant.getColorBorder1(colorsValue)),
                          borderRadius: BorderRadius.circular(8),
                          color:
                              ColorsConstant.getColorBackground5(colorsValue),
                        ),
                        child: ImageView(
                          path: ImageConstants.filter,
                          color: ColorsConstant.getColorText1(colorsValue),
                          fit: BoxFit.scaleDown,
                          width: 13.w,
                          height: 5.h,
                        ),
                      ),
                    ),
                  ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
