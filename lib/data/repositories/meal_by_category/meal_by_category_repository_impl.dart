import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/meals_by_category_group/meals_by_category_datasource.dart';
import 'package:fitness_app/domain/entities/meal_by_category/meal_entity.dart';
import 'package:fitness_app/domain/repositories/meals_by_category/meals_by_category_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: MealByCategoryRepository)
class MealByCategoryRepositoryImpl implements MealByCategoryRepository{
  final MealsByCategoryDataSource _mealsByCategoryDataSource;
  const MealByCategoryRepositoryImpl(this._mealsByCategoryDataSource);
  @override
  Future<Result<List<MealEntity>>>getMealsByCategory({required String categoryName}) async{
 final result=await _mealsByCategoryDataSource.getMealsByCategory(categoryName: categoryName);
return result;
  }

}