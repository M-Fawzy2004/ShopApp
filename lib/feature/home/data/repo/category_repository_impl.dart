import 'package:clothes_ecommerce_app/core/error/exceptions.dart';
import 'package:clothes_ecommerce_app/core/error/failure.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/datasource/category_remote_data_source.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/repo/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
