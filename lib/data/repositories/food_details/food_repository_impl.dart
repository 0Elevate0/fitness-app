import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/meals_details/remote_data_sourse/food_details_remote_data_source.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/repositories/food_details/food_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MealDetailsRepository)
final class MealDetailsRepositoryImpl implements MealDetailsRepository {
  final MealDetailsRemoteDataSource _remoteDataSource;

  const MealDetailsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<MealDetailsEntity>> getMealDetails({required String mealId}) async {
    return await _remoteDataSource.getMealDetailsByID();
  }
}