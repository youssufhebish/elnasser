import 'package:equatable/equatable.dart';

abstract class SearchResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchResultFetchFilter extends SearchResultEvent {}

class SearchResultReset extends SearchResultEvent {}
