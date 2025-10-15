import 'package:flutter/material.dart';

class RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final triangleWidth = 15.0;

    path.moveTo(size.width, 0);

    path.lineTo(0, 0);

    path.lineTo(triangleWidth, size.height / 2);

    path.lineTo(0, size.height);

    path.lineTo(size.width, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
