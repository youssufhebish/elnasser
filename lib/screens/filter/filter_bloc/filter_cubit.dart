import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/filter_model/filter_model.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit_state.dart';
import 'package:elnasser/screens/filter/filter_data_provider/filter_data_provider.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_data_provider/home_data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<FilterCubitState> {
  FilterCubit() : super(FilterCubitStateInitial()) {
    getData();
  }
  static FilterCubit get(BuildContext context) => BlocProvider.of(context);

  TheInitialModel theInitialModel = TheInitialModel();
  getData() async {
    PreferenceUtils.getDataFromPreferences(initialData).then((value) {
      theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
      emit(FilterCubitStateShared());
    });
  }

  FilterModel filterModel = FilterModel();
  Future<void> getFilter(BuildContext context) async {
    emit(FilterCubitStateLoading());

    Response? response = await FilterDataProvider.getFilter(context: context);

    print("Filter Response");
    print(response!.data);
    print("Filter Response");
    if (response.statusCode == 200) {
      filterModel = FilterModel.fromJson(response.data);
      print(filterModel.data!.categories);
      emit(FilterCubitStateSuccess());
    } else {
      emit(FilterCubitStateFailed());
    }
  }

  ///
  List<String> sortByList = [
    "default",
    "recently",
    "highest_price",
    "lowest_price",
    "highest_rating",
    "best_selling"
  ];

  String? minPrice = "0";
  String? maxPrice = "5000";
  String? categoriesIds;
  String? offersIds;
  String? attributesIds;
  String? sizesIds;
  String? sortBy = "";
  String? brandIds;
  String? title;

  getSortBy(int index) {
    print(index);

    sortBy = sortByList[index];
    print(sortBy);
    emit(FilterCubitStateSortBy());
  }

  getMaxPrice(String price) {
    maxPrice = price;
    emit(FilterCubitStateMaxPrice());
  }

  getMinPrice(String price) {
    minPrice = price;
    emit(FilterCubitStateMinPrice());
  }

  List<int> brandIdsList = [];
  getBrands(int? brandId, bool isSelected) {
    if (isSelected == true) {
      brandIdsList.add(brandId!);
    } else {
      brandIdsList.remove(brandId!);
    }

    brandIdsList.toSet().toList();

    emit(FilterCubitStateBrand());
  }

  List<int> SizesIdsList = [];

  getSizes(int? sizeID, bool isSelected) {
    if (isSelected == true) {
      SizesIdsList.add(sizeID!);
    } else {
      SizesIdsList.remove(sizeID!);
    }

    SizesIdsList.toSet().toList();

    emit(FilterCubitStateSizes());
  }

  List<int> categoryIdsList = [];

  getCategory(int? categoryID, bool isSelected) {
    if (isSelected == true) {
      categoryIdsList.add(categoryID!);
    } else {
      categoryIdsList.remove(categoryID!);
    }

    categoryIdsList.toSet().toList();
    print(categoryIdsList);
    emit(FilterCubitStateCat());
  }

  List<int> OffersIdsList = [];
  getOffer(int? offerID, bool isSelected) {
    if (isSelected == true) {
      OffersIdsList.add(offerID!);
    } else {
      OffersIdsList.remove(offerID!);
    }

    OffersIdsList.toSet().toList();

    emit(FilterCubitStateOffer());
  }

  List<int> attributeIdsList = [];

  getAttribute(int? attributeID, bool isSelected) {
    if (isSelected == true) {
      attributeIdsList.add(attributeID!);
    } else {
      attributeIdsList.remove(attributeID!);
    }

    attributeIdsList.toSet().toList();

    emit(FilterCubitStateAttribute());
  }

  Future<void> getFilterData() async {
    brandIds = brandIdsList.join(",");
    sizesIds = SizesIdsList.join(",");
    categoriesIds = categoryIdsList.join(",");
    offersIds = OffersIdsList.join(",");
    attributesIds = attributeIdsList.join(",");

    emit(FilterCubitStateGetData());
  }

  resetFilterData(bool filter) {
    filterModel.data!.categories!.forEach((element) {
      element.isSelected = false;
      element.subcategories!.forEach((element2) {
        element2.isSelected = false;
        element2.subcategories!.forEach((element3) {
          element3.isSelected = false;
        });
      });
    });
    brandIds = "";
    brandIdsList.clear();
    sizesIds = "";
    SizesIdsList.clear();
    categoriesIds = "";
    categoryIdsList.clear();
    offersIds = "";
    OffersIdsList.clear();
    attributesIds = "";
    attributeIdsList.clear();
    filter == true ? print(sortBy) : sortBy = "";

    minPrice = "0";
    maxPrice = "5000";
    print(offersIds);
    print(OffersIdsList);

    emit(FilterCubitStateResetData());
  }

  bool isCheckedMain = false;
  bool isCheckedMainSup = false;
  bool isCheckedMainSupSup = false;
  changeCheckMain(bool value) {
    isCheckedMain = value;
    emit(FilterCubitStateCheckBox());
  }

  changeCheckMainSup() {
    isCheckedMainSup = !isCheckedMainSup;
    emit(FilterCubitStateCheckBox());
  }

  changeCheckMainSupSup() {
    isCheckedMainSupSup = !isCheckedMainSupSup;
    emit(FilterCubitStateCheckBox());
  }
}
