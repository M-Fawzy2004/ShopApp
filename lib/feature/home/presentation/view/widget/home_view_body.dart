import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/categories_header_row.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/categories_list_bloc_consumer.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/home_app_bar_section.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/custom_search_field.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_sections_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 200.h,
          backgroundColor: AppColors.lightBlue,
          pinned: true,
          floating: true,
          collapsedHeight: 60.h,
          flexibleSpace: const HomeAppBarSection(),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10.h),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
              child: const CustomSearchField(),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: heightBox(15),
        ),
        const SliverToBoxAdapter(
          child: CategoriesHeaderRow(),
        ),
        SliverToBoxAdapter(
          child: heightBox(20),
        ),
        const SliverToBoxAdapter(
          child: CategoriesListBlocConsumer(),
        ),
        const SliverToBoxAdapter(
          child: ProductSectionsColumn(),
        ),
      ],
    );
  }
}
