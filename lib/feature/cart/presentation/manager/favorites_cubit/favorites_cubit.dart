import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final Box<Product> favoritesBox;

  FavoritesCubit(this.favoritesBox) : super(FavoritesInitial()) {
    loadFavorites();
  }

  void loadFavorites() {
    if (isClosed) return;
    try {
      emit(FavoritesLoading());
      final favorites = favoritesBox.values.where((product) => product.isFavorite).toList();
      emit(FavoritesLoaded(favorites: favorites));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites: ${e.toString()}'));
    }
  }

  void toggleFavorite(Product product) {
    if (isClosed) return;
    try {
      final existingProduct = favoritesBox.get(product.id);

      if (existingProduct != null) {
        existingProduct.isFavorite = !existingProduct.isFavorite;
        existingProduct.save();
      } else {
        product.isFavorite = true;
        favoritesBox.put(product.id, product);
      }

      loadFavorites();
    } catch (e) {
      emit(FavoritesError('Failed to toggle favorite: ${e.toString()}'));
    }
  }

  void removeFromFavorites(String productId) {
    if (isClosed) return;
    try {
      final product = favoritesBox.get(productId);
      if (product != null) {
        product.isFavorite = false;
        product.save();
        loadFavorites();
      }
    } catch (e) {
      emit(FavoritesError('Failed to remove favorite: ${e.toString()}'));
    }
  }

  bool isFavorite(String productId) {
    final product = favoritesBox.get(productId);
    return product?.isFavorite ?? false;
  }
}