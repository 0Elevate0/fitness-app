import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_cubit.dart';
import 'package:flutter/material.dart';

import 'package:fitness_app/utils/loaders/loaders.dart';

import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';
import 'package:fitness_app/presentation/auth/verification/views/widgets/pin_code_widget.dart';
import 'package:fitness_app/presentation/auth/verification/views/widgets/resend_code_row.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_intent.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BuildBlurredContainer extends StatelessWidget {
  const BuildBlurredContainer({
    super.key,
    required this.email,
    required this.isError});

  final String email;
  final bool isError;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VerificationCubit>(context);

    return BlurredContainer(
      child: RPadding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: BlocBuilder<VerificationCubit, VerificationState>(
          builder: ( context, state) {
            return  Form(
              key: cubit.formKey,
              autovalidateMode: cubit.state.autoValidateMode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  PinCodeWidget(
                    isError: isError,
                    verificationController: cubit.verificationController,
                    //  These lines are commented out just to test the functionality — we’ll enable it later if needed
                    // onCompleted: (value) {
                    //   cubit.doIntent(OnConfirmClickIntent(
                    //       request: VerificationRequestEntity(
                    //         resetCode: cubit.verificationController.text
                    //
                    //       )
                    //   )
                    //   );
                    // },
                    onSubmitted: (value) {
                      if(value.isEmpty || value.length < 6){
                        Loaders.showErrorMessage(
                          message: AppText.enterAValid6DigitCode.tr(),
                          context: context,
                        );
                        return;

                      }
                      cubit.doIntent(
                          OnConfirmClickIntent(
                              request:VerificationRequestEntity(
                                  resetCode: value
                              ) ));
                    },

                  ),
                  const RSizedBox(height: 10),

                  CustomElevatedButton(
                    onPressed: () {
                      final code = cubit.verificationController.text.trim();
                      if (code.isEmpty || code.length < 6) {
                        Loaders.showErrorMessage(
                          message: AppText.enterAValid6DigitCode.tr(),
                          context: context,
                        );
                        return;
                      }
                      cubit.doIntent(
                        OnConfirmClickIntent(
                          request: VerificationRequestEntity(resetCode: code),
                        ),
                      );
                    },

                    buttonTitle: AppText.confirm.tr(),
                  ),
                  Text(AppText.didntReceiveVerificationCode.tr()),
                  Visibility(
                    visible: state.secondsRemaining > 0,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Text(
                      '${state.secondsRemaining}s',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.red),
                    ),
                  ),
                  ResendCodeRow(
                    isDisabled: state.secondsRemaining > 0,
                    onResend: () {
                      BlocProvider.of<VerificationCubit>(context).doIntent(
                        OnResendCodeClickIntent(
                          request: ForgetPasswordRequestEntity(
                            email: email,
                          ),
                        ),
                      );
                    },
                  ),

                ],
              ),
            );
          },

        ),
      ),
    );
  }
}
