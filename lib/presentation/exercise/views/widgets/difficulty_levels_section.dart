import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/shimmer/difficulty_levels_shimmer.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DifficultyLevelsSection extends StatelessWidget {
  final List<DifficultyLevelEntity> levels;
  final DifficultyLevelEntity? selected;
  final void Function(DifficultyLevelEntity) onSelect;

  const DifficultyLevelsSection({
    super.key,
    required this.levels,
    this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (BuildContext context, state) {
        if (state.difficultyLevelsStatus.isLoading) {
          return const DifficultyLevelsShimmer();
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: levels.map((level) {
              final bool isSelected = selected?.id == level.id;
              return GestureDetector(
                onTap: () => onSelect(level),
                child: Container(
                  margin: REdgeInsets.only(right: 35),
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(level.name ?? ''),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
