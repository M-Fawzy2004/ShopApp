import 'package:clothes_ecommerce_app/core/di/get_it_service.dart';
import 'package:clothes_ecommerce_app/core/helper/extension.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/categories_header_row.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/categories_list_bloc_builder.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/home_app_bar_section.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_search_field.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_sections_column.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/search_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, this.onNavigateToSubjects});

  final VoidCallback? onNavigateToSubjects;

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
              child: CustomSearchField(
                hintText: 'Search for products...',
                onTap: () {
                  context.navigateWithSlideTransition(
                    BlocProvider(
                      create: (context) => getIt<SearchCubit>(),
                      child: const SearchHomeView(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: heightBox(15),
        ),
        SliverToBoxAdapter(
          child: CategoriesHeaderRow(
            onNavigateToSubjects: onNavigateToSubjects,
          ),
        ),
        SliverToBoxAdapter(
          child: heightBox(20),
        ),
        const SliverToBoxAdapter(
          child: CategoriesListBlocBuilder(),
        ),
        const SliverToBoxAdapter(
          child: ProductSectionsColumn(),
        ),
      ],
    );
  }
}
