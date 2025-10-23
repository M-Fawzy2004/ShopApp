import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Product> products;
  final double totalPrice;
  final int totalItems;

  const CartLoaded({
    required this.products,
    required this.totalPrice,
    required this.totalItems,
  });

  @override
  List<Object> get props => [products, totalPrice, totalItems];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}