import 'package:fitness_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.isTitleNotString = false,
    this.titleWidget,
    this.actionWidget,
    this.titleAlignment,
  });
  final String? title;
  final TextStyle? titleStyle;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final bool isTitleNotString;
  final Widget? titleWidget;
  final Widget? actionWidget;
  final AlignmentGeometry? titleAlignment;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: backgroundColor ?? Colors.transparent,
      child: RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Visibility(
              visible: automaticallyImplyLeading,
              child: const CustomBackArrow(),
            ),
            Visibility(
              visible: isTitleNotString,
              child: Expanded(child: titleWidget ?? const SizedBox.shrink()),
            ),
            Visibility(
              visible: !isTitleNotString,
              child: Expanded(
                child: FittedBox(
                  alignment: titleAlignment ?? AlignmentDirectional.center,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title ?? "",
                    style:
                        titleStyle ??
                        theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: actionWidget != null,
              child: actionWidget ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
