import 'package:bloc/bloc.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/use_case/get_categories_use_case.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/category_cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryCubit({required this.getCategoriesUseCase})
      : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());

    final result = await getCategoriesUseCase();

    result.fold(
      (failure) => emit(CategoryError(message: failure.message)),
      (categories) => emit(CategoryLoaded(categories: categories)),
    );
  }

  void retry() {
    getCategories();
  }
}
