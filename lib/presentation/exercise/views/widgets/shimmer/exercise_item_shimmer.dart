import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseItemShimmer extends StatelessWidget {
  const ExerciseItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerEffect(width: 70.w, height: 70.h),
        const RSizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(width: 150.w, height: 20.h),
              const RSizedBox(height: 6),
              ShimmerEffect(width: 100.w, height: 14.h),
              const RSizedBox(height: 6),
              ShimmerEffect(width: 80.w, height: 14.h),
            ],
          ),
        ),
        const RSizedBox(width: 10),
        ShimmerEffect(width: 35.w, height: 35.h, radius: 100.r),
      ],
    );
  }
}
