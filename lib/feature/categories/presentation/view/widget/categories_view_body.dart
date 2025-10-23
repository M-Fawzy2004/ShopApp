import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/feature/categories/presentation/view/widget/categories_app_bar.dart';
import 'package:clothes_ecommerce_app/feature/categories/presentation/view/widget/category_grid_bloc_builder.dart';
import 'package:flutter/material.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // sliver app bar
        const CategoriesAppBar(),
        // height box
        SliverToBoxAdapter(
          child: heightBox(20),
        ),
        // categories
        const SliverToBoxAdapter(
          child: CategoryGridBlocBuilder(),
        ),
        // height box
        SliverToBoxAdapter(
          child: heightBox(20),
        ),
      ],
    );
  }
}
