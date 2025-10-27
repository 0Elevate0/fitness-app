import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MuscleGroupItem extends StatelessWidget {
  const MuscleGroupItem({
    super.key,
    required this.muscleGroupData,
    required this.isSelected,
  });
  final MuscleGroupEntity muscleGroupData;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return GestureDetector(
      onTap: () async => await homeCubit.doIntent(
        intent: ChangeMusclesGroupIntent(
          muscleGroupId: muscleGroupData.id ?? "",
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected
              ? Border.all(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                    blurRadius: 8.r,
                    blurStyle: BlurStyle.outer,
                  ),
                ]
              : null,
        ),

        child: Text(
          muscleGroupData.name ?? AppText.notProvided.tr(),
          style: isSelected
              ? theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSecondary,
                )
              : theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
