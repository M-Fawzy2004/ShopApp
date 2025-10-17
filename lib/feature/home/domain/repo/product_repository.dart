import 'package:clothes_ecommerce_app/core/error/failure.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  // get products by category
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({
    required String category,
    int skip = 0,
    int limit = 10,
  });
}
