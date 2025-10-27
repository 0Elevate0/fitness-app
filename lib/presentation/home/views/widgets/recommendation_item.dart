import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendationItem extends StatelessWidget {
  const RecommendationItem({super.key, required this.muscleData});
  final MuscleEntity muscleData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        // Navigate To Exercise Details Screen
        // use muscleData.id as argument data to fetch the exercise data
      },
      child: Container(
        width: 104.r,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryFixed.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20.r),
          image: DecorationImage(
            image: muscleData.image != null
                ? CachedNetworkImageProvider(muscleData.image ?? "")
                : const AssetImage(AppImages.notFound),
            fit: BoxFit.cover,
          ),
        ),
        child: RSizedBox(
          height: 30,
          width: ScreenUtil().screenWidth,
          child: BlurredContainer(
            padding: REdgeInsets.symmetric(vertical: 8, horizontal: 4),
            blurColor: theme.colorScheme.secondary.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20.r),
            halfTheBlurValue: 5,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                muscleData.name ?? AppText.notProvided.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
