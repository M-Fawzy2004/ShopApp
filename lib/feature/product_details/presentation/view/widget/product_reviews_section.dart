import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/review_entity.dart';

class ProductReviewsSection extends StatefulWidget {
  const ProductReviewsSection({
    super.key,
    required this.reviews,
  });

  final List<ReviewEntity> reviews;

  @override
  State<ProductReviewsSection> createState() => _ProductReviewsSectionState();
}

class _ProductReviewsSectionState extends State<ProductReviewsSection> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    if (widget.reviews.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayedReviews =
        _showAll ? widget.reviews : widget.reviews.take(1).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews (${widget.reviews.length})',
          style: AppStyles.font16BlackBold(context).copyWith(
            fontSize: 18.sp,
            color: const Color(0xFF333333),
          ),
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayedReviews.length,
          separatorBuilder: (context, index) => heightBox(12),
          itemBuilder: (context, index) {
            return ProductReviewCard(review: displayedReviews[index]);
          },
        ),
        if (widget.reviews.length > 1)
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  _showAll = !_showAll;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _showAll ? 'Show Less' : 'See More',
                    style: AppStyles.font14BlackBold(context).copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Icon(
                    _showAll
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.primaryColor,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
