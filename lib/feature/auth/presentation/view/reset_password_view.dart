import 'package:clothes_ecommerce_app/core/di/app_providers.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/reset_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({
    super.key,
    required this.email,
    required this.token,
  });

  final String email;
  final String token;

  @override
  Widget build(BuildContext context) {
    return AppProviders.auth(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ResetPasswordViewBody(
              email: email,
              token: token,
            ),
          ),
        ),
      ),
    );
  }
}
