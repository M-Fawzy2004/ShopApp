import 'package:clothes_ecommerce_app/core/error/failure.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/repo/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await repository.getCategories();
  }
}
