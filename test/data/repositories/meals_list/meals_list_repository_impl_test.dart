import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/data/data_source/meals_list/meals_list_data_source.dart';
import 'package:fitness_app/data/repositories/meals_list/meals_list_repository_impl.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meals_list_repository_impl_test.mocks.dart';

@GenerateMocks([MealsListDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getMealsByCategory it should be called successfully from MealsListDataSource',
    () async {
      // Arrange
      final mockedMealsListDataSource = MockMealsListDataSource();
      final mealsListRepositoryImpl = MealsListRepositoryImpl(
        mockedMealsListDataSource,
      );

      final expectedResult = Success<List<MealEntity>>([]);
      provideDummy<Result<List<MealEntity>>>(expectedResult);

      when(
        mockedMealsListDataSource.getMealsByCategory('beef'),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await mealsListRepositoryImpl.getMealsByCategory('beef');

      // Assert

      verify(mockedMealsListDataSource.getMealsByCategory('beef')).called(1);
      expect(result, isA<Success<List<MealEntity>>>());
    },
  );
  test('when getMealsByCategory fails it should return Failure', () async {
    // Arrange
    final mockedMealsListDataSource = MockMealsListDataSource();
    final mealsListRepositoryImpl = MealsListRepositoryImpl(
      mockedMealsListDataSource,
    );

    final expectedResult = Failure<List<MealEntity>>(
      responseException: const ResponseException(message: 'someThing wrong'),
    );
    provideDummy<Result<List<MealEntity>>>(expectedResult);
    when(
      mockedMealsListDataSource.getMealsByCategory('beef'),
    ).thenAnswer((_) async => expectedResult);

    // Act
    final result = await mealsListRepositoryImpl.getMealsByCategory('beef');

    // Assert
    expect(result, isA<Failure<List<MealEntity>>>());
  });
}
