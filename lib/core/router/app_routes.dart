import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/auth/register/views/register_view.dart';
import 'package:fitness_app/presentation/auth/login/views/login_view.dart';
import 'package:fitness_app/presentation/onboarding/views/onboarding_view.dart';
import 'package:flutter/material.dart';

abstract final class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      default:
        return null;
    }
  }
}
