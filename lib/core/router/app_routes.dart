import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/home/views/home_view.dart';
import 'package:fitness_app/presentation/onboarding/views/onboarding_view.dart';
import 'package:flutter/material.dart';

abstract final class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case RouteNames.homepage:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return null;
    }
  }
}
