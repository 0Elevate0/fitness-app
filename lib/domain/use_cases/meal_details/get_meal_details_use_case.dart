import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/repositories/meal_details/meal_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealDetailsUseCase {
  final MealDetailsRepository _mealDetailsRepository;
  const GetMealDetailsUseCase(this._mealDetailsRepository);

  Future<Result<MealDetailsEntity?>> invoke({required String mealId}) async {
    return await _mealDetailsRepository.getMealDetails(mealId: mealId);
  }
}
