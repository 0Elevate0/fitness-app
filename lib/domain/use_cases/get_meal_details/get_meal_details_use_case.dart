import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/repositories/food_details/food_repository.dart';
import 'package:injectable/injectable.dart';

abstract interface class GetMealDetailsUseCaseInterface {
  Future<Result<MealDetailsEntity>> invoke({required String mealId});
}

@injectable
final class GetMealDetailsUseCase implements GetMealDetailsUseCaseInterface {
  final MealDetailsRepository _mealDetailsRepository;

  const GetMealDetailsUseCase(this._mealDetailsRepository);

  @override
  Future<Result<MealDetailsEntity>> invoke({required String mealId}) async {
    return await _mealDetailsRepository.getMealDetails(mealId: mealId);
  }
}