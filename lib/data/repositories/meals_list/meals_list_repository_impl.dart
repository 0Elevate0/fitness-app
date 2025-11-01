import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/meals_list/meals_list_data_source.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/domain/repositories/meals_list/meals_list_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MealsListRepository)
final class MealsListRepositoryImpl implements MealsListRepository {
  final MealsListDataSource _mealsListDataSource;

  const MealsListRepositoryImpl(this._mealsListDataSource);

  @override
  Future<Result<List<MealEntity>>> getMealsByCategory(String category) async {
    return await _mealsListDataSource.getMealsByCategory(category);
  }
}
