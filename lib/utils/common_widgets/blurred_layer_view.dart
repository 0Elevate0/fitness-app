import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlurredLayerView extends StatelessWidget {
  const BlurredLayerView({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6.25.r, sigmaY: 6.25.r),
            child: Container(
              color: theme.colorScheme.secondary.withValues(alpha: 0),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
