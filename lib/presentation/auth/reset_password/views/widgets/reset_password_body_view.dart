import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/reset_password/views/widgets/build_reset_password_form.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:fitness_app/utils/common_widgets/loading_dialog.dart';

import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordBodyView extends StatelessWidget {
  final String email;

  const ResetPasswordBodyView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (BuildContext context, state) {
        switch (state.resetPasswordState.status) {
          case Status.initial:
            break;
          case Status.loading:
            showLoadingDialog(context, color: theme.colorScheme.primary);
            break;
          case Status.success:
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, RouteNames.login);
            Loaders.showSuccessMessage(
              message: AppText.passwordChangedSuccessfully.tr(),
              context: context,
            );
            break;
          case Status.failure:
            Navigator.pop(context);
            Loaders.showErrorMessage(
              message: state.resetPasswordState.error?.message ?? AppText.error,
              context: context,
            );
            break;
        }
      },
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (BuildContext context, ResetPasswordState state) {
          return BuildResetPasswordForm(email: email);
        },
      ),
    );
  }
}
