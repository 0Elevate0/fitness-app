import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/splash/remote_data_source/splash_remote_data_source.dart';
import 'package:fitness_app/domain/repositories/splash/splash_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SplashRepository)
final class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource _splashRemoteDataSource;
  const SplashRepositoryImpl(this._splashRemoteDataSource);

  @override
  Future<Result<void>> getUserData() async {
    return await _splashRemoteDataSource.getUserData();
  }
}
