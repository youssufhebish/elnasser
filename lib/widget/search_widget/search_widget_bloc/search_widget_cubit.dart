import 'package:elnasser/widget/search_widget/search_widget_bloc/search_widet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidgetCubit extends Cubit<SearchWidgetSate> {
  SearchWidgetCubit() : super(SearchWidgetSateInitial());

  static SearchWidgetCubit get(BuildContext context) =>
      BlocProvider.of(context);

  String searchText = " ";

  getSearchText(String text) {
    searchText = text;
    emit(SearchWidgetSateGetText());
  }

  clearSearchText() {
    searchText = " ";
    emit(SearchWidgetSateClear());
  }
}
