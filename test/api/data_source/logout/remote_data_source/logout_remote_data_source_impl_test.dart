import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/logout/remote_data_source/logout_remote_data_source_impl.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/core/secure_storage/secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity, SecureStorage])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockApiClient mockApiClient;
  late final MockConnectivity mockedConnectivity;
  late final MockSecureStorage mockedSecureStorage;
  late final LogoutRemoteDataSourceImpl logoutRemoteDataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    mockedSecureStorage = MockSecureStorage();
    logoutRemoteDataSource = LogoutRemoteDataSourceImpl(
      mockApiClient,
      mockedSecureStorage,
    );
  });
  test(
    'when call logout it should be called successfully from ApiClient',
    () async {
      // Arrange
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.logout(token: anyNamed("token")),
      ).thenAnswer((_) async {});

      // Act
      final result = await logoutRemoteDataSource.logout();

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockApiClient.logout(token: anyNamed("token"))).called(1);
    },
  );
}
