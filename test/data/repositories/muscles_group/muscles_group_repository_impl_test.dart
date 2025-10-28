import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/muscles_group/remote_data_source/muscles_group_remote_data_source.dart';
import 'package:fitness_app/data/repositories/muscles_group/muscles_group_repository_impl.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'muscles_group_repository_impl_test.mocks.dart';

@GenerateMocks([MusclesGroupRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getAllMusclesGroup it should be called successfully from MusclesGroupRemoteDataSource and returns a List of MuscleGroupEntity',
    () async {
      // Arrange
      final MockMusclesGroupRemoteDataSource
      mockedMusclesGroupRemoteDataSource = MockMusclesGroupRemoteDataSource();
      final musclesGroupRepositoryImpl = MusclesGroupRepositoryImpl(
        mockedMusclesGroupRemoteDataSource,
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
        mockedMusclesGroupRemoteDataSource.getAllMusclesGroup(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await musclesGroupRepositoryImpl.getAllMusclesGroup();

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
      verify(mockedMusclesGroupRemoteDataSource.getAllMusclesGroup()).called(1);
    },
  );
}
