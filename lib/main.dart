import 'package:clothes_ecommerce_app/core/const/app_const.dart';
import 'package:clothes_ecommerce_app/core/di/get_it_service.dart';
import 'package:clothes_ecommerce_app/ecommerce_app.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  await dotenv.load(fileName: ".env");

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
    const EcommerceApp(),
  );
}
