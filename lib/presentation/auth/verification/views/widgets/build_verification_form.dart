import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/presentation/auth/verification/views/widgets/build_blurred_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildVerificationForm extends StatelessWidget {
  final String email;
  final bool isError;

  const BuildVerificationForm({
    super.key,
    required this.email,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AppImages.forgetPassword, fit: BoxFit.cover),
        ),

        BlurredLayerView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: RPadding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Image.asset(AppImages.fitLogo),
                ),
              ),

              const RSizedBox(height: 85),

              RPadding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppText.otpCode.tr(),
                      style: theme.textTheme.headlineMedium,
                    ),
                    Text(
                      AppText.enterYourOTPCheckYourEmail.tr(),
                      style: theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),

              const RSizedBox(height: 20),
              SingleChildScrollView(child: BuildBlurredContainer(email: email, isError: isError)),
            ],
          ),
        ),
      ],
    );
  }
}
