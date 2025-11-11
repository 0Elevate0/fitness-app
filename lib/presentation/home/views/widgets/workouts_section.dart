import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/muscle_with_group_argument/muscle_with_group_argument.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_intent.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscles_group_list.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscles_list.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:fitness_app/presentation/work_out/views/work_out_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutsSection extends StatelessWidget {
  const WorkoutsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final fitnessBottomNavCubit = BlocProvider.of<FitnessBottomNavigationCubit>(
      context,
    );
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: FittedBox(
                alignment: AlignmentDirectional.centerStart,
                fit: BoxFit.scaleDown,
                child: Text(
                  AppText.upcomingWorkouts.tr(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerEnd,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) => TextButton(
                    onPressed:
                        state.musclesGroupStatus.isSuccess &&
                            state.musclesByGroupStatus.isSuccess
                        ? () {
                            fitnessBottomNavCubit.doIntent(
                              intent: ChangeIndexIntent(
                                index: 2,
                                changedTap: WorkOutView(
                                  groupArgument: MuscleWithGroupArgument(
                                    muscleGroup: state.musclesGroupStatus.data,
                                    muscle: state.musclesByGroupStatus.data,
                                    selectedMuscleGroup:
                                        state.selectedMuscleGroup,
                                  ),
                                ),
                              ),
                            );
                          }
                        : () {},
                    child: Text(
                      AppText.seeAll.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const RSizedBox(height: 4),
        const MusclesGroupList(),
        const RSizedBox(height: 8),
        const MusclesList(),
      ],
    );
  }
}
