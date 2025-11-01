import 'package:fitness_app/presentation/work_out/views/widgets/work_out_app_bar.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscle_list.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscles_group_list.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_cubit.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_intent.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_state.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkOutViewBody extends StatelessWidget {
  const WorkOutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkOutCubit, WorkOutState>(
      listenWhen: (previous, current) =>
          current.musclesByGroupStatus.isFailure ||
          current.musclesGroupStatus.isFailure,
      listener: (context, state) {
        if (state.musclesByGroupStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.musclesByGroupStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.musclesGroupStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.musclesGroupStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      child: Column(
        children: [
          const WorkOutAppBar(),
          const RSizedBox(height: 20),
          const WorkOutMusclesGroupList(),
          const RSizedBox(height: 20),
          Expanded(
            child: BlocBuilder<WorkOutCubit, WorkOutState>(
              buildWhen: (p, c) =>
                  p.groupArgument != c.groupArgument ||
                  p.tabIndex != c.tabIndex,
              builder: (context, state) {
                final group = state.groupArgument?.muscleGroup ?? [];
                final pageController = context
                    .read<WorkOutCubit>()
                    .pageController;
                return PageView.builder(
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: group.length,
                  itemBuilder: (context, index) => const WorkOutMuscleList(),
                  onPageChanged: (index) {
                    final muscle = group[index];
                    context.read<WorkOutCubit>().doIntent(
                      intent: ChangeWorkOutMusclesGroupIntent(
                        muscleGroup: muscle,
                        fromSwipe: true,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
