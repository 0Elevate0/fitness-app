import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/profile_reset_password_body.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileResetPassword extends StatelessWidget {
  const ProfileResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileResetPasswordCubit>(
      create: (context) =>
          getIt.get<ProfileResetPasswordCubit>()
            ..doIntent(InitializeProfileResetPasswordFormIntent()),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.authBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: ProfileResetPasswordBody(),
        ),
      ),
    );
  }
}
