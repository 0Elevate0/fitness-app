import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meal_by_category/meal_entity.dart';
import 'package:fitness_app/domain/repositories/meals_by_category/meals_by_category_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealByCategoryUseCase{
  final MealByCategoryRepository _mealByCategoryRepository;
  @factoryMethod
  const GetMealByCategoryUseCase(this._mealByCategoryRepository);
  Future<Result<List<MealEntity>>>invoke(String categoryName)async{
    return await _mealByCategoryRepository.getMealsByCategory(categoryName:categoryName);
  }
}