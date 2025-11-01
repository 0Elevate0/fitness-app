import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entities/exercise_argument/exercise_argument.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/entities/popular_training/popular_training_entity.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularTrainingItem extends StatelessWidget {
  const PopularTrainingItem({super.key, required this.popularTrainingData});
  final PopularTrainingEntity popularTrainingData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.exercise,
          arguments: ExerciseArgument(
            muscle: MuscleEntity(
              id: popularTrainingData.muscleId,
              name: popularTrainingData.title.tr(),
              image: popularTrainingData.backgroundImage,
            ),
            difficultyLevel: DifficultyLevelEntity(
              id: popularTrainingData.levelId,
              name: popularTrainingData.level.tr(),
            ),
          ),
        );
      },
      child: RSizedBox(
        height: 176.h,
        width: 200.w,
        child: Stack(
          children: [
            Positioned.fill(
              child: BlurredContainer(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(20.r),
                halfTheBlurValue: 2.5,
                blurColor: theme.colorScheme.secondaryFixed.withValues(
                  alpha: 0.1,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    color: theme.colorScheme.secondaryFixed.withValues(
                      alpha: 0.5,
                    ),
                    colorBlendMode: BlendMode.dstOut,
                    popularTrainingData.backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    popularTrainingData.title.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const RSizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: BlurredContainer(
                          borderRadius: BorderRadius.circular(20.r),
                          padding: REdgeInsets.all(8),
                          blurColor: theme.colorScheme.secondary.withValues(
                            alpha: 0.5,
                          ),
                          halfTheBlurValue: 5,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${popularTrainingData.numberOfTasks} ${AppText.tasks.tr()}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: BlurredContainer(
                          borderRadius: BorderRadius.circular(20.r),
                          padding: REdgeInsets.all(8),
                          blurColor: theme.colorScheme.secondary.withValues(
                            alpha: 0.5,
                          ),
                          halfTheBlurValue: 5,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              popularTrainingData.level.tr(),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const RSizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
