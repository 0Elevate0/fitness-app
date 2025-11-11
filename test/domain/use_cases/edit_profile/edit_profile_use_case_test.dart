import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:fitness_app/domain/repositories/edit_profile/edit_profile_repository.dart';
import 'package:fitness_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call editProfile it should be called successfully from EditProfileRepository',
    () async {
      //Arrange
      final mockedEditProfileRepository = MockEditProfileRepository();
      final editProfileUseCase = EditProfileUseCase(
        mockedEditProfileRepository,
      );
      final expectedEditProfileResult = Success<void>(null);
      provideDummy<Result<void>>(expectedEditProfileResult);
      when(
        mockedEditProfileRepository.editProfile(request: anyNamed("request")),
      ).thenAnswer((_) async => expectedEditProfileResult);

      // Act
      final result = await editProfileUseCase.invoke(
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
        mockedEditProfileRepository.editProfile(request: anyNamed("request")),
      ).called(1);
    },
  );
}
