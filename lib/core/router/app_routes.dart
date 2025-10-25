import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/auth/forget_password/views/forget_password_view.dart';
import 'package:fitness_app/presentation/auth/login/views/login_view.dart';
import 'package:fitness_app/presentation/auth/register/views/register_view.dart';
import 'package:fitness_app/presentation/auth/reset_password/views/reset_password_view.dart';
import 'package:fitness_app/presentation/auth/verification/views/verification_view.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views/fitness_bottom_navigation_view.dart';
import 'package:fitness_app/presentation/onboarding/views/onboarding_view.dart';
import 'package:flutter/material.dart';

abstract final class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case RouteNames.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case RouteNames.verification:
        return MaterialPageRoute(
          builder: (_) => VerificationView(email: settings.arguments as String),
        );
      case RouteNames.resetPassword:
        return MaterialPageRoute(
          builder: (_) =>
              ResetPasswordView(email: settings.arguments as String),
        );
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteNames.fitnessBottomNavigation:
        return MaterialPageRoute(
          builder: (_) => const FitnessBottomNavigationView(),
        );
      default:
        return null;
    }
  }
}
