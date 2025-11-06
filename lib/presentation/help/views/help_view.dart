import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/help/views/widgets/help_view_body.dart';
import 'package:fitness_app/presentation/help/views_model/help_cubit.dart';
import 'package:fitness_app/presentation/help/views_model/help_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HelpCubit>(
      create: (context) =>
          getIt.get<HelpCubit>()..doIntent(intent: const FetchHelpDataIntent()),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.profileBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: HelpViewBody(),
        ),
      ),
    );
  }
}
