import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HaveAccountRow extends StatelessWidget {
  const HaveAccountRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              AppText.haveAccountMessage.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Flexible(
          child: InkWell(
            splashColor: theme.colorScheme.primary,
            onTap: () {},
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                " ${AppText.login.tr()}",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: theme.colorScheme.primary,
                  decorationThickness: 1.r,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
