import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/core/helper/extension.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/reset_password_view.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/forget_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordFormBlocConsumer extends StatelessWidget {
  const ForgetPasswordFormBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        if (current is AuthAuthenticated && previous is AuthLoading) {
          final cubit = context.read<AuthCubit>();
          if (cubit.state is AuthPasswordResetInProgress) {
            return false;
          }
        }
        return true;
      },
      listener: (context, state) {
        if (state is AuthError) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        }

        if (state is AuthPasswordResetInProgress) {
          if (state.token != null) {
            context.navigateWithSlideTransition(
              ResetPasswordView(
                email: state.email,
                token: state.token!,
              ),
            );
          } else {
            CustomSnackBar.show(
              context,
              message: 'Verification code sent to your email',
              type: SnackBarType.success,
            );
          }
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final showVerificationField = state is AuthPasswordResetInProgress;

        return ForgetPasswordForm(
          isLoading: isLoading,
          showVerificationField: showVerificationField,
          email: showVerificationField
              ? (state).email
              : null,
        );
      },
    );
  }
}
