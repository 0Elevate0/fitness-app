import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_activity/edit_activity_choices.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_done_button.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditActivitySection extends StatelessWidget {
  const EditActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RSizedBox(height: 12),
        CustomAppBar(
          automaticallyImplyLeading: false,
          isTitleNotString: true,
          titleWidget: Image.asset(
            AppImages.superFitness,
            height: 70.h,
            fit: BoxFit.contain,
          ),
        ),
        const RSizedBox(height: 88),
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
              EditActivityChoices(),
              RSizedBox(height: 24),
              EditDoneButton(),
            ],
          ),
        ).animate().fadeIn().scale().move(delay: 200.ms, duration: 600.ms),
      ],
    );
  }
}
