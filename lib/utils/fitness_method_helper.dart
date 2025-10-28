import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/category/category_entity.dart';
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
}
