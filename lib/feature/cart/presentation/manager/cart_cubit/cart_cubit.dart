import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final Box<Product> cartBox;

  CartCubit(this.cartBox) : super(CartInitial()) {
    loadCart();
  }

  void loadCart() {
    if (isClosed) return;
    try {
      emit(CartLoading());
      final products = cartBox.values.toList();
      _emitCartLoaded(products);
    } catch (e) {
      emit(CartError('Cart loading failed: ${e.toString()}'));
    }
  }

  void addProduct(Product product) {
    if (isClosed) return;
    try {
      final existingProduct = cartBox.get(product.id);

      if (existingProduct != null) {
        existingProduct.quantity += product.quantity;
        existingProduct.save();
      } else {
        cartBox.put(product.id, product);
      }

      loadCart();
    } catch (e) {
      emit(CartError('Product addition failed: ${e.toString()}'));
    }
  }

  void removeProduct(String productId) {
    if (isClosed) return;
    try {
      cartBox.delete(productId);
      loadCart();
    } catch (e) {
      emit(CartError('Product removal failed: ${e.toString()}'));
    }
  }

  void updateQuantity(String productId, int quantity) {
    if (isClosed) return;
    try {
      if (quantity <= 0) {
        removeProduct(productId);
        return;
      }

      final product = cartBox.get(productId);
      if (product != null) {
        product.quantity = quantity;
        product.save();
        loadCart();
      }
    } catch (e) {
      emit(CartError('Quantity update failed: ${e.toString()}'));
    }
  }

  void clearCart() {
    if (isClosed) return;
    try {
      cartBox.clear();
      loadCart();
    } catch (e) {
      emit(CartError('Cart clearing failed: ${e.toString()}'));
    }
  }

  void _emitCartLoaded(List<Product> products) {
    if (isClosed) return;
    final totalPrice = products.fold<double>(
      0,
      (sum, product) => sum + product.totalPrice,
    );

    final totalItems = products.fold<int>(
      0,
      (sum, product) => sum + product.quantity,
    );

    emit(CartLoaded(
      products: products,
      totalPrice: totalPrice,
      totalItems: totalItems,
    ));
  }
}
