import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/helper/validators.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_button.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_text_field.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/auth_account_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.isLoading});

  final bool isLoading;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            hintText: 'Email Address',
            prefixIcon: const Icon(
              Icons.email,
              color: AppColors.darkGrey,
            ),
            validator: AppValidator.validateEmail,
          ),
          heightBox(10),
          CustomTextField(
            controller: passwordController,
            hintText: 'Password',
            isPassword: true,
            prefixIcon: const Icon(
              Icons.lock,
              color: AppColors.darkGrey,
            ),
            validator: AppValidator.validatePassword,
          ),
          heightBox(10),
          AuthAccountText(
            mainAxisAlignment: MainAxisAlignment.start,
            questionText: 'Forget Password?',
            actionText: ' Reset',
            onTap: () {
              context.push(AppRouter.forgetPasswordView);
            },
          ),
          heightBox(30),
          CustomButton(
            text: 'Sign In',
            onPressed: widget.isLoading ? null : _handleLogin,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().signInWithEmail(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
    }
  }
}
