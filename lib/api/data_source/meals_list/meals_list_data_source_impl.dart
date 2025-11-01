import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/meals_list/meals_list_data_source.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MealsListDataSource)
final class MealsListDataSourceImpl implements MealsListDataSource {
  final ApiClient _apiClient;

  const MealsListDataSourceImpl(this._apiClient);

  @override
  Future<Result<List<MealEntity>>> getMealsByCategory(category) async {
    return await executeApi(() async {
      final response = await _apiClient.getMealsByCategory(category);
      final mealsList =
          response.meals?.map((meal) => meal.toMealEntity()).toList() ?? [];
      return mealsList;
    });
  }
}
