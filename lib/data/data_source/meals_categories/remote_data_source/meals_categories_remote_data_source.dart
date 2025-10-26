import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';

abstract interface class MealsCategoriesRemoteDataSource {
  Future<Result<List<MealCategoryEntity>>> getAllMealsCategories();
}
