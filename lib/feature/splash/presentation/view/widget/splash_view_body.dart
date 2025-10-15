import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/feature/splash/presentation/manager/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key, required this.opacities});

  final List<double> opacities;

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  final List<String> letters = ['S', 'H', 'O', 'P'];

  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          letters.length,
          (index) {
            return AnimatedOpacity(
              opacity: widget.opacities[index].clamp(0.0, 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                scale: widget.opacities[index] > 0 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.elasticOut,
                child: Text(
                  letters[index],
                  style: TextStyle(
                    fontSize: 60.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    letterSpacing: 8.w,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
