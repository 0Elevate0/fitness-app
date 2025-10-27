import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/category_item.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.category.tr(),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSecondary,
          ),
        ),
        const RSizedBox(height: 8),
        BlurredContainer(
          margin: EdgeInsets.zero,
          padding: REdgeInsets.symmetric(vertical: 8),
          borderRadius: BorderRadius.circular(20.r),
          halfTheBlurValue: 10,
          blurColor: theme.colorScheme.secondary.withValues(alpha: 0.8),
          child: Row(
            children: FitnessMethodHelper.categories
                .map(
                  (category) =>
                      Expanded(child: CategoryItem(categoryData: category)),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
