import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoadingMore extends ProductState {
  final List<ProductEntity> currentProducts;

  const ProductLoadingMore({required this.currentProducts});

  @override
  List<Object?> get props => [currentProducts];
}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final bool hasMoreData;

  const ProductLoaded({
    required this.products,
    this.hasMoreData = true,
  });

  @override
  List<Object?> get props => [products, hasMoreData];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}
