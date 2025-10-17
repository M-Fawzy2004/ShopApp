import 'package:clothes_ecommerce_app/core/di/app_providers.dart';
import 'package:clothes_ecommerce_app/feature/categories/presentation/view/widget/categories_view_body.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders.getApiCategoriesView(
      child: const Scaffold(
        body: CategoriesViewBody(),
      ),
    );
  }
}
