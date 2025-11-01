import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDialogContent extends StatelessWidget {
  const YoutubeDialogContent({
    super.key,
    required this.controller,
    this.onBackTapped,
  });
  final YoutubePlayerController controller;
  final void Function()? onBackTapped;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RSizedBox(
      width: ScreenUtil().screenWidth,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              height: 235.h,
              margin: REdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 12.r,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: YoutubePlayer(
                  controller: controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: theme.colorScheme.primary,
                  progressColors: ProgressBarColors(
                    playedColor: theme.colorScheme.primary,
                    handleColor: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const RSizedBox(height: 16),
            CustomElevatedButton(
              width: 0.5.sw,
              onPressed: onBackTapped,
              buttonTitle: AppText.back,
            ),
          ],
        ),
      ),
    );
  }
}
