import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordSection extends StatelessWidget {
  const CreateNewPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppText.makeSureIts8CharactersOrMore.tr(),
            style: theme.textTheme.headlineSmall,
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppText.createNewPassword.tr(),
            style: theme.textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}
