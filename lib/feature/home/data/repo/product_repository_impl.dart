import 'package:clothes_ecommerce_app/core/error/exceptions.dart';
import 'package:clothes_ecommerce_app/core/error/failure.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/datasource/product_remote_data_source.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/repo/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({
    required String category,
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final products = await remoteDataSource.getProductsByCategory(
        category: category,
        skip: skip,
        limit: limit,
      );
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  // search products
  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts({
    required String query,
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final products = await remoteDataSource.searchProducts(
        query: query,
        skip: skip,
        limit: limit,
      );
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
