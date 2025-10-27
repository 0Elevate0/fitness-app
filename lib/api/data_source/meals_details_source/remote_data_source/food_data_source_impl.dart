import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/meals_details/remote_data_sourse/food_details_remote_data_source.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MealDetailsRemoteDataSource)
final class MealDetailsRemoteDataSourceImpl
    implements MealDetailsRemoteDataSource {
  final ApiClient _apiClient;

  const MealDetailsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<MealDetailsEntity>> getMealDetailsByID() async {
    return await executeApi(() async {
      final response = await _apiClient.getAllMealsDetails();

      final mealDetailsModel = response.meals?.first;

      if (mealDetailsModel == null) {
        throw Exception("Meal details not found or list is empty.");
      }
      return mealDetailsModel.toMealDetailsEntity();
    });
  }
}
