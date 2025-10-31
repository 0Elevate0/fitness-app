import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/shimmer/muscle_grid_shimmer.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscle_item.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_cubit.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkOutMuscleList extends StatelessWidget {
  const WorkOutMuscleList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<WorkOutCubit, WorkOutState>(
      builder: (context, state) {
        if (state.musclesByGroupStatus.isLoading &&
            state.selectedMuscleGroup?.id !=
                state.groupArgument?.selectedMuscleGroup?.id) {
          return const MusclesGridShimmer();
        }
        if (state.musclesByGroupStatus.isSuccess) {
          final muscles = state.groupArgument?.muscle ?? [];
          return muscles.isNotEmpty
              ? GridView.builder(
                  padding: REdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18.h,
                    crossAxisSpacing: 18.w,
                    childAspectRatio: 1,
                  ),
                  itemCount: muscles.length,
                  itemBuilder: (_, index) =>
                      WorkOutMuscleItem(muscleData: muscles[index]),
                )
              : Center(
                  child: Text(
                    AppText.emptyExercisesGroupMessage.tr(),
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                );
        }
        return const MusclesGridShimmer();
      },
    );
  }
}
