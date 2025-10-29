import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';

abstract interface class MealsListRepository {
  Future<Result<List<MealEntity>>> getMealsByCategory(category);
}
