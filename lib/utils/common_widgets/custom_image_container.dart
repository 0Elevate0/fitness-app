import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageContainer extends StatelessWidget {
  final Widget widget;
  final String title;
  final double? width;
  final double? height;

  const CustomImageContainer({
    super.key,
    required this.title,
    required this.widget,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        widget,
        Container(
          height: height,
          width: height,
          decoration: BoxDecoration(
            color: AppColors.black.withAlpha(125),
            borderRadius: BorderRadius.circular(20.r),
          ),
          alignment: Alignment.bottomCenter,
          child: RPadding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}