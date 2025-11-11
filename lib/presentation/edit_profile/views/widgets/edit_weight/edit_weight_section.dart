import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_done_button.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_weight/edit_weight_choice.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditWeightSection extends StatelessWidget {
  const EditWeightSection({super.key});

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
        const RSizedBox(height: 148.5),
        RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppText.weightTitle.tr(),
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppText.completeRegistrationMessage.tr(),
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ],
          ),
        ),
        const RSizedBox(height: 8),
        const BlurredContainer(
          child: Column(
            children: [
              EditWeightChoice(),
              RSizedBox(height: 24),
              EditDoneButton(),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(delay: 200.ms),
      ],
    );
  }
}
