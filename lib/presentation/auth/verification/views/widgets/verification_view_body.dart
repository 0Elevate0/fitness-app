import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/verification/views/widgets/build_verification_form.dart';
 import 'package:fitness_app/presentation/auth/verification/views_model/verification_cubit.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_state.dart';
import 'package:fitness_app/utils/common_widgets/loading_dialog.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationViewBody extends StatelessWidget {
  final String email;

  const VerificationViewBody({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<VerificationCubit, VerificationState>(
          listenWhen: (prev, curr) =>
              prev.verifyCodeStatus != curr.verifyCodeStatus,
          listener: (context, state) {
            switch (state.verifyCodeStatus.status) {
              case Status.initial:
                break;
              case Status.loading:
                showLoadingDialog(context, color: theme.colorScheme.primary);
                break;
              case Status.success:
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                  context,
                  RouteNames.resetPassword,
                  arguments: email ,
                );
                log("lplplplplp${email}");
                Loaders.showSuccessMessage(
                  message: AppText.verificationSuccess.tr(),
                  context: context,
                );
                break;
              case Status.failure:
                Navigator.pop(context);
                Loaders.showErrorMessage(
                  message:
                      state.verifyCodeStatus.error?.message ?? AppText.error,
                  context: context,
                );
                break;
            }
          },
        ),
        BlocListener<VerificationCubit, VerificationState>(
          listenWhen: (prev, curr) =>
              prev.resendCodeStatus != curr.resendCodeStatus,

          listener: (context, state) {
            switch (state.resendCodeStatus.status) {
              case Status.initial:
                break;
              case Status.loading:
                showLoadingDialog(context, color: theme.colorScheme.primary);
              case Status.success:
                Navigator.pop(context);
                Loaders.showSuccessMessage(
                  message: AppText.otpResentedSuccessfully.tr(),
                  context: context,
                );
                break;
              case Status.failure:
                Loaders.showErrorMessage(
                    message:state.resendCodeStatus.error?.message?? AppText.error,
                    context:
                context);
                break;
            }
          },
        ),
      ],
      child: BlocBuilder<VerificationCubit, VerificationState>(
        builder: ( context,state) {
          return  BuildVerificationForm(email: email, isError: state.isError,);
        },
      ),
    );
  }
}
