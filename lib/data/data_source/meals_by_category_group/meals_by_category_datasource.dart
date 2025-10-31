import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meal_by_category/meal_entity.dart';

abstract interface class MealsByCategoryDataSource {
  Future<Result<List<MealEntity>>>getMealsByCategory({required String categoryName});
}