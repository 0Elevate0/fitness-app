import 'package:fitness_app/domain/entities/user_data_entity/user_data_entity.dart';

abstract final class FitnessMethodHelper {
  static UserDataEntity? userData;
  static String? currentUserToken;
}
