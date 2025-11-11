import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/meal_details/remote_data_source/meal_details_remote_data_source.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/repositories/meal_details/meal_details_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MealDetailsRepository)
final class MealDetailsRepositoryImpl implements MealDetailsRepository {
  final MealDetailsRemoteDataSource _mealDetailsRemoteDataSource;
  const MealDetailsRepositoryImpl(this._mealDetailsRemoteDataSource);

  @override
  Future<Result<MealDetailsEntity?>> getMealDetails({
    required String mealId,
  }) async {
    return await _mealDetailsRemoteDataSource.getMealDetails(mealId: mealId);
  }
}
