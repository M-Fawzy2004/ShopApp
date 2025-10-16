import 'package:clothes_ecommerce_app/feature/home/data/model/category_model.dart';

abstract class CategoryRemoteDataSource {
  // get categories
  Future<List<CategoryModel>> getCategories();
}
