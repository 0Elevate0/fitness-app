import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: REdgeInsets.symmetric(vertical: 24),
      padding: REdgeInsets.symmetric(horizontal: 65),
      child: Row(
        children: [
          Expanded(
            child: Container(height: 1.r, color: theme.colorScheme.shadow),
          ),
          Flexible(
            child: RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
                child: Text(AppText.or.tr(), style: theme.textTheme.bodySmall),
              ),
            ),
          ),
          Expanded(
            child: Container(height: 1.r, color: theme.colorScheme.shadow),
          ),
        ],
      ),
    );
  }
}
