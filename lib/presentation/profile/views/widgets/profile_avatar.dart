import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: 100.r,
          height: 100.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                blurRadius: 14.r,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 50.r,
            backgroundColor: Colors.transparent,
            backgroundImage: CachedNetworkImageProvider(
              FitnessMethodHelper.userData?.photo ?? "",
            ),
            onBackgroundImageError: (_, _) =>
                ShimmerEffect(width: 100.r, height: 100.r, radius: 100.r),
          ),
        ),
        const RSizedBox(height: 8),
        Text(
          "${FitnessMethodHelper.userData?.firstName} ${FitnessMethodHelper.userData?.lastName}",
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
