import 'package:clothes_ecommerce_app/core/di/get_it_service.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/category_cubit/category_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/product_cubit/product_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProviders {
  const AppProviders._();

  static Widget auth({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  static Widget getApi({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => getIt<AuthCubit>(),
        ),
        BlocProvider<CategoryCubit>(
          create: (_) => getIt<CategoryCubit>()..getCategories(),
        ),
        BlocProvider<ProductCubit>(
          create: (_) => getIt<ProductCubit>(),
        ),
        BlocProvider<SearchCubit>(
          create: (_) => getIt<SearchCubit>(),
        ),
      ],
      child: child,
    );
  }

  static Widget getApiCategoriesView({required Widget child}) {
    return BlocProvider<CategoryCubit>(
      create: (_) => getIt<CategoryCubit>()..getCategories(),
      child: child,
    );
  }

  static Widget getApiCategoriesAndProductsView({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryCubit>(
          create: (_) => getIt<CategoryCubit>()..getCategories(),
        ),
        BlocProvider<ProductCubit>(
          create: (_) => getIt<ProductCubit>(),
        ),
      ],
      child: child,
    );
  }
}
