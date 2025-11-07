import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/edit_profile/remote_data_source/edit_profile_remote_data_source_impl.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockApiClient mockApiClient;
  late final MockConnectivity mockedConnectivity;
  late final EditProfileRemoteDataSourceImpl editProfileRemoteDataSourceImpl;
  setUpAll(() {
    mockApiClient = MockApiClient();
    mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    editProfileRemoteDataSourceImpl = EditProfileRemoteDataSourceImpl(
      mockApiClient,
    );
    when(
      mockedConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
  });
  test(
    'when call updatePhoto it should be called successfully from apiClient',
    () async {
      final expectedUpdateProfilePhotoResult = Success(null);
      provideDummy<Result<void>>(expectedUpdateProfilePhotoResult);

      when(
        mockApiClient.updatePhoto(
          token: anyNamed("token"),
          newPhoto: anyNamed("newPhoto"),
        ),
      ).thenAnswer((_) async {});

      // Act
      final result = await editProfileRemoteDataSourceImpl.updateProfilePhoto(
        newPhoto: File("imagePath"),
      );

      // Assert
      expect(result, isA<Success<void>>());
      verify(
        mockApiClient.updatePhoto(
          token: anyNamed("token"),
          newPhoto: anyNamed("newPhoto"),
        ),
      ).called(1);
    },
  );

  test(
    'when call editProfile it should be called successfully from apiClient',
    () async {
      final expectedEditProfileResult = Success(null);
      provideDummy<Result<void>>(expectedEditProfileResult);

      when(
        mockApiClient.editProfile(
          token: anyNamed("token"),
          request: anyNamed("request"),
        ),
      ).thenAnswer((_) async {});

      // Act
      final result = await editProfileRemoteDataSourceImpl.editProfile(
        request: const EditProfileRequestEntity(
          goal: "goal",
          activityLevel: "level1",
          lastName: "lastName",
          firstName: "firstName",
          weight: 90,
        ),
      );

      // Assert
      expect(result, isA<Success<void>>());
      verify(
        mockApiClient.editProfile(
          token: anyNamed("token"),
          request: anyNamed("request"),
        ),
      ).called(1);
    },
  );
}
