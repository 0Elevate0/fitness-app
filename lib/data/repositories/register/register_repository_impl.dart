import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/register/remote_data_source/register_remote_data_source.dart';
import 'package:fitness_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:fitness_app/domain/repositories/register/register_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepository)
final class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource _registerRemoteDataSource;
  const RegisterRepositoryImpl(this._registerRemoteDataSource);

  @override
  Future<Result<void>> register({
    required RegisterRequestEntity request,
  }) async {
    return await _registerRemoteDataSource.register(request: request);
  }
}
