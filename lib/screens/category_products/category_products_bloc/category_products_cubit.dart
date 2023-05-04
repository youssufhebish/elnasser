import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_products_cubit_state.dart';

class CategoryProductsCubit extends Cubit<CategoryProductCubitState> {
  CategoryProductsCubit() : super(CategoryProductCubitStateInitial());

  static CategoryProductsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  String? catID;
  String? vale;

  getCatID(String value) {
    catID = value;
    emit(CategoryProductCubitStateGetCatID());
  }

  getType(String value) {
    vale = value;
    emit(CategoryProductCubitStateGetValue());
  }
}
