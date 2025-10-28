import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/repositories/food_details/food_repository.dart';
import 'package:fitness_app/domain/use_cases/get_meal_details/get_meal_details_use_case.dart'; // يتطلب استخدام الواجهة
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_meal_details_use_case_test.mocks.dart';

@GenerateMocks([MealDetailsRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const mockMealEntity = MealDetailsEntity(
    idMeal: '52959',
    strMeal: 'Baked salmon',
    strInstructions: 'Mock instructions',
    ingredients: [],
  );

  const testMealId = '52959';
  late MockMealDetailsRepository mockedRepository;
  late GetMealDetailsUseCase useCase;

  setUp(() {
    mockedRepository = MockMealDetailsRepository();
    useCase = GetMealDetailsUseCase(mockedRepository);
  });

  group('GetMealDetailsUseCase Tests', () {
    test(
      'when invoke is called successfully it should return Success with MealDetailsEntity',
          () async {
        // Arrange
        final expectedResult = Success<MealDetailsEntity>(mockMealEntity);
        provideDummy<Result<MealDetailsEntity>>(expectedResult);

        when(
          mockedRepository.getMealDetails(mealId: testMealId),
        ).thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.invoke(mealId: testMealId);

        // Assert
        expect(result, isA<Success<MealDetailsEntity>>());
        expect((result as Success).data, equals(mockMealEntity));
      },
    );

    test(
      'when repository returns failure it should propagate the failure result',
          () async {
        // Arrange
        final expectedFailure = Failure<MealDetailsEntity>(
          responseException: const ResponseException(
            message: 'Failed to fetch meal details',
          ),
        );
        provideDummy<Result<MealDetailsEntity>>(expectedFailure);

        when(
          mockedRepository.getMealDetails(mealId: testMealId),
        ).thenAnswer((_) async => expectedFailure);

        // Act
        final result = await useCase.invoke(mealId: testMealId);

        expect(result, isA<Failure<MealDetailsEntity>>());
        expect((result as Failure).responseException.message, equals('Failed to fetch meal details'));
      },
    );
  });
}