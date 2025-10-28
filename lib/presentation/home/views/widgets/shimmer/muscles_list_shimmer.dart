import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusclesListShimmer extends StatelessWidget {
  const MusclesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      height: 80,
      child: ListView.separated(
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => Container(
          width: 80.r,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: ShimmerEffect(width: 80.r, height: 80.r, radius: 20.r),
        ),
        separatorBuilder: (_, __) => const RSizedBox(width: 8),
        itemCount: 16,
      ),
    );
  }
}
