import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/repositories/muscles_by_muscle_group/muscles_by_muscle_group_repository.dart';
import 'package:fitness_app/domain/use_cases/muscles_by_muscle_group/get_all_muscles_by_muscle_group_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_muscles_by_muscle_group_use_case_test.mocks.dart';

@GenerateMocks([MusclesByMuscleGroupRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getAllMusclesByMuscleGroup it should be called successfully from MusclesByMuscleGroupRepository and returns a List of MuscleEntity',
    () async {
      // Arrange
      final MockMusclesByMuscleGroupRepository
      mockedMusclesByMuscleGroupRepository =
          MockMusclesByMuscleGroupRepository();
      final getAllMusclesByMuscleGroupUseCase =
          GetAllMusclesByMuscleGroupUseCase(
            mockedMusclesByMuscleGroupRepository,
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
        mockedMusclesByMuscleGroupRepository.getAllMusclesByMuscleGroup(
          muscleGroupId: anyNamed("muscleGroupId"),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await getAllMusclesByMuscleGroupUseCase.invoke(
        muscleGroupId: "1234",
      );

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
        mockedMusclesByMuscleGroupRepository.getAllMusclesByMuscleGroup(
          muscleGroupId: anyNamed("muscleGroupId"),
        ),
      ).called(1);
    },
  );
}
