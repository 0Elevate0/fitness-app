import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/forget_password/views/widgets/forget_password_body_view.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_cubit.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt.get<ForgetPasswordCubit>()
            ..doIntent(const InitForgetPasswordFormIntent()),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.forgetPassword),
            fit: BoxFit.cover,
          ),
        ),
        child: const Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: ForgetPasswordBodyView(),
        ),
      ),
    );
  }
}
