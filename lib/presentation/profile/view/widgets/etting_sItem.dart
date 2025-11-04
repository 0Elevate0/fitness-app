import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildSettingsItem({
  required String icon,
  required String text,
  required ThemeData theme,
  Color? iconColor,
  Color? textColor,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: SvgPicture.asset(
      icon,
      width: 22,
      height: 22,
    ),
    title: Text(
      text,
      style: TextStyle(
        color: textColor ?? theme.colorScheme.primary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    trailing: Icon(
      Icons.arrow_forward_ios,
      color: theme.colorScheme.primary,
      size: 16,
    ),
    onTap: onTap,
  );
}