import 'package:clothes_ecommerce_app/feature/cart/presentation/view/cart_view.dart';
import 'package:clothes_ecommerce_app/feature/categories/presentation/view/categories_view.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/home_view.dart';
import 'package:clothes_ecommerce_app/feature/main_home/presentation/view/widget/custom_bottom_navigation_bar.dart';
import 'package:clothes_ecommerce_app/feature/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> get getScreens => [
        HomeView(onNavigateToSubjects: () => changeIndex(1)),
        const CategoriesView(),
        const CartView(),
        const ProfileView(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: IndexedStack(
          index: currentIndex,
          children: getScreens,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: changeIndex,
      ),
    );
  }
}
