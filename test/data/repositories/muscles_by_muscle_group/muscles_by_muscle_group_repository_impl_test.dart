import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/muscles_by_muscle_group/remote_data_source/muscles_by_muscle_group_remote_data_source.dart';
import 'package:fitness_app/data/repositories/muscles_by_muscle_group/muscles_by_muscle_group_repository_impl.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'muscles_by_muscle_group_repository_impl_test.mocks.dart';

@GenerateMocks([MusclesByMuscleGroupRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getAllMusclesByMuscleGroup it should be called successfully from MusclesByMuscleGroupRemoteDataSource and returns a List of MuscleEntity',
    () async {
      // Arrange
      final MockMusclesByMuscleGroupRemoteDataSource
      mockedMusclesByMuscleGroupRemoteDataSource =
          MockMusclesByMuscleGroupRemoteDataSource();
      final musclesByMuscleGroupRepositoryImpl =
          MusclesByMuscleGroupRepositoryImpl(
            mockedMusclesByMuscleGroupRemoteDataSource,
          );
      final expectedMuscleEntityList = const [
        MuscleEntity(image: "shoulder image", name: "shoulder", id: "1"),
        MuscleEntity(image: "triceps image", name: "triceps", id: "2"),
      ];
      final expectedResult = Success<List<MuscleEntity>>(
        expectedMuscleEntityList,
      );
      provideDummy<Result<List<MuscleEntity>>>(expectedResult);
      when(
        mockedMusclesByMuscleGroupRemoteDataSource.getAllMusclesByMuscleGroup(
          muscleGroupId: anyNamed("muscleGroupId"),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await musclesByMuscleGroupRepositoryImpl
          .getAllMusclesByMuscleGroup(muscleGroupId: "1234");

      // Assert
      expect(result, isA<Success<List<MuscleEntity>>>());
      final successResult = result as Success<List<MuscleEntity>>;
      expect(successResult.data, equals(expectedMuscleEntityList));
      expect(
        successResult.data.elementAt(0),
        equals(expectedMuscleEntityList.elementAt(0)),
      );
      expect(
        successResult.data.elementAt(1),
        equals(expectedMuscleEntityList.elementAt(1)),
      );
      verify(
        mockedMusclesByMuscleGroupRemoteDataSource.getAllMusclesByMuscleGroup(
          muscleGroupId: anyNamed("muscleGroupId"),
        ),
      ).called(1);
    },
  );
}
