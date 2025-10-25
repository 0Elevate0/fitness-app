import 'package:fitness_app/core/constants/app_animations.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/login_form.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/welcome_back_widget.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/loaders/full_screen_loader.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        switch (state.loginStatus.status) {
          case Status.initial:
            break;
          case Status.loading:
            FullScreenLoader.openLoadingDialog(
              text: AppText.loggingInMessage,
              animation: AppAnimations.loadingMobile,
              context: context,
            );
          case Status.success:
            FullScreenLoader.stopLoading(context: context);
            Navigator.of(
              context,
            ).pushReplacementNamed(RouteNames.fitnessBottomNavigation);
          case Status.failure:
            FullScreenLoader.stopLoading(context: context);
            Loaders.showErrorMessage(
              message: state.loginStatus.error?.message ?? "",
              context: context,
            );
        }
      },
      child: BlurredLayerView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RSizedBox(height: 45),
                    CustomAppBar(
                      automaticallyImplyLeading: false,
                      isTitleNotString: true,
                      titleWidget: Image.asset(
                        AppImages.superFitness,
                        height: 70.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const RSizedBox(height: 30),
                    const RPadding(
                      padding: EdgeInsets.all(16),
                      child: WelcomeBackWidget(),
                    ),
                    const LoginForm(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
