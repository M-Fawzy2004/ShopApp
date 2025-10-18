import 'package:clothes_ecommerce_app/core/di/app_providers.dart';
import 'package:clothes_ecommerce_app/feature/profile/presentation/view/widget/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders.auth(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const ProfileViewBody(),
          ),
        ),
      ),
    );
  }
}
