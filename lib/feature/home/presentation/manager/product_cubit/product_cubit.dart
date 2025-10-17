import 'package:bloc/bloc.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/use_case/get_products_by_category_use_case.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/product_cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  // Variables now public
  String? lastCategory;
  List<ProductEntity> allProducts = [];
  int currentSkip = 0;
  static const int pageSize = 10;
  bool hasMoreData = true;

  ProductCubit({required this.getProductsByCategoryUseCase})
      : super(ProductInitial());

  /// Initial load
  Future<void> getProductsByCategory(String category) async {
    try {
      lastCategory = category;
      currentSkip = 0;
      allProducts.clear();
      hasMoreData = true;

      emit(ProductLoading());

      final result = await getProductsByCategoryUseCase(
        category: category,
        skip: currentSkip,
        limit: pageSize,
      );

      result.fold(
        (failure) => emit(ProductError(message: failure.message)),
        (products) {
          allProducts.addAll(products);
          currentSkip += products.length;
          hasMoreData = products.length == pageSize;

          emit(ProductLoaded(
            products: List.from(allProducts),
            hasMoreData: hasMoreData,
          ));
        },
      );
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  /// Load more products for pagination
  Future<void> loadMoreProducts() async {
    if (!hasMoreData || lastCategory == null) return;
    if (state is ProductLoadingMore) return;

    emit(ProductLoadingMore(currentProducts: List.from(allProducts)));

    try {
      final result = await getProductsByCategoryUseCase(
        category: lastCategory!,
        skip: currentSkip,
        limit: pageSize,
      );

      result.fold(
        (failure) {
          emit(ProductLoaded(
            products: List.from(allProducts),
            hasMoreData: hasMoreData,
          ));
        },
        (products) {
          if (products.isEmpty) {
            hasMoreData = false;
          } else {
            allProducts.addAll(products);
            currentSkip += products.length;
            hasMoreData = products.length == pageSize;
          }

          emit(ProductLoaded(
            products: List.from(allProducts),
            hasMoreData: hasMoreData,
          ));
        },
      );
    } catch (e) {
      emit(ProductLoaded(
        products: List.from(allProducts),
        hasMoreData: hasMoreData,
      ));
    }
  }
}
