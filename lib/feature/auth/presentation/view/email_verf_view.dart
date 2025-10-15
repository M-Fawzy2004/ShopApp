import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/email_verf_view_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailVerfView extends StatelessWidget {
  final String email;
  
  const EmailVerfView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: EmailVerfViewBlocConsumer(email: email),
        ),
      ),
    );
  }
}