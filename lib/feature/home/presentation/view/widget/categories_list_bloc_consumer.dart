import 'package:clothes_ecommerce_app/feature/home/presentation/manager/category_cubit/category_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/category_cubit/category_state.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/categories_list_view.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/categories_list_view_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesListBlocConsumer extends StatelessWidget {
  const CategoriesListBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const CategoriesListViewLoading();
        } else if (state is CategoryLoaded) {
          return CategoriesListView(categories: state.categories);
        } 
        return const SizedBox.shrink();
      },
    );
  }
}
