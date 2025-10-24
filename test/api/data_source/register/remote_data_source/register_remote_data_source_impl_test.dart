import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/register/remote_data_source/register_remote_data_source_impl.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call register it should be called successfully from apiClient',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockedConnectivity;
      final registerRemoteDataSourceImpl = RegisterRemoteDataSourceImpl(
        mockApiClient,
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
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.register(request: anyNamed("request")),
      ).thenAnswer((_) async {});

      // Act
      final result = await registerRemoteDataSourceImpl.register(
        request: requestEntity,
      );

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockApiClient.register(request: anyNamed("request"))).called(1);
    },
  );
}
