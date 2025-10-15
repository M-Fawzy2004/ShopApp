import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/login_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginFormBlocConsumer extends StatelessWidget {
  const LoginFormBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
          context.read<AuthCubit>().close();
        }

        if (state is AuthAuthenticated) {
          context.go(AppRouter.mainView);
          CustomSnackBar.show(
            context,
            message: 'Welcome back! You have successfully signed in',
            type: SnackBarType.success,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return LoginForm(isLoading: isLoading);
      },
    );
  }
}
