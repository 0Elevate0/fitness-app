import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/recommendation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.recommendationToDay.tr(),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSecondary,
          ),
        ),
        const RSizedBox(height: 8),
        const RecommendationList(),
      ],
    );
  }
}
