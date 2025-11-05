import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';

abstract interface class HelpLocalDataSource {
  Future<Result<HelpEntity>> fetchHelpData();
}
