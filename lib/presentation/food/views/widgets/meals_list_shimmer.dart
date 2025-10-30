import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealsListShimmer extends StatelessWidget {
  const MealsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      height: 104,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.7,
        ),
        itemCount: 12,
        itemBuilder: (buildContext, index) => Container(
          width: 104.r,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: ShimmerEffect(width: 104.r, height: 104.r, radius: 20.r),
        ),
      ),
    );
  }
}
