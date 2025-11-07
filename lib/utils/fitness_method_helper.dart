import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:fitness_app/domain/entities/category/category_entity.dart';
import 'package:fitness_app/domain/entities/popular_training/popular_training_entity.dart';
import 'package:fitness_app/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:flutter/material.dart';

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

  static String getCurrentActivityLevelTitle({required String activityLevel}) {
    final currentActivityLevelIndex = ActivityLevels.values.indexWhere(
      (level) => level.name == activityLevel,
    );
    if (currentActivityLevelIndex == -1) {
      return activityLevels[0];
    }
    return activityLevels[currentActivityLevelIndex];
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

  static Color? parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static FontWeight parseFontWeight(String? weight) {
    switch (weight?.toLowerCase()) {
      case 'bold':
        return FontWeight.bold;
      case 'w500':
        return FontWeight.w500;
      case 'w600':
        return FontWeight.w600;
      case 'light':
        return FontWeight.w300;
      default:
        return FontWeight.normal;
    }
  }

  static TextAlign parseTextAlign(
    LocalizedTextAlignEntity? alignMap,
    bool isArabic,
  ) {
    if (alignMap == null) return TextAlign.center;
    final alignment = isArabic ? alignMap.ar : alignMap.en;
    switch (alignment) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'left':
        return TextAlign.left;
      default:
        return isArabic ? TextAlign.right : TextAlign.left;
    }
  }

  static Alignment parseAlignment(
    LocalizedTextAlignEntity? alignMap,
    bool isArabic,
  ) {
    if (alignMap == null) return Alignment.center;
    final alignment = isArabic ? alignMap.ar : alignMap.en;
    switch (alignment) {
      case 'center':
        return Alignment.center;
      case 'right':
        return Alignment.centerRight;
      case 'left':
        return Alignment.centerLeft;
      default:
        return isArabic ? Alignment.centerRight : Alignment.centerLeft;
    }
  }
}
