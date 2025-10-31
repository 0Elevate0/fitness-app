import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusclesGridShimmer extends StatelessWidget {
  const MusclesGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: GridView.builder(
        padding: REdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          mainAxisSpacing: 18.h,
          crossAxisSpacing: 18.w,
          childAspectRatio: 1, // keep them square
        ),
        itemCount: 6,
        // shimmer placeholders count
        itemBuilder: (_, __) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: ShimmerEffect(
            width: double.infinity,
            height: double.infinity,
            radius: 20.r,
          ),
        ),
      ),
    );
  }
}
