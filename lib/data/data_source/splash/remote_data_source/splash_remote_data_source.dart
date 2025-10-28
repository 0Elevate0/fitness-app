import 'package:fitness_app/api/client/api_result.dart';

abstract interface class SplashRemoteDataSource {
  Future<Result<void>> getUserData();
}
