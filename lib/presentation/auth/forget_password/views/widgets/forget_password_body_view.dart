import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/forget_password/views/widgets/build_container.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_cubit.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/loading_dialog.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordBodyView extends StatelessWidget {
  const ForgetPasswordBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<ForgetPasswordCubit>(context);

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        switch (state.forgetPasswordState.status) {
          case Status.initial:
            break;
          case Status.loading:
            showLoadingDialog(
              context,
              color: Theme.of(context).colorScheme.primary,
            );
            break;
          case Status.success:
            {
              Navigator.pop(context);

              Navigator.pushReplacementNamed(
                context,
                RouteNames.verification,
                arguments: cubit.emailController.text,
              );
              Loaders.showSuccessMessage(
                message: AppText.otpSent.tr(),
                context: context,
              );
            }
            break;
          case Status.failure:
            Navigator.pop(context);
            Loaders.showErrorMessage(
              message:
                  state.forgetPasswordState.error?.message ??
                  AppText.error.tr(),
              context: context,
            );
            break;
        }
      },
      bloc: cubit,
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (BuildContext context, state) {
          return Stack(
            children: [
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
                            AppText.enterYourEmail.tr(),
                            style: theme.textTheme.headlineSmall,
                          ),
                          Text(
                            AppText.forgetPassword.tr(),
                            style: theme.textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),

                    const RSizedBox(height: 25),
                    const SingleChildScrollView(child: BuildContainer()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
