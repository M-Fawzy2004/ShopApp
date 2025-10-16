import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/helper/validators.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_button.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_text_field.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({
    super.key,
    required this.isLoading,
    required this.email,
    required this.token,
  });

  final bool isLoading;
  final String email;
  final String token;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void handleResetPassword() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().resetPassword(
            email: widget.email,
            token: widget.token,
            newPassword: newPasswordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: newPasswordController,
            isPassword: true,
            hintText: 'Enter New Password',
            validator: AppValidator.validatePassword,
            enabled: !widget.isLoading,
          ),
          heightBox(24),
          CustomTextField(
            controller: confirmPasswordController,
            isPassword: true,
            hintText: 'Confirm New Password',
            enabled: !widget.isLoading,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != newPasswordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          heightBox(24),
          CustomButton(
            text: 'Save Password',
            onPressed: widget.isLoading ? null : handleResetPassword,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
