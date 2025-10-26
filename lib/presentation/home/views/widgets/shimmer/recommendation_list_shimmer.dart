import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendationListShimmer extends StatelessWidget {
  const RecommendationListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => Container(
          width: 104.r,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: ShimmerEffect(width: 104.r, height: 104.r),
        ),
        separatorBuilder: (_, _) => const RSizedBox(width: 16),
        itemCount: 12,
      ),
    );
  }
}
