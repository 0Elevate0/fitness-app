import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DifficultyLevelsShimmer extends StatelessWidget {
  const DifficultyLevelsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: List.generate(
          4,
              (index) => Container(
            margin: REdgeInsets.only(right: 12),
            child:   ShimmerEffect(
              width: 80.w,
              height: 35.h,
              radius: 20.r,
            ),
          ),
        ),
      ),
    ); }
}
