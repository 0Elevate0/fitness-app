import 'package:fitness_app/api/models/meal_category/meal_category_model.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("MealCategoryModel → MealCategoryEntity", () {
    test(
      "when call toMealCategoryEntity with null values it should return MealCategoryEntity with null values",
      () {
        // Arrange
        final MealCategoryModel mealCategoryModel = MealCategoryModel(
          idCategory: null,
          strCategory: null,
          strCategoryThumb: null,
          strCategoryDescription: null,
        );

        // Act
        final MealCategoryEntity actualResult = mealCategoryModel
            .toMealCategoryEntity();

        // Assert
        expect(actualResult.idCategory, equals(mealCategoryModel.idCategory));
        expect(actualResult.strCategory, equals(mealCategoryModel.strCategory));
        expect(
          actualResult.strCategoryThumb,
          equals(mealCategoryModel.strCategoryThumb),
        );
        expect(
          actualResult.strCategoryDescription,
          equals(mealCategoryModel.strCategoryDescription),
        );
      },
    );

    test(
      "when call toMealCategoryEntity with non-null values it should return MealCategoryEntity with correct values",
      () {
        // Arrange
        final MealCategoryModel mealCategoryModel = MealCategoryModel(
          idCategory: "1",
          strCategory: "Seafood",
          strCategoryThumb:
              "https://www.themealdb.com/images/category/seafood.png",
          strCategoryDescription:
              "Seafood includes fish, shellfish and other sea creatures.",
        );

        // Act
        final MealCategoryEntity actualResult = mealCategoryModel
            .toMealCategoryEntity();

        // Assert
        expect(actualResult.idCategory, equals(mealCategoryModel.idCategory));
        expect(actualResult.strCategory, equals(mealCategoryModel.strCategory));
        expect(
          actualResult.strCategoryThumb,
          equals(mealCategoryModel.strCategoryThumb),
        );
        expect(
          actualResult.strCategoryDescription,
          equals(mealCategoryModel.strCategoryDescription),
        );
      },
    );
  });
}
