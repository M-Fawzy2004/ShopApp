import 'package:clothes_ecommerce_app/ecommerce_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const EcommerceApp(),
    ),
  );
}
