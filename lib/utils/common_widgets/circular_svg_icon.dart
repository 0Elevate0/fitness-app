import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularSvgIcon extends StatelessWidget {
  const CircularSvgIcon({super.key, required this.iconPath});

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 32.r,
      height: 32.r,
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.secondary,
      ),
      child: SvgPicture.asset(iconPath, fit: BoxFit.contain),
    );
  }
}
