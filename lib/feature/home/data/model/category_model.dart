import 'package:clothes_ecommerce_app/core/helper/category_image_mapper.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.slug,
    required super.name,
    required super.url,
    required super.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final slug = json['slug'] as String;
    final categoryName = json['name'] as String;
    
    // Get high-quality image from mapper
    final imageUrl = CategoryImageMapper.getImageUrl(slug);

    return CategoryModel(
      slug: slug,
      name: categoryName,
      url: json['url'] as String,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
      'imageUrl': imageUrl,
    };
  }
}