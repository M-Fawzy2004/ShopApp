import 'package:clothes_ecommerce_app/core/error/exceptions.dart';
import 'package:clothes_ecommerce_app/feature/home/data/model/category_model.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/datasource/category_remote_data_source.dart';
import 'package:dio/dio.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get(
        'https://dummyjson.com/products/categories',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load categories');
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
