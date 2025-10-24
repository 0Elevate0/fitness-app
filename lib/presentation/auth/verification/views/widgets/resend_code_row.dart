import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_text.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResendCodeRow extends StatelessWidget {
  const ResendCodeRow({
    super.key,
    required this.onResend,
    required this.isDisabled,
  });

  final VoidCallback? onResend;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        const RSizedBox(width: 4),
        InkWell(
          onTap: isDisabled ? null : onResend,
          child: Text(AppText.resenCode.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
              color: isDisabled
                  ? AppColors.gray
                  :theme.colorScheme.primary,
              decoration: TextDecoration.underline,
              decorationColor: isDisabled
                  ? AppColors.gray
                  :theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}