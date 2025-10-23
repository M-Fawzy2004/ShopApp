import 'dart:ui';
import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    super.key,
    this.onChanged,
    this.onTap,
    this.hintText,
  });
  
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final String? hintText;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.large),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(AppRadius.large),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5.w,
            ),
          ),
          child: TextFormField(
            controller: _controller,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            style: AppStyles.font16BlackBold(context),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 14.sp,
              ),
              prefixIcon: const Icon(
                IconlyBold.search,
                color: Colors.black54,
              ),
              suffixIcon: _hasText
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black54,
                        size: 20.sp,
                      ),
                      onPressed: _clearSearch,
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.large),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.large),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}