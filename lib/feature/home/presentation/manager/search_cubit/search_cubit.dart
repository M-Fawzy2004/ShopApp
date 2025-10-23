import 'package:bloc/bloc.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/use_case/search_products_use_case.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUseCase searchProductsUseCase;

  String? lastQuery;
  List<ProductEntity> allProducts = [];
  int currentSkip = 0;
  static const int pageSize = 20;
  bool hasMoreData = true;

  SearchCubit({required this.searchProductsUseCase}) : super(SearchInitial());

  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    try {
      lastQuery = query;
      currentSkip = 0;
      allProducts.clear();
      hasMoreData = true;

      emit(SearchLoading());

      final result = await searchProductsUseCase(
        query: query,
        skip: currentSkip,
        limit: pageSize,
      );

      result.fold(
        (failure) => emit(SearchError(message: failure.message)),
        (products) {
          if (products.isEmpty) {
            emit(SearchEmpty());
          } else {
            allProducts.addAll(products);
            currentSkip += products.length;
            hasMoreData = products.length == pageSize;

            emit(SearchLoaded(
              products: List.from(allProducts),
              hasMoreData: hasMoreData,
            ));
          }
        },
      );
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  Future<void> loadMoreSearchResults() async {
    if (!hasMoreData || lastQuery == null) return;
    if (state is SearchLoadingMore) return;

    emit(SearchLoadingMore(currentProducts: List.from(allProducts)));

    try {
      final result = await searchProductsUseCase(
        query: lastQuery!,
        skip: currentSkip,
        limit: pageSize,
      );

      result.fold(
        (failure) {
          emit(SearchLoaded(
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

          emit(SearchLoaded(
            products: List.from(allProducts),
            hasMoreData: hasMoreData,
          ));
        },
      );
    } catch (e) {
      emit(SearchLoaded(
        products: List.from(allProducts),
        hasMoreData: hasMoreData,
      ));
    }
  }

  void clearSearch() {
    lastQuery = null;
    allProducts.clear();
    currentSkip = 0;
    hasMoreData = true;
    emit(SearchInitial());
  }
}