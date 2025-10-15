import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/send_email_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendEmailView extends StatelessWidget {
  const SendEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const SendEmailViewBody(),
        ),
      ),
    );
  }
}
