import 'package:clothes_ecommerce_app/core/error/exceptions.dart';
import 'package:clothes_ecommerce_app/feature/home/data/model/product_model.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/datasource/product_remote_data_source.dart';
import 'package:dio/dio.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProductsByCategory({
    required String category,
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await dio.get(
        'https://dummyjson.com/products/category/$category',
        queryParameters: {
          'skip': skip,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsData =
            response.data['products'] as List<dynamic>;
        return productsData.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load products');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        throw ServerException(e.message ?? 'Server error');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
