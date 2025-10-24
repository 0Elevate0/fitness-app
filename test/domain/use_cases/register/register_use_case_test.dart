import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:fitness_app/domain/repositories/register/register_repository.dart';
import 'package:fitness_app/domain/use_cases/register/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_use_case_test.mocks.dart';

@GenerateMocks([RegisterRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call invoke it should be called successfully from RegisterRepository',
    () async {
      //Arrange
      final mockedRegisterRepository = MockRegisterRepository();
      final registerUseCase = RegisterUseCase(mockedRegisterRepository);
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
        mockedRegisterRepository.register(request: anyNamed("request")),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await registerUseCase.invoke(request: requestEntity);

      // Assert
      verify(
        mockedRegisterRepository.register(request: anyNamed("request")),
      ).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
