part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductEntity> products;
  final bool hasMoreData;

  SearchLoaded({required this.products, required this.hasMoreData});
}

class SearchLoadingMore extends SearchState {
  final List<ProductEntity> currentProducts;

  SearchLoadingMore({required this.currentProducts});
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}