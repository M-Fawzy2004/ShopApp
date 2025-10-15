import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/helper/validators.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_button.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_text_field.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.isLoading});

  final bool isLoading;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: firstNameController,
            hintText: 'First Name',
            prefixIcon: const Icon(
              Icons.person,
              color: AppColors.darkGrey,
            ),
            validator: AppValidator.validateName,
          ),
          heightBox(16),
          CustomTextField(
            controller: lastNameController,
            hintText: 'Last Name',
            prefixIcon: const Icon(
              Icons.person,
              color: AppColors.darkGrey,
            ),
            validator: AppValidator.validateName,
          ),
          heightBox(16),
          CustomTextField(
            controller: emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(
              Icons.email,
              color: AppColors.darkGrey,
            ),
            validator: AppValidator.validateEmail,
          ),
          heightBox(16),
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
          heightBox(40),
          CustomButton(
            text: 'Verify Email',
            isLoading: widget.isLoading,
            onPressed: widget.isLoading ? null : handleRegister,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleRegister() {
    if (formKey.currentState!.validate()) {
      final fullName =
          '${firstNameController.text.trim()} ${lastNameController.text.trim()}';

      context.read<AuthCubit>().signUpWithEmail(
            email: emailController.text.trim(),
            password: passwordController.text,
            displayName: fullName,
          );
    }
  }
}
