import 'package:clothes_ecommerce_app/core/di/get_it_service.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/product_cubit/product_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/product_cubit/product_state.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_header_row.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSectionList extends StatefulWidget {
  final String title;
  final String category;

  const ProductSectionList({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  State<ProductSectionList> createState() => _ProductSectionListState();
}

class _ProductSectionListState extends State<ProductSectionList> {
  late ScrollController _scrollController;
  late ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _productCubit = getIt<ProductCubit>()
      ..getProductsByCategory(widget.category);
  }

  void _onScroll() {
    if (_isBottom) {
      _productCubit.loadMoreProducts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _productCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productCubit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductHeaderRow(title: widget.title),
          heightBox(12),
          SizedBox(
            height: 300.h,
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return ProductSectionListView(
                  state: state,
                  scrollController: _scrollController,
                );
              },
            ),
          ),
          heightBox(20),
        ],
      ),
    );
  }
}
