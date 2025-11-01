import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialogContent extends StatelessWidget {
  const CustomDialogContent({
    super.key,
    this.actions,
    this.content,
    this.borderRadius,
    this.backgroundColor,
    this.insetPadding,
    this.contentPadding,
  });
  final List<Widget>? actions;
  final Widget? content;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final EdgeInsets? insetPadding;
  final EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: contentPadding ?? EdgeInsets.zero,
      insetPadding: insetPadding ?? EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadiusGeometry.circular(20.r),
      ),
      backgroundColor: backgroundColor ?? Colors.transparent,
      content: content,
      actions: actions,
    );
  }
}
