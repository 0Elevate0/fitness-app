abstract final class Endpoints {
  static const String baseUrl = 'https://fitness.elevateegy.com';
  static const String forgotPassword = "/api/v1/auth/forgotPassword";
  static const String verifyResetCode = "/api/v1/auth/verifyResetCode";
  static const String resetPassword = "/api/v1/auth/resetPassword";
  static const String signup = '/api/v1/auth/signup';
  static const String login = '/api/v1/auth/signin';
  static const String getLoggedUserData = '/api/v1/auth/profile-data';
}
