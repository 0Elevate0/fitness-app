import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/repositories/meals_categories/meals_categories_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllMealsCategoriesUseCase {
  final MealsCategoriesRepository _mealsCategoriesRepository;
  const GetAllMealsCategoriesUseCase(this._mealsCategoriesRepository);

  Future<Result<List<MealCategoryEntity>>> invoke() async {
    return await _mealsCategoriesRepository.getAllMealsCategories();
  }
}
