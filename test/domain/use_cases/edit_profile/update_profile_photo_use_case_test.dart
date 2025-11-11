import 'dart:io';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/repositories/edit_profile/edit_profile_repository.dart';
import 'package:fitness_app/domain/use_cases/edit_profile/update_profile_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_profile_photo_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call updateProfilePhoto it should be called successfully from EditProfileRepository',
    () async {
      //Arrange
      final mockedEditProfileRepository = MockEditProfileRepository();
      final updateProfilePhotoUseCase = UpdateProfilePhotoUseCase(
        mockedEditProfileRepository,
      );
      final expectedUpdateProfilePhotoResult = Success<void>(null);
      provideDummy<Result<void>>(expectedUpdateProfilePhotoResult);
      when(
        mockedEditProfileRepository.updateProfilePhoto(
          newPhoto: anyNamed("newPhoto"),
        ),
      ).thenAnswer((_) async => expectedUpdateProfilePhotoResult);

      // Act
      final result = await updateProfilePhotoUseCase.invoke(
        newPhoto: File("photoPath"),
      );

      // Assert
      expect(result, isA<Success<void>>());
      verify(
        mockedEditProfileRepository.updateProfilePhoto(
          newPhoto: anyNamed("newPhoto"),
        ),
      ).called(1);
    },
  );
}
