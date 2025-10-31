import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseItemShimmer extends StatelessWidget {
  const ExerciseItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Row(
      children: [

        ShimmerEffect(width: 70, height: 70),
        RSizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(width: 150, height: 20),
              RSizedBox(height: 6),
              ShimmerEffect(width: 100, height: 14),
              RSizedBox(height: 6),
              ShimmerEffect(width: 80, height: 14),
            ],
          ),
        ),
        RSizedBox(width: 10),
        ShimmerEffect(width: 35, height: 35, radius: 100),
      ],
    );
  }
}
