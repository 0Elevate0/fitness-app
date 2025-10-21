import 'package:fitness_app/presentation/auth/register/views/widgets/gender/gender_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/register_account_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_app_bar.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlurredLayerView(
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
                      return const SizedBox();
                    case RegistrationProcess.weight:
                      return const SizedBox();
                    case RegistrationProcess.height:
                      return const SizedBox();
                    case RegistrationProcess.goal:
                      return const SizedBox();
                    case RegistrationProcess.physical:
                      return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
