import 'package:clothes_ecommerce_app/core/const/app_const.dart';
import 'package:clothes_ecommerce_app/core/di/get_it_service.dart';
import 'package:clothes_ecommerce_app/ecommerce_app.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(ProductAdapter());

  // Open boxes
  final cartBox = await Hive.openBox<Product>(AppConst.cartBox);
  final favoriteBox = await Hive.openBox<Product>(AppConst.favoriteBox);

  // Initialize dependencies and setup cart dependencies
  await initDependencies();
  setupCartDependencies(cartBox);
  setupFavoriteDependencies(favoriteBox);

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const EcommerceApp(),
    ),
  );
}
