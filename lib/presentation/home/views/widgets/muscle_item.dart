import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/domain/entities/exercise_argument/exercise_argument.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MuscleItem extends StatelessWidget {
  const MuscleItem({super.key, required this.muscleData});
  final MuscleEntity muscleData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.exercise,
          arguments: ExerciseArgument(muscle: muscleData),
        );
      },
      child: RSizedBox(
        width: 80,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CachedNetworkImage(
                height: 80,
                imageUrl: muscleData.image ?? "",
                errorWidget: (context, url, error) =>
                    Image.asset(AppImages.notFound, fit: BoxFit.cover),
                placeholder: (context, url) =>
                    ShimmerEffect(width: 80.r, height: 80.r),
                fit: BoxFit.cover,
              ),
            ),
            RSizedBox(
              height: 22,
              width: ScreenUtil().screenWidth,
              child: BlurredContainer(
                padding: REdgeInsets.all(4),
                blurColor: theme.colorScheme.secondary.withValues(alpha: 0.5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                  topLeft: const Radius.circular(0),
                  topRight: const Radius.circular(0),
                ),
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
          ],
        ),
      ),
    );
  }
}
