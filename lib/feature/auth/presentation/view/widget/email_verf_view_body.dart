import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/core/utils/assets.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_button.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_text_field.dart';
import 'package:clothes_ecommerce_app/core/widget/icon_back.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerfViewBody extends StatefulWidget {
  final String email;
  
  const EmailVerfViewBody({super.key, required this.email});

  @override
  State<EmailVerfViewBody> createState() => _EmailVerfViewBodyState();
}

class _EmailVerfViewBodyState extends State<EmailVerfViewBody> {
  final codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(13),
          const IconBack(),
          heightBox(20),
          Text(
            'Email Verification',
            style: AppStyles.font32BlackBold(context),
          ),
          Image.asset(Assets.imagesPngVerfEmail),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: TextEditingController(text: widget.email),
                  hintText: 'Enter Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                heightBox(20),
                CustomTextField(
                  controller: codeController,
                  hintText: 'Enter Code',
                  keyboardType: TextInputType.number,
                ),
                heightBox(24),
                CustomButton(
                  text: 'Verify',
                  onPressed: handleVerify,
                ),
                heightBox(16),
                TextButton(
                  onPressed: handleResendCode,
                  child: const Text('Resend Code'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void handleVerify() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().verifyEmailOTP(
        email: widget.email,
        token: codeController.text.trim(),
      );
    }
  }

  void handleResendCode() {
    context.read<AuthCubit>().resendVerificationCode(widget.email);
  }
}