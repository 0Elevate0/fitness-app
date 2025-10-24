import 'package:fitness_app/core/constants/app_animations.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/activity/activity_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/gender/gender_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/goal/goal_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/height/height_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/old/old_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/register_account_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_app_bar.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/weight/weight_section.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/loaders/full_screen_loader.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current.registerStatus.isSuccess ||
          current.registerStatus.isLoading ||
          current.registerStatus.isFailure,
      listener: (context, state) {
        if (state.registerStatus.isLoading) {
          FullScreenLoader.openLoadingDialog(
            text: AppText.signingYouUpMessage,
            animation: AppAnimations.loadingMobile,
            context: context,
          );
        } else if (state.registerStatus.isFailure) {
          FullScreenLoader.stopLoading(context: context);
          Loaders.showErrorMessage(
            message: state.registerStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.registerStatus.isSuccess) {
          FullScreenLoader.stopLoading(context: context);
          // Navigator.of(
          //   context,
          // ).pushNamedAndRemoveUntil(RouteNames.login, (route) => false);
          Navigator.of(context).pushReplacementNamed(RouteNames.onboarding);
          Loaders.showSuccessMessage(
            message: AppText.registeredSuccessfully,
            context: context,
          );
        }
      },
      child: BlurredLayerView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const RegisterAppBar(),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    switch (state.currentRegistrationProcess) {
                      case RegistrationProcess.form:
                        return const RegisterAccountSection();
                      case RegistrationProcess.gender:
                        return const GenderSection();
                      case RegistrationProcess.old:
                        return const OldSection();
                      case RegistrationProcess.weight:
                        return const WeightSection();
                      case RegistrationProcess.height:
                        return const HeightSection();
                      case RegistrationProcess.goal:
                        return const GoalSection();
                      case RegistrationProcess.physical:
                        return const ActivitySection();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
