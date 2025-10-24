import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/reset_password/views/widgets/reset_password_body_view.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider
      (create: (_) => getIt.get<ResetPasswordCubit>()
      ..doIntent(InitResetPasswordFormIntent()),
    child: Scaffold(body: ResetPasswordBodyView(email: email,),
      resizeToAvoidBottomInset: true,
    ),
    );
  }
}
