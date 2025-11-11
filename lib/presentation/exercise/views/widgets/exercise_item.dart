import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseItem extends StatelessWidget {
  final ExerciseEntity exercise;
  final MuscleEntity muscleData;

  const ExerciseItem({
    super.key,
    required this.exercise,
    required this.muscleData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<ExerciseCubit>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: CachedNetworkImage(
                  imageUrl: muscleData.image ?? '',
                  height: 70.r,
                  width: 70.r,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      Image.asset(AppImages.notFound, fit: BoxFit.cover),
                  errorWidget: (_, __, ___) => Image.asset(
                    muscleData.image != null
                        ? muscleData.image!
                        : AppImages.notFound,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const RSizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.exercise ?? "",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const RSizedBox(height: 6),
                    Text(
                      AppText.exerciseReps.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const RSizedBox(height: 2),
                    Text(
                      exercise.primaryEquipment ?? "",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const RSizedBox(width: 10),
              InkWell(
                onTap: () {
                  cubit.doIntent(PlayVideoIntent(exercise: exercise));
                },
                child: Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: theme.colorScheme.secondaryFixed,
                    size: 28.sp,
                  ),
                ),
              ),
            ],
          ),
          const RSizedBox(height: 12),
          Divider(thickness: 2, color: AppColors.gray[800], height: 2),
          const RSizedBox(height: 12),
        ],
      ),
    );
  }
}
