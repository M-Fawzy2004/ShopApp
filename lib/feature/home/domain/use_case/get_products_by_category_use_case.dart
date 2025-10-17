import 'package:clothes_ecommerce_app/core/error/failure.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/repo/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsByCategoryUseCase {
  final ProductRepository repository;

  GetProductsByCategoryUseCase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call({
    required String category,
    int skip = 0,
    int limit = 10,
  }) async {
    return await repository.getProductsByCategory(
      category: category,
      skip: skip,
      limit: limit,
    );
  }
}
