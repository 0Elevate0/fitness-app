import 'dart:io';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/edit_profile/remote_data_source/edit_profile_remote_data_source.dart';
import 'package:fitness_app/data/repositories/edit_profile/edit_profile_repository_impl.dart';
import 'package:fitness_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_repository_impl_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockEditProfileRemoteDataSource mockedEditProfileRemoteDataSource;
  late final EditProfileRepositoryImpl editProfileRepositoryImpl;

  setUpAll(() {
    mockedEditProfileRemoteDataSource = MockEditProfileRemoteDataSource();
    editProfileRepositoryImpl = EditProfileRepositoryImpl(
      mockedEditProfileRemoteDataSource,
    );
  });
  test(
    'when call updateProfilePhoto it should be called successfully from EditProfileRemoteDataSource',
    () async {
      // Arrange
      final expectedUpdateProfilePhotoResult = Success<void>(null);
      provideDummy<Result<void>>(expectedUpdateProfilePhotoResult);
      when(
        mockedEditProfileRemoteDataSource.updateProfilePhoto(
          newPhoto: anyNamed("newPhoto"),
        ),
      ).thenAnswer((_) async => expectedUpdateProfilePhotoResult);

      // Act
      final result = await editProfileRepositoryImpl.updateProfilePhoto(
        newPhoto: File("photoPath"),
      );

      // Assert
      expect(result, isA<Success<void>>());
      verify(
        mockedEditProfileRemoteDataSource.updateProfilePhoto(
          newPhoto: anyNamed("newPhoto"),
        ),
      ).called(1);
    },
  );

  test(
    'when call editProfile it should be called successfully from EditProfileRemoteDataSource',
    () async {
      // Arrange
      final expectedEditProfileResult = Success<void>(null);
      provideDummy<Result<void>>(expectedEditProfileResult);
      when(
        mockedEditProfileRemoteDataSource.editProfile(
          request: anyNamed("request"),
        ),
      ).thenAnswer((_) async => expectedEditProfileResult);

      // Act
      final result = await editProfileRepositoryImpl.editProfile(
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
        mockedEditProfileRemoteDataSource.editProfile(
          request: anyNamed("request"),
        ),
      ).called(1);
    },
  );
}
