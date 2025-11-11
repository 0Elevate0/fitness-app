import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/repositories/splash/splash_repository.dart';
import 'package:fitness_app/domain/use_cases/splash/get_user_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_data_use_case_test.mocks.dart';

@GenerateMocks([SplashRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call invoke it should be called successfully from SplashRepository',
    () async {
      //Arrange
      final mockedSplashRepository = MockSplashRepository();
      final getUserDataUseCase = GetUserDataUseCase(mockedSplashRepository);
      final expectedUserDataEntityResult = Success<void>(null);
      provideDummy<Result<void>>(expectedUserDataEntityResult);
      when(
        mockedSplashRepository.getUserData(),
      ).thenAnswer((_) async => expectedUserDataEntityResult);

      // Act
      final result = await getUserDataUseCase.invoke();

      // Assert
      verify(mockedSplashRepository.getUserData()).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
