import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/app_theme.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/core/router/app_routes.dart';
import 'package:fitness_app/presentation/onboarding/views/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) => MaterialApp(
          title: 'Fitness',
          home: OnboardingView(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          //onGenerateRoute: AppRoutes.onGenerateRoute,
         // initialRoute: state.redirectedScreen,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        ),
      ),
    );
  }
}
