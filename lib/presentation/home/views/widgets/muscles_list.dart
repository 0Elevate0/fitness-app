import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscle_item.dart';
import 'package:fitness_app/presentation/home/views/widgets/shimmer/muscles_list_shimmer.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusclesList extends StatelessWidget {
  const MusclesList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RSizedBox(
      height: 80,
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current.musclesByGroupStatus.isLoading ||
            current.musclesByGroupStatus.isSuccess,
        builder: (context, state) {
          if (state.musclesByGroupStatus.isSuccess) {
            return (state.musclesByGroupStatus.data?.isNotEmpty ?? false)
                ? ListView.separated(
                    clipBehavior: Clip.none,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => MuscleItem(
                      muscleData: state.musclesByGroupStatus.data![index],
                    ),
                    separatorBuilder: (_, __) => const RSizedBox(width: 8),
                    itemCount: state.musclesByGroupStatus.data!.length,
                  )
                : Center(
                    child: Text(
                      AppText.emptyExercisesGroupMessage.tr(),
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  );
          } else {
            return const MusclesListShimmer();
          }
        },
      ),
    );
  }
}
