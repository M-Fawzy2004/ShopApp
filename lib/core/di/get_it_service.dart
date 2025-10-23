import 'package:clothes_ecommerce_app/core/const/app_const.dart';
import 'package:clothes_ecommerce_app/feature/auth/data/repo/auth_repository_impl.dart';
import 'package:clothes_ecommerce_app/feature/auth/data/service/auth_service.dart';
import 'package:clothes_ecommerce_app/feature/auth/domain/repo/auth_repository.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/data/datasource/category_remote_data_source_impl.dart';
import 'package:clothes_ecommerce_app/feature/home/data/datasource/product_remote_data_source_impl.dart';
import 'package:clothes_ecommerce_app/feature/home/data/repo/category_repository_impl.dart';
import 'package:clothes_ecommerce_app/feature/home/data/repo/product_repository_impl.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/datasource/category_remote_data_source.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/datasource/product_remote_data_source.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/repo/category_repository.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/repo/product_repository.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/use_case/get_categories_use_case.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/use_case/get_products_by_category_use_case.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/use_case/search_products_use_case.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/category_cubit/category_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/product_cubit/product_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await Supabase.initialize(
    url: AppConst.supabaseUrl,
    anonKey: AppConst.supabaseKey,
  );

  ///////////////////// External Dependencies /////////////////////

  // Supabase Client
  getIt.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  // Google Sign In
  getIt.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(
      scopes: [
        'email',
        'profile',
        'openid',
      ],
      serverClientId: AppConst.googleClientId,
    ),
  );

  // Dio Instance
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    )..interceptors.addAll([
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          error: true,
          logPrint: (obj) {
            // You can use logger package here
          },
        ),
      ]),
  );

  ///////////////////// Data Sources /////////////////////

  // Category Remote Data Source
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(dio: getIt()),
  );

  // Product Remote Data Source
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: getIt()),
  );

  ///////////////////// Repositories /////////////////////

  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authService: getIt(),
    ),
  );

  // Category Repository
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: getIt()),
  );

  // Product Repository
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: getIt()),
  );

  ///////////////////// Use Cases /////////////////////

  // Get Categories Use Case
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(repository: getIt()),
  );

  // Get Products By Category Use Case
  getIt.registerLazySingleton<GetProductsByCategoryUseCase>(
    () => GetProductsByCategoryUseCase(repository: getIt()),
  );

  // Search Products Use Case
  getIt.registerLazySingleton(() => SearchProductsUseCase(
        repository: getIt<ProductRepository>(),
      ));

  ///////////////////// Services /////////////////////

  // Auth Service
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(
      supabaseClient: getIt(),
      googleSignIn: getIt(),
    ),
  );

  ///////////////////// Cubits /////////////////////

  // Auth Cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      authRepository: getIt(),
    ),
  );

  // Category Cubit
  getIt.registerFactory<CategoryCubit>(
    () => CategoryCubit(getCategoriesUseCase: getIt()),
  );

  // Product Cubit
  getIt.registerFactory<ProductCubit>(
    () => ProductCubit(getProductsByCategoryUseCase: getIt()),
  );

  // Search Cubit
  getIt.registerFactory(
    () => SearchCubit(searchProductsUseCase: getIt<SearchProductsUseCase>()),
  );
}

// Helper function to reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await getIt.reset();
  await initDependencies();
}

// Optional: Create Dio with custom configuration for specific needs
Dio createCustomDio({
  String? baseUrl,
  Map<String, dynamic>? headers,
  Duration? connectTimeout,
}) {
  return Dio(
    BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: connectTimeout ?? const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: headers ??
          {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
    ),
  )..interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
}

void setupCartDependencies(Box<Product> cartBox) {
  // Register CartCubit as a singleton with the cart box
  getIt.registerLazySingleton<CartCubit>(() => CartCubit(cartBox));
}
