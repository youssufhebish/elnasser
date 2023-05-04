import 'package:equatable/equatable.dart';

abstract class SearchResultTitleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchResultTitleFetch extends SearchResultTitleEvent {}

class SearchResultTitleReset extends SearchResultTitleEvent {}
