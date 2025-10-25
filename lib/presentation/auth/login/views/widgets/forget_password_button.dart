import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:flutter/material.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteNames.forgetPassword);
        },
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppText.forgetPassword.tr(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              decoration: TextDecoration.underline,
              decorationColor: theme.colorScheme.primary,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}
