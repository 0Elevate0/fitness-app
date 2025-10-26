import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscles_group_list.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscles_list.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutsSection extends StatelessWidget {
  const WorkoutsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                            // Navigate To Workout Screen from here with the loaded data
                            // use state.musclesGroupStatus.data And  state.musclesByGroupStatus.data
                          }
                        : () {},
                    child: Text(
                      AppText.seeAll,
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
