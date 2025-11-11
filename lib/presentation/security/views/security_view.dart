import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/security/views/widgets/security_view_body.dart';
import 'package:fitness_app/presentation/security/views_model/security_cubit.dart';
import 'package:fitness_app/presentation/security/views_model/security_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityView extends StatelessWidget {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SecurityCubit>(
      create: (context) =>
          getIt.get<SecurityCubit>()
            ..doIntent(intent: const FetchSecurityDataIntent()),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.profileBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: SecurityViewBody(),
        ),
      ),
    );
  }
}
