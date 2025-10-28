import 'package:fitness_app/presentation/work_out/views/widgets/work_out_app_bar.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscle_list.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscles_group_list.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_cubit.dart';
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
      listenWhen: (previous, current) => current.musclesByGroupStatus.isFailure,
      listener: (context, state) {
        if (state.musclesByGroupStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.musclesByGroupStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      child: const Column(
        children: [
          WorkOutAppBar(),
          RSizedBox(height: 20),
          WorkOutMusclesGroupList(),
          RSizedBox(height: 20),
          Expanded(child: WorkOutMuscleList()),
        ],
      ),
    );
  }
}
