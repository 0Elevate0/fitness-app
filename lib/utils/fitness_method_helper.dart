import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';

abstract final class FitnessMethodHelper {
  static UserDataEntity? userData;
  static String? currentUserToken;

  static final List<String> goals = const [
    AppText.gainWeight,
    AppText.loseWeight,
    AppText.getFitter,
    AppText.gainMoreFlexible,
    AppText.learnTheBasic,
  ];
  static final List<String> activityLevels = const [
    AppText.rookie,
    AppText.beginner,
    AppText.intermediate,
    AppText.advance,
    AppText.trueBeast,
  ];

  static String getCurrentActivityLevel({required String activityLevelTitle}) {
    final currentActivityIndex = activityLevels.indexWhere(
      (activity) => activityLevelTitle == activity,
    );
    if (currentActivityIndex == -1) {
      return ActivityLevels.level1.name;
    }
    return ActivityLevels.values.elementAt(currentActivityIndex).name;
  }
}
