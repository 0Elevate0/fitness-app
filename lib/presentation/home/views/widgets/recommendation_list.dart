import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/recommendation_item.dart';
import 'package:fitness_app/presentation/home/views/widgets/shimmer/recommendation_list_shimmer.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendationList extends StatelessWidget {
  const RecommendationList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current.recommendationStatus.isLoading ||
          current.recommendationStatus.isSuccess,
      builder: (context, state) {
        if (state.recommendationStatus.isSuccess) {
          return RSizedBox(
            height: 104,
            child: (state.recommendationStatus.data?.isNotEmpty ?? false)
                ? ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) => RecommendationItem(
                      muscleData: state.recommendationStatus.data![index],
                    ),
                    separatorBuilder: (_, _) => const RSizedBox(width: 16),
                    itemCount: state.recommendationStatus.data!.length,
                  )
                : Center(
                    child: Text(
                      AppText.emptyExercisesRecommendationMessage.tr(),
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
          );
        } else {
          return const RecommendationListShimmer();
        }
      },
    );
  }
}
