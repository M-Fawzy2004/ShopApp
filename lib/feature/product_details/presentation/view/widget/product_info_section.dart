import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Additional Information
        Text(
          'Additional Information',
          style: AppStyles.font16BlackBold(context),
        ),
        heightBox(20),
        // Dimensions
        ProductInfoRow(
          icon: IconlyLight.category,
          title: 'Dimensions',
          value:
              '${product.dimensions.width} x ${product.dimensions.height} x ${product.dimensions.depth} cm',
          iconColor: Colors.blue,
        ),
        //  divider
        Divider(height: 24.h, color: Colors.grey.shade300),
        // Warranty
        ProductInfoRow(
          icon: IconlyLight.shield_done,
          title: 'Warranty',
          value: product.warrantyInformation,
          iconColor: Colors.green,
        ),
        // divider
        Divider(height: 24.h, color: Colors.grey.shade300),
        // Shipping
        ProductInfoRow(
          icon: IconlyLight.buy,
          title: 'Shipping',
          value: product.shippingInformation,
          iconColor: Colors.orange,
        ),
        // divider
        Divider(height: 24.h, color: Colors.grey.shade300),
        // Availability
        ProductInfoRow(
          icon: IconlyLight.tick_square,
          title: 'Availability',
          value: product.availabilityStatus,
          iconColor: product.availabilityStatus.toLowerCase().contains('stock')
              ? Colors.green
              : Colors.red,
        ),
      ],
    );
  }
}
