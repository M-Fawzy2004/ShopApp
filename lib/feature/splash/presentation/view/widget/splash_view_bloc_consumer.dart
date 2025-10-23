import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/feature/splash/presentation/manager/cubit/splash_cubit.dart';
import 'package:clothes_ecommerce_app/feature/splash/presentation/view/widget/splash_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashViewBlocConsumer extends StatelessWidget {
  const SplashViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashComplete) {
          final user = Supabase.instance.client.auth.currentUser;
          if (user != null) {
            context.go(AppRouter.mainView );
          } else {
            context.go(AppRouter.loginView);
          }
        }
      },
      builder: (context, state) {
        List<double> opacities = [0.0, 0.0, 0.0, 0.0];

        if (state is SplashAnimating) {
          opacities = state.letterOpacities;
        }

        return SplashViewBody(opacities: opacities);
      },
    );
  }
}
