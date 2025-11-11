import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/have_account_row.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/or_divider.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/register_button.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/register_form.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/social_row.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterAccountSection extends StatelessWidget {
  const RegisterAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RSizedBox(height: 34),
        RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppText.heyThere.tr(),
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppText.createAnAccount.tr(),
                  style: theme.textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
        const RSizedBox(height: 8),
        BlurredContainer(
          child: RPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppText.register.tr(),
                  style: theme.textTheme.headlineLarge,
                ),
                const RSizedBox(height: 16),
                const RegisterForm(),
                const OrDivider(),
                const SocialRow(),
                const RSizedBox(height: 24),
                const RegisterButton(),
                const RSizedBox(height: 8),
                const HaveAccountRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
