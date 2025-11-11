import 'package:fitness_app/utils/dialogs/custom_dialog_content.dart';
import 'package:flutter/material.dart';

abstract final class Dialogs {
  static Future customDialog({
    required BuildContext context,
    List<Widget>? actions,
    Widget? content,
    bool isBarrierDismissible = true,
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
    EdgeInsets? insetPadding,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return showDialog(
      barrierDismissible: isBarrierDismissible,
      useSafeArea: true,
      context: context,
      builder: (context) => CustomDialogContent(
        content: content,
        actions: actions,
        insetPadding: insetPadding,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        contentPadding: contentPadding,
      ),
    );
  }
}
