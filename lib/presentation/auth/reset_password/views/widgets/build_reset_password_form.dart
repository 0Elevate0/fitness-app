import 'package:fitness_app/presentation/auth/reset_password/views/widgets/build_form_continar.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';

class BuildResetPasswordForm extends StatelessWidget {
  const BuildResetPasswordForm({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AppImages.forgetPassword, fit: BoxFit.cover),
            ),

            BlurredLayerView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          AppText.makeSureIts8CharactersOrMore.tr(),
                          style: theme.textTheme.headlineSmall,
                        ),
                        Text(
                          AppText.createNewPassword.tr(),
                          style: theme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),

                  const RSizedBox(height: 25),
                  BuildFormContainer(email: email),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
