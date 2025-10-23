import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/widget/categories_details_bloc_builder.dart';
import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/widget/categories_details_header.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class CategoriesDetailsViewBody extends StatefulWidget {
  final CategoryEntity category;

  const CategoriesDetailsViewBody({
    super.key,
    required this.category,
  });

  @override
  State<CategoriesDetailsViewBody> createState() =>
      _CategoriesDetailsViewBodyState();
}

class _CategoriesDetailsViewBodyState extends State<CategoriesDetailsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // categories details header
        CategoriesDetailsHeader(category: widget.category),
        // categories details body
        CategoriesDetailsBlocBuilder(category: widget.category),
      ],
    );
  }
}
