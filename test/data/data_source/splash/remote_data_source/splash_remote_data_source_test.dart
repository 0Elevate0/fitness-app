import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/splash/remote_data_source/splash_remote_data_source_impl.dart';
import 'package:fitness_app/api/models/user/user_model.dart';
import 'package:fitness_app/api/responses/splash_response/splash_response.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_remote_data_source_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getUserData it should be called successfully from apiClient and return UserDataEntity',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockedConnectivity;
      final splashRemoteDataSourceImpl = SplashRemoteDataSourceImpl(
        mockApiClient,
      );
      final expectedUserDataModel = UserModel(
        id: "1",
        email: "ahmed@gmail.com",
        firstName: "ahmed",
        lastName: "tarek",
        gender: "male",
        photo: "profilePic",
        createdAt: "2020-01-01",
      );
      final expectedSplashResponse = SplashResponse(
        message: "success",
        user: expectedUserDataModel,
      );
      final expectedUserDataEntityResult = Success(
        expectedUserDataModel.toUserDataEntity(),
      );
      provideDummy<Result<UserDataEntity?>>(expectedUserDataEntityResult);
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.getUserData(token: anyNamed("token")),
      ).thenAnswer((_) async => expectedSplashResponse);

      // Act
      final result = await splashRemoteDataSourceImpl.getUserData();

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockApiClient.getUserData(token: anyNamed("token"))).called(1);
      expect(
        expectedUserDataEntityResult.data.id,
        equals(FitnessMethodHelper.userData?.id),
      );
      expect(
        expectedUserDataEntityResult.data.email,
        equals(FitnessMethodHelper.userData?.email),
      );
      expect(
        expectedUserDataEntityResult.data.photo,
        equals(FitnessMethodHelper.userData?.photo),
      );
    },
  );
}
