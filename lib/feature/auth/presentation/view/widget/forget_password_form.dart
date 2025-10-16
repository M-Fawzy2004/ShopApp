import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/helper/validators.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_button.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_text_field.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key, required this.isLoading});

  final bool isLoading;

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final emailController = TextEditingController();
  final verificationCodeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool showVerificationCode = false;
  bool showPasswordFields = false;

  @override
  void dispose() {
    emailController.dispose();
    verificationCodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordResetVerification) {
          setState(() {
            showVerificationCode = true;
          });
        } else if (state is AuthPasswordResetCodeVerified) {
          setState(() {
            showPasswordFields = true;
          });
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: emailController,
              hintText: 'Enter Email Address',
              validator: AppValidator.validateEmail,
              enabled: !showVerificationCode,
            ),
            if (showVerificationCode) ...[
              heightBox(24),
              CustomTextField(
                controller: verificationCodeController,
                hintText: 'Enter Verification Code',
                keyboardType: TextInputType.number,
                validator: AppValidator.validateCode,
                enabled: !showPasswordFields,
              ),
            ],
            if (showPasswordFields) ...[
              heightBox(24),
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter New Password',
                validator: AppValidator.validatePassword,
                isPassword: true,
              ),
              heightBox(24),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                isPassword: true,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ],
            heightBox(24),
            CustomButton(
              text: showPasswordFields
                  ? 'Reset Password'
                  : showVerificationCode
                      ? 'Verify Code'
                      : 'Send Code',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
