import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildSettingsItemWithSwitch({
  required String icon,
  required String text,
  required bool value,
  required Function(bool) onChanged,
  required ThemeData theme,
}) {
  return ListTile(
    leading: SvgPicture.asset(
      icon,
      width: 22,
      height: 22,
      colorFilter: ColorFilter.mode(
        theme.colorScheme.primary,
        BlendMode.srcIn,
      ),
    ),
    title: Text(
      text,
      style: TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    trailing: Switch(
      value: value,
      onChanged: onChanged,
      activeColor: theme.colorScheme.primary,
    ),
  );
}