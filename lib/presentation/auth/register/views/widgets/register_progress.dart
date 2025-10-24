import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RegisterProgress extends StatelessWidget {
  const RegisterProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) => Center(
        child: CircularPercentIndicator(
          radius: 20.r,
          lineWidth: 4.r,
          animation: true,
          percent:
              state.currentRegistrationProcess.index /
              (RegistrationProcess.values.length - 1),
          center: RSizedBox(
            width: 20,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "${state.currentRegistrationProcess.index}/${RegistrationProcess.values.length - 1}",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.transparent,
          progressColor: state.currentRegistrationProcess.index == 1
              ? Colors.transparent
              : theme.colorScheme.primary,
        ),
      ),
    );
  }
}
