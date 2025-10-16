import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/forget_password_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordFormBlocConsumer extends StatelessWidget {
  const ForgetPasswordFormBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return ForgetPasswordForm(isLoading: isLoading);
      },
    );
  }
}
