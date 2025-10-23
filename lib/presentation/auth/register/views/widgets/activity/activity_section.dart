import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/activity/activity_choices.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/activity/activity_done_button.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_progress.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivitySection extends StatelessWidget {
  const ActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RSizedBox(height: 70),
        const RegisterProgress(),
        const RSizedBox(height: 8),
        RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              AppText.activityTitle.tr(),
              style: theme.textTheme.headlineMedium,
            ),
          ),
        ),
        const RSizedBox(height: 8),
        const BlurredContainer(
          child: Column(
            children: [
              ActivityChoices(),
              RSizedBox(height: 24),
              ActivityDoneButton(),
            ],
          ),
        ).animate().fadeIn().scale().move(delay: 200.ms, duration: 600.ms),
      ],
    );
  }
}
