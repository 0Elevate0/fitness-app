import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodIngredientItem extends StatelessWidget {
  const FoodIngredientItem({
    super.key,
    required this.mealIngredient,
    required this.mealMeasure,
    this.isLastItem = false,
  });
  final String mealIngredient;
  final String mealMeasure;
  final bool isLastItem;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: isLastItem
            ? null
            : Border(
                bottom: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: FittedBox(
              alignment: AlignmentDirectional.centerStart,
              fit: BoxFit.scaleDown,
              child: Text(
                mealIngredient,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const RSizedBox(width: 16),
          Expanded(
            child: FittedBox(
              alignment: AlignmentDirectional.centerEnd,
              fit: BoxFit.scaleDown,
              child: Text(
                mealMeasure,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
