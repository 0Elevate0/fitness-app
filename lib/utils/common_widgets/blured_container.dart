import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlurredContainer extends StatelessWidget {
  const BlurredContainer({
    super.key,
    this.blurColor,
    this.halfTheBlurValue,
    required this.child,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  final Color? blurColor;
  final double? halfTheBlurValue;
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = borderRadius ?? BorderRadius.circular(50.r);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: halfTheBlurValue ?? 17.3.r,
          sigmaY: halfTheBlurValue ?? 17.3.r,
        ),
        child: Container(
          padding:
          padding ?? REdgeInsets.symmetric(horizontal: 16, vertical: 24),
          margin: margin,
          decoration: BoxDecoration(
            color:
            blurColor ?? theme.colorScheme.secondary.withValues(alpha: 0.1),
            borderRadius: radius,
          ),
          child: child,
        ),
      ),
    );
  }
}