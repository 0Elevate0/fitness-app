import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';
import 'package:fitness_app/domain/repositories/help/help_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class HelpUseCase {
  final HelpRepository _helpRepository;
  const HelpUseCase(this._helpRepository);

  Future<Result<HelpEntity>> invoke() async {
    return await _helpRepository.fetchHelpData();
  }
}
