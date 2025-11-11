import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/shimmer/muscles_group_list_shimmer.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscle_group_item.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_cubit.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkOutMusclesGroupList extends StatelessWidget {
  const WorkOutMusclesGroupList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<WorkOutCubit, WorkOutState>(
      buildWhen: (p, c) =>
          p.selectedMuscleGroup != c.selectedMuscleGroup ||
          p.groupArgument != c.groupArgument,
      builder: (context, state) {
        final selected =
            state.selectedMuscleGroup ??
            state.groupArgument?.selectedMuscleGroup;
        if (state.musclesGroupStatus.isSuccess) {
          return RSizedBox(
            height: 34,
            child: (state.musclesGroupStatus.data?.isNotEmpty ?? false)
                ? ListView.separated(
                    clipBehavior: Clip.none,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.groupArgument?.muscleGroup?.length ?? 0,
                    controller: ScrollController(
                      initialScrollOffset: selected != null
                          ? (state.groupArgument?.muscleGroup?.indexWhere(
                                      (mg) => mg.id == selected.id,
                                    ) ??
                                    0) *
                                75.w
                          : 0,
                    ),
                    itemBuilder: (_, index) {
                      final muscleGroup =
                          state.groupArgument!.muscleGroup![index];
                      return WorkOutMuscleGroupItem(
                        muscleGroupData: muscleGroup,
                        isSelected: selected?.id == muscleGroup.id,
                      );
                    },
                    separatorBuilder: (_, __) => const RSizedBox(width: 8),
                  )
                : Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppText.emptyExerciseGroupsMessage.tr(),
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          );
        } else {
          return const MusclesGroupListShimmer();
        }
      },
    );
  }
}
