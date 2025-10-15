import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/email_verf_view_bloc_consumer.dart';
import 'package:flutter/material.dart';

class EmailVerfView extends StatelessWidget {
  final Map<String, dynamic> data;

  const EmailVerfView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final email = data['email'] as String;
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: EmailVerfViewBlocConsumer(email: email),
        ),
      ),
    );
  }
}