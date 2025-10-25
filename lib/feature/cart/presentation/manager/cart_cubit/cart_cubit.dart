import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final Box<Product> cartBox;

  CartCubit(this.cartBox) : super(CartInitial()) {
    print('🟢 CartCubit created');
    loadCart();
  }

  void loadCart() {
    if (isClosed) return;
    try {
      print('📦 Loading cart...');
      emit(CartLoading());
      
      final products = cartBox.values.toList();
      print('✅ Loaded ${products.length} cart items');
      print('📋 Box keys: ${cartBox.keys.toList()}');
      
      _emitCartLoaded(products);
    } catch (e) {
      print('❌ Error loading cart: $e');
      emit(CartError('Cart loading failed: ${e.toString()}'));
    }
  }

  void addProduct(Product product) {
    if (isClosed) return;
    try {
      print('➕ Adding to cart: ${product.id} - ${product.name}');
      final existingProduct = cartBox.get(product.id);

      if (existingProduct != null) {
        print('📈 Increasing quantity from ${existingProduct.quantity} to ${existingProduct.quantity + product.quantity}');
        final updated = existingProduct.copyWith(
          quantity: existingProduct.quantity + product.quantity,
        );
        cartBox.put(product.id, updated);
      } else {
        print('🆕 New product added');
        cartBox.put(product.id, product);
      }

      print('📊 Cart size: ${cartBox.length}');
      loadCart();
    } catch (e) {
      print('❌ Add error: $e');
      emit(CartError('Product addition failed: ${e.toString()}'));
    }
  }

  void removeProduct(String productId) {
    if (isClosed) return;
    try {
      print('🗑️ Removing from cart: $productId');
      cartBox.delete(productId);
      print('📊 Cart size: ${cartBox.length}');
      loadCart();
    } catch (e) {
      print('❌ Remove error: $e');
      emit(CartError('Product removal failed: ${e.toString()}'));
    }
  }

  void updateQuantity(String productId, int quantity) {
    if (isClosed) return;
    try {
      print('🔄 Update quantity: $productId -> $quantity');
      
      if (quantity <= 0) {
        removeProduct(productId);
        return;
      }

      final product = cartBox.get(productId);
      if (product != null) {
        final updated = product.copyWith(quantity: quantity);
        cartBox.put(productId, updated);
        print('✅ Quantity updated');
        loadCart();
      } else {
        print('⚠️ Product not found in cart');
      }
    } catch (e) {
      print('❌ Update error: $e');
      emit(CartError('Quantity update failed: ${e.toString()}'));
    }
  }

  void clearCart() {
    if (isClosed) return;
    try {
      print('🗑️ Clearing cart');
      cartBox.clear();
      loadCart();
    } catch (e) {
      print('❌ Clear error: $e');
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

    print('💰 Total: $totalPrice | Items: $totalItems');

    emit(CartLoaded(
      products: products,
      totalPrice: totalPrice,
      totalItems: totalItems,
    ));
  }

  @override
  Future<void> close() {
    print('🔴 CartCubit closing');
    return super.close();
  }
}