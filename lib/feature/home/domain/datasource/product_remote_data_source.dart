import 'package:clothes_ecommerce_app/feature/home/data/model/product_model.dart';

abstract class ProductRemoteDataSource {
  // get products by category
  Future<List<ProductModel>> getProductsByCategory({
    required String category,
    int skip = 0,
    int limit = 10,
  });

  // search products
  Future<List<ProductModel>> searchProducts({
    required String query,
    int skip = 0,
    int limit = 20,
  });
}
