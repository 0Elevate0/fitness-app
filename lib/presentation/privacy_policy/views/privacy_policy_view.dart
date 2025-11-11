import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/privacy_policy/views/widgets/privacy_policy_view_body.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_cubit.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrivacyPolicyCubit>(
      create: (context) =>
          getIt.get<PrivacyPolicyCubit>()
            ..doIntent(intent: const FetchPrivacyPolicyDataIntent()),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.profileBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: PrivacyPolicyViewBody(),
        ),
      ),
    );
  }
}
