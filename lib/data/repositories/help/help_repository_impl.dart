import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/help/local_data_source/help_local_data_source.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';
import 'package:fitness_app/domain/repositories/help/help_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HelpRepository)
final class HelpRepositoryImpl implements HelpRepository {
  final HelpLocalDataSource _helpLocalDataSource;
  const HelpRepositoryImpl(this._helpLocalDataSource);

  @override
  Future<Result<HelpEntity>> fetchHelpData() async {
    return await _helpLocalDataSource.fetchHelpData();
  }
}
