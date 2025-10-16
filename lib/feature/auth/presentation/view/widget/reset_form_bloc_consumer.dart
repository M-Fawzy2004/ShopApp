import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordFormBlocConsumer extends StatelessWidget {
  const ResetPasswordFormBlocConsumer({
    super.key,
    required this.email,
    required this.token,
  });

  final String email;
  final String token;

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
        }

        if (state is AuthSuccess) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.success,
          );

          // Navigate back to login after success
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              context.go(AppRouter.loginView);
            }
          });
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return ResetPasswordForm(
          isLoading: isLoading,
          email: email,
          token: token,
        );
      },
    );
  }
}
