import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/feature/splash/presentation/manager/cubit/splash_cubit.dart';
import 'package:clothes_ecommerce_app/feature/splash/presentation/view/widget/splash_view_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: const Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: SplashViewBlocConsumer(),
        ),
      ),
    );
  }
}
