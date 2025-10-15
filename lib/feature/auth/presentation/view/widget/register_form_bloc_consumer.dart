import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterFormBlocConsumer extends StatelessWidget {
  const RegisterFormBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthVerificationRequired || current is AuthError,
      listener: (context, state) {
        if (state is AuthVerificationRequired) {
          context.push(
            AppRouter.emailVerfView,
            extra: {
              'email': state.email,
            },
          );
        } else if (state is AuthError) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is AuthLoading ||
          current is AuthInitial ||
          current is AuthError ||
          current is AuthVerificationRequired,
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return RegisterForm(isLoading: isLoading);
      },
    );
  }
}
