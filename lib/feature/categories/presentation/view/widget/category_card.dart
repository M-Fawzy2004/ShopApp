import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/extension.dart';
import 'package:clothes_ecommerce_app/feature/categories/presentation/view/widget/category_info_overlay.dart';
import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/categories_details_view.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final double height;
  final int index;
  final CategoryEntity category;

  const CategoryCard({
    super.key,
    required this.height,
    required this.index,
    required this.category,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: () {
        context.navigateWithSlideTransition(
           CategoriesDetailsView(category: widget.category),
        );
      },
      child: AnimatedScale(
        scale: isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.regular),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.regular),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.category.imageUrl,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CategoryInfoOverlay(widget: widget),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
