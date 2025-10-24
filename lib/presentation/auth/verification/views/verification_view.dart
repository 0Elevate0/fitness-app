import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/verification/views/widgets/verification_view_body.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_cubit.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationView extends StatelessWidget {
  final String email;

  const VerificationView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<VerificationCubit>()
        ..doIntent(OnStartTimer())
        ..doIntent(InitVerificationIntent()),
      child: Scaffold(body: VerificationViewBody(email: email),
      ),
    );
  }
}
