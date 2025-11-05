import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileSelectionItem extends StatelessWidget {
  const ProfileSelectionItem({
    super.key,
    required this.prefixIcon,
    this.isSuffixIcon = true,
    this.isLastItem = false,
    this.isTextTitle = true,
    this.suffixWidget,
    this.titleWidget,
    this.title,
    this.titleColor,
    this.onTap,
  });
  final String prefixIcon;
  final String? title;
  final Color? titleColor;
  final bool isLastItem;
  final bool isSuffixIcon;
  final bool isTextTitle;
  final Widget? suffixWidget;
  final Widget? titleWidget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(prefixIcon, fit: BoxFit.contain),
                    const RSizedBox(width: 16),
                    Expanded(
                      child: isTextTitle
                          ? FittedBox(
                              alignment: AlignmentDirectional.centerStart,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                title?.tr() ?? "",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color:
                                      titleColor ??
                                      theme.colorScheme.onSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : titleWidget ?? const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              const RSizedBox(width: 16),
              isSuffixIcon
                  ? Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 16.sp,
                      color: theme.colorScheme.primary,
                    )
                  : suffixWidget ?? const SizedBox.shrink(),
            ],
          ),
          const RSizedBox(height: 8),
          Visibility(
            visible: isLastItem,
            child: Container(
              height: 1.r,
              width: ScreenUtil().screenWidth,
              color: theme.colorScheme.outlineVariant,
            ),
          ),
        ],
      ),
    );
  }
}
