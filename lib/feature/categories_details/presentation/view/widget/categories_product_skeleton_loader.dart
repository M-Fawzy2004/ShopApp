import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/widget/categorey_product_card.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/dimensions_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/meta_entity.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesProductSkeletonLoader extends StatelessWidget {
  final CategoryEntity category;
  final int itemCount;

  const CategoriesProductSkeletonLoader({
    super.key,
    required this.category,
    this.itemCount = 5,
  });

  ProductEntity _getDummyProduct(int index) {
    return ProductEntity(
      id: index,
      title: 'Loading Product Name Here',
      description: 'Loading product description text here for skeleton',
      category: category.name,
      price: 99.99,
      discountPercentage: 10.0,
      rating: 4.5,
      stock: 100,
      tags: const ['tag1', 'tag2'],
      brand: 'Brand Name',
      sku: 'SKU-000000',
      weight: 500,
      dimensions: const DimensionsEntity(
        width: 0,
        height: 0,
        depth: 0,
      ),
      warrantyInformation: '1 year warranty',
      shippingInformation: 'Ships in 1-2 days',
      availabilityStatus: 'In Stock',
      reviews: const [],
      returnPolicy: '30 days return policy',
      minimumOrderQuantity: 1,
      meta: const MetaEntity(
        createdAt: '',
        updatedAt: '',
        barcode: '',
        qrCode: '',
      ),
      images: const [
        'https://via.placeholder.com/150',
        'https://via.placeholder.com/150',
      ],
      thumbnail: 'https://via.placeholder.com/150',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        duration: const Duration(seconds: 1),
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return CategoreyProductCard(
            product: _getDummyProduct(index),
          );
        },
      ),
    );
  }
}
