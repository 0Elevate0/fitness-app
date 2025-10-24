import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class WelcomeBackWidget extends StatelessWidget {
  const WelcomeBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppText.heyThere.tr(),
            style: theme.textTheme.headlineSmall,
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppText.welcomeBack.tr(),
            style: theme.textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}
