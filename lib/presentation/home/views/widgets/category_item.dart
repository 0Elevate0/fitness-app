import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/domain/entities/category/category_entity.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryData, this.onTap});
  final CategoryEntity categoryData;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border:
              categoryData.categoryTitle !=
                  FitnessMethodHelper.categories.last.categoryTitle
              ? BorderDirectional(
                  end: BorderSide(color: theme.colorScheme.outlineVariant),
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              categoryData.categoryImage,
              width: 56.r,
              height: 56.r,
              fit: BoxFit.cover,
            ),
            const RSizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                categoryData.categoryTitle.tr(),
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
