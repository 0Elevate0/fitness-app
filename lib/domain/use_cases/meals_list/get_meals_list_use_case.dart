import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/domain/repositories/meals_list/meals_list_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealsListUseCase {
  final MealsListRepository _mealsListRepository;

  const GetMealsListUseCase(this._mealsListRepository);

  Future<Result<List<MealEntity>>> invoke(String category) async {
    return await _mealsListRepository.getMealsByCategory(category);
  }
}
