import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscle_group_item.dart';
import 'package:fitness_app/presentation/home/views/widgets/shimmer/muscles_group_list_shimmer.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusclesGroupList extends StatelessWidget {
  const MusclesGroupList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RSizedBox(
      height: 34,
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current.musclesGroupStatus.isLoading ||
            current.musclesGroupStatus.isSuccess,
        builder: (context, state) {
          if (state.musclesGroupStatus.isSuccess) {
            return (state.musclesGroupStatus.data?.isNotEmpty ?? false)
                ? ListView.separated(
                    clipBehavior: Clip.none,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => MuscleGroupItem(
                      muscleGroupData: state.musclesGroupStatus.data![index],
                      isSelected:
                          state.selectedMuscleGroup ==
                          state.musclesGroupStatus.data![index],
                    ),
                    separatorBuilder: (_, __) => const RSizedBox(width: 8),
                    itemCount: state.musclesGroupStatus.data!.length,
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
                  );
          } else {
            return const MusclesGroupListShimmer();
          }
        },
      ),
    );
  }
}
