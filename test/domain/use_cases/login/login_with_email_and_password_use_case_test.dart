import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:fitness_app/domain/repositories/login/login_repository.dart';
import 'package:fitness_app/domain/use_cases/login/login_with_email_and_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_with_email_and_password_use_case_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call invoke it should be called successfully from LoginRepository',
    () async {
      //Arrange
      final mockedLoginRepository = MockLoginRepository();
      final loginUseCase = LoginWithEmailAndPasswordUseCase(
        mockedLoginRepository,
      );
      final request = const LoginRequestEntity(
        email: "moaaz10@gmail.com",
        password: "Moaaz@123",
      );
      final expectedResult = Success<void>(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockedLoginRepository.login(request: request),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await loginUseCase.invoke(request: request);

      // Assert
      verify(mockedLoginRepository.login(request: request)).called(1);
      expect(result, isA<Success<void>>());
    },
  );
  test(
    'when repository returns failure it should propagate the failure',
    () async {
      // Arrange
      final mockedLoginRepository = MockLoginRepository();
      final loginUseCase = LoginWithEmailAndPasswordUseCase(
        mockedLoginRepository,
      );
      final request = const LoginRequestEntity(
        email: "test@example.com",
        password: "Wrong@123",
      );
      final expectedResult = Failure<void>(
        responseException: const ResponseException(
          message: 'Invalid credentials',
        ),
      );
      provideDummy<Result<void>>(expectedResult);
      when(
        mockedLoginRepository.login(request: request),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await loginUseCase.invoke(request: request);

      // Assert
      expect(result, isA<Failure<void>>());
    },
  );
}
