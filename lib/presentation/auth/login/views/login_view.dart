import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/login_view_body.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<LoginCubit>()
            ..doIntent(intent: InitializeLoginFormIntent()),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.authBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: LoginViewBody(),
        ),
      ),
    );
  }
}
