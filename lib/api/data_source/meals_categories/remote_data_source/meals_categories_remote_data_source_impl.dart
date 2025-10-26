import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/meals_categories/remote_data_source/meals_categories_remote_data_source.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MealsCategoriesRemoteDataSource)
final class MealsCategoriesRemoteDataSourceImpl
    implements MealsCategoriesRemoteDataSource {
  final ApiClient _apiClient;

  const MealsCategoriesRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<List<MealCategoryEntity>>> getAllMealsCategories() async {
    return await executeApi(() async {
      final response = await _apiClient.getAllMealsCategories();
      final mealsCategoriesList =
          response.categories
              ?.map((mealCategory) => mealCategory.toMealCategoryEntity())
              .toList() ??
          [];
      return mealsCategoriesList;
    });
  }
}
