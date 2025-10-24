import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeWidget extends StatelessWidget {
  final TextEditingController verificationController;
  final ValueChanged onSubmitted;
  final bool isError;

  const PinCodeWidget({
    super.key,
    required this.verificationController,
    required this.onSubmitted,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        PinCodeTextField(
          controller: verificationController,
          keyboardType: TextInputType.number,
          animationType: AnimationType.fade,
          cursorColor: theme.colorScheme.primary,
          textStyle: TextStyle(color: theme.colorScheme.primary),
          length: 6,
          appContext: context,
          pinTheme: PinTheme(
            fieldHeight: 30.h,
            fieldWidth: 30.w,
            inactiveColor: isError ? Colors.red[900] : theme.colorScheme.onSecondary,
            selectedColor: isError ? Colors.red[900] : theme.colorScheme.primary,
            activeColor: isError ? Colors.red[900] : theme.colorScheme.primary,
          ),
          onSubmitted: (value) => onSubmitted(value),
        ),
        if (isError)
          Row(
            children: [
              const Spacer(),
              Icon(Icons.error, color: Colors.red[900], size: 18.sp),
              const RSizedBox(width: 4),
              Text(
                AppText.invalidCode.tr(),
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.red[900]),
              ),
            ],
          ),
      ],
    );
  }
}
