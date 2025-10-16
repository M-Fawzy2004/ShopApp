import 'package:clothes_ecommerce_app/core/error/failure.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  // get categories
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
