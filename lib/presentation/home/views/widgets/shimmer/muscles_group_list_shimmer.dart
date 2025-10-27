import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusclesGroupListShimmer extends StatelessWidget {
  const MusclesGroupListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      height: 34,
      child: ListView.separated(
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => Container(
          alignment: Alignment.center,
          padding: REdgeInsets.all(2),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: ShimmerEffect(width: 65.r, height: 34.r, radius: 20.r),
        ),
        separatorBuilder: (_, __) => const RSizedBox(width: 8),
        itemCount: 16,
      ),
    );
  }
}
