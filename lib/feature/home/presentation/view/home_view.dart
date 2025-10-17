import 'package:clothes_ecommerce_app/core/di/app_providers.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.onNavigateToSubjects});

  final VoidCallback? onNavigateToSubjects;

  @override
  Widget build(BuildContext context) {
    return AppProviders.getApi(
      child:  Scaffold(
        body: HomeViewBody(onNavigateToSubjects : onNavigateToSubjects,),
      ),
    );
  }
}
