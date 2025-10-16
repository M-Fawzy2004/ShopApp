import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/helper/validators.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_button.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_text_field.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({
    super.key,
    required this.isLoading,
    required this.showVerificationField,
    this.email,
  });

  final bool isLoading;
  final bool showVerificationField;
  final String? email;

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final verificationCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.email != null) {
      emailController.text = widget.email!;
    }
  }

  @override
  void didUpdateWidget(ForgetPasswordForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.email != null && widget.email != oldWidget.email) {
      emailController.text = widget.email!;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

  void handleSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      final authCubit = context.read<AuthCubit>();

      if (widget.showVerificationField) {
        context.push(
          AppRouter.resetPasswordView,
          extra: {
            'email': emailController.text.trim(),
            'token': verificationCodeController.text.trim(),
          },
        );
      } else {
        authCubit.sendPasswordResetCode(emailController.text.trim());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            hintText: 'Enter Email Address',
            validator: AppValidator.validateEmail,
            enabled: !widget.showVerificationField && !widget.isLoading,
            keyboardType: TextInputType.emailAddress,
          ),
          if (widget.showVerificationField) ...[
            heightBox(24),
            CustomTextField(
              controller: verificationCodeController,
              hintText: 'Enter Verification Code',
              keyboardType: TextInputType.number,
              validator: AppValidator.validateCode,
              enabled: !widget.isLoading,
            ),
          ],
          heightBox(24),
          CustomButton(
            text: widget.showVerificationField ? 'Verify Code' : 'Send Code',
            onPressed: widget.isLoading ? null : handleSubmit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
