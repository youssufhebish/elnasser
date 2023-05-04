import 'package:elnasser/screens/categories/category_bloc/sup_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupCategoryCubit extends Cubit<SupCategoryState> {
  SupCategoryCubit() : super(SupCategoryStateInitial());
  static SupCategoryCubit get(BuildContext context) => BlocProvider.of(context);

  int mainCategoryIndex = 0;
  int supCategoryIndex = 0;

  getMainCategoryIndex(int index) {
    mainCategoryIndex = index;
    supCategoryIndex = 0;
    emit(SupCategoryStateMainCategory());
  }

  getSupCategoryIndex(int index) {
    supCategoryIndex = index;
    emit(SupCategoryStateSupCategory());
  }
}
