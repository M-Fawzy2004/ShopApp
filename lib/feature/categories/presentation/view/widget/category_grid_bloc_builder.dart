import 'package:clothes_ecommerce_app/feature/categories/presentation/view/widget/categories_grid.dart';
import 'package:clothes_ecommerce_app/feature/categories/presentation/view/widget/category_skeletonizer_loading.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/category_cubit/category_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/category_cubit/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryGridBlocBuilder extends StatelessWidget {
  const CategoryGridBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const CategorySkeletonizerLoading();
        } else if (state is CategoryLoaded) {
          return CategoriesGrid(categories: state.categories);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
