import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_intent.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MuscleHeaderSection extends StatelessWidget {
  final MuscleEntity muscleData;
  final ExerciseEntity? exerciseEntity;

  const MuscleHeaderSection({
    super.key,
    required this.muscleData,
    this.exerciseEntity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<ExerciseCubit>(context);
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (context, state) {
        return Stack(
          children: [
            RSizedBox(
              height: 350,
              width: double.infinity,
              child: state.isPlayingVideo && state.selectedVideoId != null
                  ? YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: state.selectedVideoId!,
                          flags: const YoutubePlayerFlags(autoPlay: true),
                        ),
                        showVideoProgressIndicator: true,
                        progressColors: ProgressBarColors(
                          playedColor: theme.colorScheme.primary,
                          handleColor: theme.colorScheme.primary,
                        ),
                        onEnded: (_) => cubit.doIntent(const StopVideoIntent()),
                      ),
                      builder: (context, player) => player,
                    )
                  : CachedNetworkImage(
                      imageUrl: muscleData.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Image.asset(
                        AppImages.notFound,
                        height: 60.r,
                        width: 60.r,
                      ),
                      errorWidget: (_, __, ___) => Image.asset(
                        AppImages.notFound,
                        height: 60.r,
                        width: 60.r,
                      ),
                    ),
            ),
            if (state.isPlayingVideo && state.selectedVideoId != null)
              Positioned(
                top: 16.h,
                right: 16.w,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: theme.colorScheme.onSecondary,
                    size: 28,
                  ),
                  onPressed: () => cubit.doIntent(const StopVideoIntent()),
                ),
              ),
            Positioned(top: 20.r, left: 15.r, child: const CustomBackArrow()),
            if (!state.isPlayingVideo) ...[
              Positioned(
                bottom: 120.h,
                left: 20.w,
                right: 20.w,
                child: Text(
                  muscleData.name ?? "",
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),

              Positioned(
                bottom: 0.h,
                left: 0.w,
                right: 0.w,
                child: BlurredContainer(
                  halfTheBlurValue: 8,
                  borderRadius: BorderRadius.zero,
                  padding: REdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${muscleData.name} ${AppText.title} ${muscleData.name?.toLowerCase()} muscles.",
                        style: theme.textTheme.headlineSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const RSizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: REdgeInsets.all(8),

                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.colorScheme.onSecondary,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: const Text(AppText.mins),
                          ),
                          Container(
                            padding: REdgeInsets.all(8),

                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.colorScheme.onSecondary,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              AppText.cal,
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
