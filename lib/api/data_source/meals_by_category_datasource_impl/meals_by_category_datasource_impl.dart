import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/meals_by_category_group/meals_by_category_datasource.dart';
import 'package:fitness_app/domain/entities/meal_by_category/meal_entity.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: MealsByCategoryDataSource)
class MealsByCategoryDataSourceImpl implements MealsByCategoryDataSource {
  final ApiClient _apiClient;
  @factoryMethod
  const MealsByCategoryDataSourceImpl(this._apiClient);
  @override
  Future<Result<List<MealEntity>>> getMealsByCategory({required String categoryName})async{
return await executeApi(()async{
  final responce=await _apiClient.getMealsByCategory(categoryName:categoryName );
 final  result= responce.meals?.map((meal)=>meal.toMealEntity()).toList()??[];
  return result;
});

  }
}