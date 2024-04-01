import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCategoriesEvent extends CategoryEvent {}

class SearchCategoriesEvent extends CategoryEvent {
  final String query;

  SearchCategoriesEvent({required this.query});

  @override
  List<Object> get props => [query];
}
