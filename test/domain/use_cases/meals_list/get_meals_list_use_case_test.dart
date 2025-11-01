import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/domain/repositories/meals_list/meals_list_repository.dart';
import 'package:fitness_app/domain/use_cases/meals_list/get_meals_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_meals_list_use_case_test.mocks.dart';

@GenerateMocks([MealsListRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call invoke it should be called successfully from MealsListRepository',
    () async {
      //Arrange
      final mockedMealsListRepository = MockMealsListRepository();
      final mealsListUseCase = GetMealsListUseCase(mockedMealsListRepository);
      final expectedResult = Success<List<MealEntity>>([]);
      provideDummy<Result<List<MealEntity>>>(expectedResult);

      when(
        mockedMealsListRepository.getMealsByCategory('beef'),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await mealsListUseCase.invoke('beef');

      // Assert
      verify(mockedMealsListRepository.getMealsByCategory('beef')).called(1);
      expect(result, isA<Success<List<MealEntity>>>());
    },
  );
  test(
    'when repository returns failure it should propagate the failure',
    () async {
      // Arrange
      final mockedMealsListRepository = MockMealsListRepository();
      final mealsListUseCase = GetMealsListUseCase(mockedMealsListRepository);

      final expectedResult = Failure<List<MealEntity>>(
        responseException: const ResponseException(message: 'error'),
      );
      provideDummy<Result<List<MealEntity>>>(expectedResult);

      when(
        mockedMealsListRepository.getMealsByCategory('beef'),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await mealsListUseCase.invoke('beef');

      // Assert
      expect(result, isA<Failure<List<MealEntity>>>());
    },
  );
}
