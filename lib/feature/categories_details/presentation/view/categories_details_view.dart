import 'package:clothes_ecommerce_app/core/di/app_providers.dart';
import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/widget/categories_details_view_body.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesDetailsView extends StatelessWidget {
  const CategoriesDetailsView({super.key, required this.category});

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return AppProviders.getApiCategoriesAndProductsView(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CategoriesDetailsViewBody(category: category),
          ),
        ),
      ),
    );
  }
}
