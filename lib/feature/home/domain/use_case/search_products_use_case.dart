import 'package:clothes_ecommerce_app/core/error/failure.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/repo/product_repository.dart';
import 'package:dartz/dartz.dart';

class SearchProductsUseCase {
  final ProductRepository repository;

  SearchProductsUseCase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call({
    required String query,
    int skip = 0,
    int limit = 20,
  }) async {
    return await repository.searchProducts(
      query: query,
      skip: skip,
      limit: limit,
    );
  }
}