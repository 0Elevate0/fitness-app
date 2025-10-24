import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/gender/gender_selection.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/next_button.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_progress.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSection extends StatelessWidget {
  const GenderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RSizedBox(height: 85.5),
        const RegisterProgress(),
        const RSizedBox(height: 8),
        RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppText.tellUs.tr(),
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppText.genderAsk.tr(),
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ],
          ),
        ),
        const RSizedBox(height: 8),
        const BlurredContainer(
          child: Column(
            children: [GenderSelection(), RSizedBox(height: 24), NextButton()],
          ),
        ).animate().fadeIn().scale().move(delay: 200.ms, duration: 600.ms),
      ],
    );
  }
}
