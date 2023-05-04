import 'package:dio/dio.dart';
import 'package:elnasser/models/category_model/category_model.dart';
import 'package:elnasser/models/home_model/category.dart';
import 'package:elnasser/screens/categories/category_bloc/category_state.dart';
import 'package:elnasser/screens/categories/category_data_provider/category_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListCubit extends Cubit<CategoryListState> {
  CategoryListCubit() : super(CategoryListStateInitial());

  static CategoryListCubit get(BuildContext context) =>
      BlocProvider.of(context);

  CategoriesModel categoriesModel = CategoriesModel();

  List<CategoryClass> CategoriesList = [];

  Future<void> getCategoriesList(BuildContext context) async {
    emit(CategoryListStateLoading());
    CategoriesList.clear();
    Response? response =
        await CategoryDataProvider.getCategoryList(context: context);

    categoriesModel = CategoriesModel.fromJson(response?.data);

    if (categoriesModel.status == 200) {
      print('Categoties List ');
      categoriesModel.data!.categories!.forEach((element) {
        CategoriesList.add(element);
      });
      print(categoriesModel.data!.categories!.length);
      emit(CategoryListStateSuccess());
    } else {
      print(response!.data);
      emit(CategoryListStateFailed());
    }
  }
}
