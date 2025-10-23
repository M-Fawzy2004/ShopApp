import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Product> favorites;

  FavoritesLoaded({required this.favorites});
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}