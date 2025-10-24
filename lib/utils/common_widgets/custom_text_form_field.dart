import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.maxLines = 1,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.obscuringCharacter = "*",
    this.validator,
    this.textInputAction,
    this.hintStyle,
    this.contentPadding,
    this.style,
    this.onTap,
    this.enabled,
    this.suffixIconConstraints,
    this.maxLength,
    this.prefixIcon,
    this.prefixIconConstraints,
    required this.label,
    this.labelStyle,
    this.borderRadius = 20,
    this.disabledBorderColor,
    this.isReadOnly = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
  });
  final String? hintText;
  final String label;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final String obscuringCharacter;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final void Function()? onTap;
  final bool? enabled;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final int? maxLength;
  final double borderRadius;
  final Color? disabledBorderColor;
  final bool? isReadOnly;
  final FloatingLabelBehavior floatingLabelBehavior;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      onTap: onTap,
      style:
          style ??
          theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSecondary,
            decorationColor: theme.colorScheme.onPrimary,
          ),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      textInputAction: textInputAction,
      readOnly: isReadOnly ?? false,
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
        contentPadding:
            contentPadding ??
            REdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
        filled: false,
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label.tr(),
            style:
                labelStyle ??
                theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
          ),
        ),
        hintStyle: hintStyle ?? theme.textTheme.bodySmall,
        hintText: hintText?.tr(),

        focusedBorder: buildOutlinedBorder(
          borderColor: theme.colorScheme.onPrimary,
          borderRadius: borderRadius,
        ),
        enabledBorder: buildOutlinedBorder(
          borderColor: theme.colorScheme.outline,
          borderRadius: borderRadius,
        ),
        focusedErrorBorder: buildOutlinedBorder(
          borderColor: theme.colorScheme.onPrimary,
          borderRadius: borderRadius,
        ),
        errorBorder: buildOutlinedBorder(
          borderColor: theme.colorScheme.error,
          borderRadius: borderRadius,
        ),
        disabledBorder: buildOutlinedBorder(
          borderColor: disabledBorderColor ?? theme.colorScheme.onSecondary,
          borderRadius: borderRadius,
        ),
        prefixIcon: Padding(
          padding: REdgeInsetsDirectional.only(start: 16, end: 4),
          child: prefixIcon,
        ),
        prefixIconConstraints:
            prefixIconConstraints ??
            BoxConstraints(maxWidth: 60.r, maxHeight: 60.r),
        suffixIconConstraints:
            suffixIconConstraints ??
            BoxConstraints(maxWidth: 60.r, maxHeight: 60.r),
        suffixIcon: Padding(
          padding: REdgeInsetsDirectional.only(end: 16, start: 4),
          child: suffixIcon,
        ),
        errorStyle: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.error,
        ),
        errorMaxLines: 3,
      ),
      maxLength: maxLength,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      validator: validator,
      enabled: enabled,
    );
  }

  static OutlineInputBorder buildOutlinedBorder({
    required Color borderColor,
    required double borderRadius,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
