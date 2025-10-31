import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/category/category_entity.dart';
import 'package:fitness_app/domain/entities/popular_training/popular_training_entity.dart';
import 'package:fitness_app/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';

abstract final class FitnessMethodHelper {
  static UserDataEntity? userData;
  static String? currentUserToken;

  static String getCurrentActivityLevel({required String activityLevelTitle}) {
    final currentActivityIndex = activityLevels.indexWhere(
      (activity) => activityLevelTitle == activity,
    );
    if (currentActivityIndex == -1) {
      return ActivityLevels.level1.name;
    }
    return ActivityLevels.values.elementAt(currentActivityIndex).name;
  }

  static String getCurrentLanguage({required bool isArabicLanguage}) {
    if (isArabicLanguage) {
      return "ar";
    }
    return "en";
  }

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

  static final List<CategoryEntity> categories = const [
    CategoryEntity(
      categoryTitle: AppText.gym,
      categoryImage: AppImages.category1,
    ),
    CategoryEntity(
      categoryTitle: AppText.fitness,
      categoryImage: AppImages.category2,
    ),
    CategoryEntity(
      categoryTitle: AppText.yoga,
      categoryImage: AppImages.category3,
    ),
    CategoryEntity(
      categoryTitle: AppText.aerobics,
      categoryImage: AppImages.category4,
    ),
    CategoryEntity(
      categoryTitle: AppText.trainer,
      categoryImage: AppImages.category5,
    ),
  ];

  static final List<PopularTrainingEntity> popularTraining = const [
    PopularTrainingEntity(
      backgroundImage: AppImages.popular1,
      title: AppText.beginnerChest,
      numberOfTasks: 24,
      level: AppText.beginner,
      levelId: "67c797e226895f87ce0aa94b",
      muscleId: "67c8499726895f87ce0aa9be",
    ),
    PopularTrainingEntity(
      backgroundImage: AppImages.popular2,
      title: AppText.intermediateBack,
      numberOfTasks: 36,
      level: AppText.intermediate,
      levelId: "67c797e226895f87ce0aa94c",
      muscleId: "67c8499726895f87ce0aa9c0",
    ),
    PopularTrainingEntity(
      backgroundImage: AppImages.popular3,
      title: AppText.advancedLeg,
      numberOfTasks: 48,
      level: AppText.advanced,
      levelId: "67c797e226895f87ce0aa94e",
      muscleId: "67c8499726895f87ce0aa9c3",
    ),
  ];
}
