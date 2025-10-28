import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/domain/repositories/muscles_group/muscles_group_repository.dart';
import 'package:fitness_app/domain/use_cases/muscles_group/get_all_muscles_group_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_muscles_group_use_case_test.mocks.dart';

@GenerateMocks([MusclesGroupRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getAllMusclesGroup it should be called successfully from MusclesGroupRepository and returns a List of MuscleGroupEntity',
    () async {
      // Arrange
      final MockMusclesGroupRepository mockedMusclesGroupRepository =
          MockMusclesGroupRepository();
      final getAllMusclesGroupUseCase = GetAllMusclesGroupUseCase(
        mockedMusclesGroupRepository,
      );
      final expectedMuscleGroupEntityList = const [
        MuscleGroupEntity(name: "shoulder", id: "1"),
        MuscleGroupEntity(name: "triceps", id: "2"),
      ];
      final expectedResult = Success<List<MuscleGroupEntity>>(
        expectedMuscleGroupEntityList,
      );
      provideDummy<Result<List<MuscleGroupEntity>>>(expectedResult);
      when(
        mockedMusclesGroupRepository.getAllMusclesGroup(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await getAllMusclesGroupUseCase.invoke();

      // Assert
      expect(result, isA<Success<List<MuscleGroupEntity>>>());
      final successResult = result as Success<List<MuscleGroupEntity>>;
      expect(successResult.data, equals(expectedMuscleGroupEntityList));
      expect(
        successResult.data.elementAt(0),
        equals(expectedMuscleGroupEntityList.elementAt(0)),
      );
      expect(
        successResult.data.elementAt(1),
        equals(expectedMuscleGroupEntityList.elementAt(1)),
      );
      verify(mockedMusclesGroupRepository.getAllMusclesGroup()).called(1);
    },
  );
}
