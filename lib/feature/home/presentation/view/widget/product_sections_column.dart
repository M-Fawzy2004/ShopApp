import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_section_list.dart';
import 'package:flutter/material.dart';

class ProductSectionsColumn extends StatelessWidget {
  const ProductSectionsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {'title': 'Laptops', 'category': 'laptops'},
      {'title': 'Smartphones', 'category': 'smartphones'},
      {'title': 'Home Decoration', 'category': 'home-decoration'},
      {'title': 'Tablets', 'category': 'tablets'},
      {'title': 'Mens Shoes', 'category': 'mens-shoes'},
      {'title': 'Furniture', 'category': 'furniture'},
      {'title': 'Groceries', 'category': 'groceries'},
    ];

    return Column(
      children: sections
          .map(
            (section) => ProductSectionList(
              title: section['title']!,
              category: section['category']!,
            ),
          )
          .toList(),
    );
  }
}
