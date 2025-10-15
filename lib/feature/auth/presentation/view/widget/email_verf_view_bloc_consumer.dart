import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/email_verf_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmailVerfViewBlocConsumer extends StatelessWidget {
  final String email;

  const EmailVerfViewBlocConsumer({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthAuthenticated ||
          current is AuthError ||
          current is AuthSuccess,
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(AppRouter.mainView);
        } else if (state is AuthError) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is AuthSuccess) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.success,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return EmailVerfViewBody(
          email: email,
          isLoading: isLoading,
        );
      },
    );
  }
}
