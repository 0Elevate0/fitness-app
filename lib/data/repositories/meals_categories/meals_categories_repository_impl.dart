import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/meals_categories/remote_data_source/meals_categories_remote_data_source.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/repositories/meals_categories/meals_categories_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MealsCategoriesRepository)
final class MealsCategoriesRepositoryImpl implements MealsCategoriesRepository {
  final MealsCategoriesRemoteDataSource _mealsCategoriesRemoteDataSource;
  const MealsCategoriesRepositoryImpl(this._mealsCategoriesRemoteDataSource);

  @override
  Future<Result<List<MealCategoryEntity>>> getAllMealsCategories() async {
    return await _mealsCategoriesRemoteDataSource.getAllMealsCategories();
  }
}
