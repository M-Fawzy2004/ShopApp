import 'package:clothes_ecommerce_app/feature/main_home/presentation/view/widget/custom_bottom_navigation_bar.dart';
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
        const Center(child: Text('Home')),
        const Center(child: Text('Notfication')),
        const Center(child: Text('Cart')),
        const Center(child: Text('Profile')),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: getScreens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: changeIndex,
      ),
    );
  }
}
