import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalActivityField extends StatelessWidget {
  const GoalActivityField({
    super.key,
    this.borderRadius,
    this.halfTheBlurValue,
    this.backgroundColor,
    required this.title,
    this.isSelected = false,
    this.onSelected,
    this.haveCircularSelection = true,
  });
  final String title;
  final BorderRadiusGeometry? borderRadius;
  final double? halfTheBlurValue;
  final Color? backgroundColor;
  final bool isSelected;
  final bool haveCircularSelection;
  final void Function()? onSelected;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = borderRadius ?? BorderRadius.circular(20.r);
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: halfTheBlurValue ?? 2.r,
          sigmaY: halfTheBlurValue ?? 2.r,
        ),
        child: InkWell(
          onTap: onSelected,
          splashColor: theme.colorScheme.primary.withValues(alpha: 0.7),
          highlightColor: theme.colorScheme.primary.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
            decoration: BoxDecoration(
              color:
                  backgroundColor ??
                  theme.colorScheme.shadow.withValues(alpha: 0.2),
              border: Border.all(color: theme.colorScheme.outline, width: 1.r),
              borderRadius: radius,
            ),
            child: Row(
              children: [
                Expanded(
                  child: FittedBox(
                    alignment: AlignmentDirectional.centerStart,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: haveCircularSelection,
                  child: Row(
                    children: [
                      const RSizedBox(width: 8),
                      Container(
                        padding: REdgeInsets.all(4.17),
                        margin: REdgeInsets.all(1.67),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.shadow,
                            width: 2.r,
                          ),
                        ),
                        child: Container(
                          width: 8.33.r,
                          height: 8.33.r,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
