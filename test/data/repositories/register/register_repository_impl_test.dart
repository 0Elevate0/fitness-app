import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/register/remote_data_source/register_remote_data_source.dart';
import 'package:fitness_app/data/repositories/register/register_repository_impl.dart';
import 'package:fitness_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_repository_impl_test.mocks.dart';

@GenerateMocks([RegisterRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call register it should be called successfully from RegisterRemoteDataSource',
    () async {
      // Arrange
      final mockedRegisterRemoteDataSource = MockRegisterRemoteDataSource();
      final registerRepositoryImpl = RegisterRepositoryImpl(
        mockedRegisterRemoteDataSource,
      );
      final requestEntity = const RegisterRequestEntity(
        firstName: 'ahmed',
        lastName: 'tarek',
        email: 'ahmed@example.com',
        password: 'Ahmed\$123',
        rePassword: 'Ahmed\$123',
        gender: 'male',
        height: 190,
        weight: 86,
        age: 24,
        goal: 'loseWeight',
        activityLevel: 'level3',
      );
      final expectedResult = Success<void>(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockedRegisterRemoteDataSource.register(request: anyNamed("request")),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await registerRepositoryImpl.register(
        request: requestEntity,
      );

      // Assert
      verify(
        mockedRegisterRemoteDataSource.register(request: anyNamed("request")),
      ).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
