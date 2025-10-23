import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_search_field.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/categories_header_row.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/categories_list_bloc_builder.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/home_app_bar_section.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_sections_column.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/search_results_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, this.onNavigateToSubjects});

  final VoidCallback? onNavigateToSubjects;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

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
                onChanged: _onSearchChanged,
              ),
            ),
          ),
        ),
        if (_isSearching)
          const SearchResultsSection()
        else ...[
          SliverToBoxAdapter(
            child: heightBox(15),
          ),
          SliverToBoxAdapter(
            child: CategoriesHeaderRow(
              onNavigateToSubjects: widget.onNavigateToSubjects,
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
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });
      context.read<SearchCubit>().searchProducts(value);
    } else {
      setState(() {
        _isSearching = false;
      });
      context.read<SearchCubit>().clearSearch();
    }
  }
}
