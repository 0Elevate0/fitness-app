import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow({super.key, this.onBackArrowClicked});
  final void Function()? onBackArrowClicked;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        onBackArrowClicked != null
            ? onBackArrowClicked!()
            : Navigator.of(context).pop();
      },
      child: Container(
        padding: REdgeInsets.all(7),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.primary,
        ),
        child: SvgPicture.asset(AppIcons.back, fit: BoxFit.contain),
      ),
    );
  }
}
