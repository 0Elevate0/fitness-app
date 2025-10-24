import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterAppBar extends StatelessWidget {
  const RegisterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) => CustomAppBar(
        automaticallyImplyLeading: state.currentRegistrationProcess.index == 0
            ? false
            : true,
        onBackArrowClicked: () => registerCubit.doIntent(
          intent: const MoveToRegistrationPreviousStepIntent(),
        ),
        isTitleNotString: true,
        titleWidget: Padding(
          padding: state.currentRegistrationProcess.index == 0
              ? EdgeInsets.zero
              : REdgeInsetsDirectional.only(end: 20),
          child: Image.asset(
            AppImages.superFitness,
            height: 70.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
