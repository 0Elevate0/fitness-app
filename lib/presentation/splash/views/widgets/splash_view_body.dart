import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_cubit.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_intent.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final splashCubit = BlocProvider.of<SplashCubit>(context);
    return BlocListener<SplashCubit, SplashState>(
      listener: (BuildContext context, SplashState state) {
        if (state.userDataStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.userDataStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.userDataStatus.isSuccess) {
          Navigator.of(
            context,
          ).pushReplacementNamed(RouteNames.fitnessBottomNavigation);
        } else if (state.isNavigationToLogin) {
          Navigator.of(context).pushReplacementNamed(RouteNames.login);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.superFitness,
              height: 180.r,
              width: 180.r,
            ),
          ),
          const RSizedBox(height: 52),
          BlocBuilder<SplashCubit, SplashState>(
            buildWhen: (previous, current) =>
                current.userDataStatus.isLoading ||
                current.userDataStatus.isFailure,
            builder: (context, state) {
              if (state.userDataStatus.isFailure) {
                return RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      CustomElevatedButton(
                        onPressed: () async {
                          await splashCubit.doIntent(
                            intent: const GetUserDataIntent(),
                          );
                        },
                        buttonTitle: AppText.tryAgain,
                      ),
                      const RSizedBox(height: 16),
                      CustomElevatedButton(
                        onPressed: () {
                          splashCubit.doIntent(
                            intent: const NavigateToLoginViewIntent(),
                          );
                        },
                        buttonTitle: AppText.reLogin,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: RSizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
