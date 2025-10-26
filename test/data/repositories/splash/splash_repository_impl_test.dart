import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/splash/remote_data_source/splash_remote_data_source.dart';
import 'package:fitness_app/data/repositories/splash/splash_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_repository_impl_test.mocks.dart';

@GenerateMocks([SplashRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getUserData it should be called successfully from SplashRemoteDataSource and return UserDataEntity',
    () async {
      // Arrange
      final mockedSplashRemoteDataSource = MockSplashRemoteDataSource();
      final splashRepositoryImpl = SplashRepositoryImpl(
        mockedSplashRemoteDataSource,
      );
      final expectedUserDataEntityResult = Success<void>(null);
      provideDummy<Result<void>>(expectedUserDataEntityResult);
      when(
        mockedSplashRemoteDataSource.getUserData(),
      ).thenAnswer((_) async => expectedUserDataEntityResult);

      // Act
      final result = await splashRepositoryImpl.getUserData();

      // Assert
      verify(mockedSplashRemoteDataSource.getUserData()).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
