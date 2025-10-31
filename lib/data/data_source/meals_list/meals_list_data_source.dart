import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';

abstract interface class MealsListDataSource {
  Future<Result<List<MealEntity>>> getMealsByCategory(String category);
}
