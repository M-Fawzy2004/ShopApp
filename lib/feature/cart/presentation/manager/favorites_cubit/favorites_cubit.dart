import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final Box<Product> favoritesBox;

  FavoritesCubit(this.favoritesBox) : super(FavoritesInitial()) {
    print('🟢 FavoritesCubit created');
    loadFavorites();
  }

  void loadFavorites() {
    if (isClosed) return;
    try {
      print('📦 Loading favorites...');
      emit(FavoritesLoading());
      
      final favorites = favoritesBox.values.toList();
      print('✅ Loaded ${favorites.length} favorites');
      print('📋 Box keys: ${favoritesBox.keys.toList()}');
      
      emit(FavoritesLoaded(favorites: favorites));
    } catch (e) {
      print('❌ Error loading favorites: $e');
      emit(FavoritesError('Failed to load favorites: ${e.toString()}'));
    }
  }

  void toggleFavorite(Product product) {
    if (isClosed) {
      print('⚠️ Cubit is closed!');
      return;
    }
    
    try {
      print('🔄 Toggle favorite: ${product.id} - ${product.name}');
      final existingProduct = favoritesBox.get(product.id);
      print('🔍 Existing product: ${existingProduct?.name ?? "Not found"}');

      if (existingProduct != null) {
        print('🗑️ Removing from favorites: ${product.id}');
        favoritesBox.delete(product.id);
      } else {
        print('➕ Adding to favorites: ${product.id}');
        favoritesBox.put(product.id, product);
      }

      print('📊 Box size after toggle: ${favoritesBox.length}');
      loadFavorites();
    } catch (e) {
      print('❌ Toggle error: $e');
      emit(FavoritesError('Failed to toggle favorite: ${e.toString()}'));
    }
  }

  void removeFromFavorites(String productId) {
    if (isClosed) return;
    try {
      print('🗑️ Removing: $productId');
      favoritesBox.delete(productId);
      loadFavorites();
    } catch (e) {
      print('❌ Remove error: $e');
      emit(FavoritesError('Failed to remove favorite: ${e.toString()}'));
    }
  }

  bool isFavorite(String productId) {
    final exists = favoritesBox.containsKey(productId);
    print('❓ Is $productId favorite? $exists');
    return exists;
  }

  @override
  Future<void> close() {
    print('🔴 FavoritesCubit closing');
    return super.close();
  }
}