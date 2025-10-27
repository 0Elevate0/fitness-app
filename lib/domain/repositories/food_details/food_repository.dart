import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';

abstract class MealDetailsRepository {
  Future<Result<MealDetailsEntity>> getMealDetails({required String mealId});
}