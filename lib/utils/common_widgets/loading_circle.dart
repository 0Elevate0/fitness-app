import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key, this.width, this.height, this.circleColor});
  final double? width, height;
  final Color? circleColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: width ?? 24.r,
        height: height ?? 24.r,
        child: CircularProgressIndicator(
          color: circleColor ?? theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
