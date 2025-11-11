import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/repositories/meals_categories/meals_categories_repository.dart';
import 'package:fitness_app/domain/use_cases/meals_categories/get_all_meals_categories_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_meals_categories_use_case_test.mocks.dart';

@GenerateMocks([MealsCategoriesRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getAllMealsCategories it should be called successfully from MealsCategoriesRepository and returns a List of MealCategoryEntity',
    () async {
      // Arrange
      final MockMealsCategoriesRepository mockedMealsCategoriesRepository =
          MockMealsCategoriesRepository();
      final getAllMealsCategoriesUseCase = GetAllMealsCategoriesUseCase(
        mockedMealsCategoriesRepository,
      );
      final expectedMealCategoryEntityList = const [
        MealCategoryEntity(
          idCategory: "1",
          strCategory: "Beef",
          strCategoryThumb:
              "https://www.themealdb.com/images/category/beef.png",
          strCategoryDescription:
              "Beef is the culinary name for meat from cattle, particularly skeletal muscle.",
        ),
        MealCategoryEntity(
          idCategory: "2",
          strCategory: "Chicken",
          strCategoryThumb:
              "https://www.themealdb.com/images/category/chicken.png",
          strCategoryDescription:
              "Chicken is one of the most common types of poultry in the world, known for its versatility in cooking.",
        ),
      ];
      final expectedResult = Success<List<MealCategoryEntity>>(
        expectedMealCategoryEntityList,
      );
      provideDummy<Result<List<MealCategoryEntity>>>(expectedResult);
      when(
        mockedMealsCategoriesRepository.getAllMealsCategories(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await getAllMealsCategoriesUseCase.invoke();

      // Assert
      expect(result, isA<Success<List<MealCategoryEntity>>>());
      final successResult = result as Success<List<MealCategoryEntity>>;
      expect(successResult.data, equals(expectedMealCategoryEntityList));
      expect(
        successResult.data.elementAt(0),
        equals(expectedMealCategoryEntityList.elementAt(0)),
      );
      expect(
        successResult.data.elementAt(1),
        equals(expectedMealCategoryEntityList.elementAt(1)),
      );
      verify(mockedMealsCategoriesRepository.getAllMealsCategories()).called(1);
    },
  );
}
