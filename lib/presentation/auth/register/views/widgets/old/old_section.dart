import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/next_button.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/old/years_old_choice.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_progress.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OldSection extends StatelessWidget {
  const OldSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RSizedBox(height: 132.5),
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
                  AppText.oldTitle.tr(),
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
            children: [YearsOldChoice(), RSizedBox(height: 24), NextButton()],
          ),
        ),
      ],
    );
  }
}
