import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';

class SmartCoachIntroAppBar extends StatelessWidget {
  const SmartCoachIntroAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomAppBar(
      isTitleNotString: true,
      automaticallyImplyLeading: false,
      titleWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${AppText.hi.tr()} ${FitnessMethodHelper.userData?.firstName} ${FitnessMethodHelper.userData?.lastName},",
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSecondary,
            ),
          ),
          Text(
            AppText.iAmYourSmartCoach.tr(),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
