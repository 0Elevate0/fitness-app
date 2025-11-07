import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:fitness_app/domain/use_cases/edit_profile/update_profile_photo_use_case.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fake_form_state.dart';
import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([UpdateProfilePhotoUseCase, EditProfileUseCase, ImagePicker])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUpdateProfilePhotoUseCase mockUpdateProfilePhotoUseCase;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockImagePicker mockImagePicker;
  late EditProfileCubit cubit;
  late Result<void> expectedEditProfilePicSuccessResult;
  late Failure<void> expectedEditProfilePicFailureResult;
  late Result<void> expectedEditProfileDetailsSuccessResult;
  late Failure<void> expectedEditProfileDetailsFailureResult;

  setUpAll(() {
    mockUpdateProfilePhotoUseCase = MockUpdateProfilePhotoUseCase();
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockImagePicker = MockImagePicker();
  });

  setUp(() {
    cubit = EditProfileCubit(
      mockUpdateProfilePhotoUseCase,
      mockEditProfileUseCase,
    );
    cubit.doIntent(intent: const EditProfileInitializationIntent());
    cubit.editProfileKey = FakeGlobalKey(FakeFormState());
    cubit.picker = mockImagePicker;
  });

  group("EditProfile Cubit test", () {
    blocTest<EditProfileCubit, EditProfileState>(
      'emits [Loading, Success] when EditProfilePicIntent succeeds',
      build: () {
        expectedEditProfilePicSuccessResult = Success<void>(null);
        provideDummy<Result<void>>(expectedEditProfilePicSuccessResult);
        when(
          mockUpdateProfilePhotoUseCase.invoke(newPhoto: anyNamed("newPhoto")),
        ).thenAnswer((_) async => expectedEditProfilePicSuccessResult);
        when(
          mockImagePicker.pickImage(source: ImageSource.gallery),
        ).thenAnswer((_) async => XFile("imagePath"));
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const EditProfilePicIntent()),
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.updatePhotoStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<EditProfileState>()
            .having(
              (state) => state.updatePhotoStatus.isSuccess,
              "Is in Success state",
              equals(true),
            )
            .having(
              (state) => state.newSelectedImg,
              "Is having the data as expected",
              equals(isNotNull),
            ),
        isA<EditProfileState>().having(
          (state) => state.updatePhotoStatus.isInitial,
          "Is Back to Initial state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockUpdateProfilePhotoUseCase.invoke(newPhoto: anyNamed("newPhoto")),
        ).called(1);
      },
    );

    blocTest<EditProfileCubit, EditProfileState>(
      "emits [Loading, Failure] when EditProfilePicIntent is Called",
      build: () {
        expectedEditProfilePicFailureResult = Failure(
          responseException: const ResponseException(
            message: "failed to edit profile pic",
          ),
        );

        provideDummy<Result<void>>(expectedEditProfilePicFailureResult);
        when(
          mockUpdateProfilePhotoUseCase.invoke(newPhoto: anyNamed("newPhoto")),
        ).thenAnswer((_) async => expectedEditProfilePicFailureResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const EditProfilePicIntent()),
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.updatePhotoStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<EditProfileState>()
            .having(
              (state) => state.updatePhotoStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.updatePhotoStatus.error?.message,
              'Is having the expected data',
              equals(
                expectedEditProfilePicFailureResult.responseException.message,
              ),
            ),
        isA<EditProfileState>().having(
          (state) => state.updatePhotoStatus.isInitial,
          "Is back to initial state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockUpdateProfilePhotoUseCase.invoke(newPhoto: anyNamed("newPhoto")),
        ).called(1);
      },
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'emits [Loading, Success] when EditProfileDetailsIntent succeeds',
      build: () {
        expectedEditProfileDetailsSuccessResult = Success<void>(null);
        provideDummy<Result<void>>(expectedEditProfileDetailsSuccessResult);
        when(
          mockEditProfileUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedEditProfileDetailsSuccessResult);
        cubit.lastNameController.text = "tarek";
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const EditProfileDetailsIntent()),
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.editProfileStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<EditProfileState>().having(
          (state) => state.editProfileStatus.isSuccess,
          "Is in Success state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockEditProfileUseCase.invoke(request: anyNamed("request")),
        ).called(1);
      },
    );

    blocTest<EditProfileCubit, EditProfileState>(
      "emits [Loading, Failure] when EditProfileDetailsIntent is Called",
      build: () {
        expectedEditProfileDetailsFailureResult = Failure(
          responseException: const ResponseException(
            message: "failed to edit profile details",
          ),
        );

        provideDummy<Result<void>>(expectedEditProfileDetailsFailureResult);
        when(
          mockEditProfileUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedEditProfileDetailsFailureResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const EditProfileDetailsIntent()),
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.editProfileStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<EditProfileState>()
            .having(
              (state) => state.editProfileStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.editProfileStatus.error?.message,
              'Is having the expected data',
              equals(
                expectedEditProfileDetailsFailureResult
                    .responseException
                    .message,
              ),
            ),
        isA<EditProfileState>().having(
          (state) => state.editProfileStatus.isInitial,
          "Is back to initial state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockEditProfileUseCase.invoke(request: anyNamed("request")),
        ).called(1);
      },
    );

    blocTest<EditProfileCubit, EditProfileState>(
      "on EditWeightIntent emits selectedWeight with the value selected",
      build: () => cubit,
      act: (cubit) =>
          cubit.doIntent(intent: const EditWeightIntent(newSelectedWeight: 85)),
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.selectedWeight,
          "selectedWeight == 85",
          equals(85),
        ),
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      "on EditGoalIntent emits selectedGoal with the value selected",
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        intent: EditGoalIntent(goal: FitnessMethodHelper.goals[0]),
      ),
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.selectedGoal,
          "selectedGoal == the goal selected",
          equals(FitnessMethodHelper.goals[0]),
        ),
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      "on EditActivityIntent emits selectedActivity with the value selected",
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        intent: EditActivityIntent(
          activity: FitnessMethodHelper.activityLevels[0],
        ),
      ),
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.selectedActivityLevel,
          "activity == the selected activity",
          equals(ActivityLevels.level1.name),
        ),
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      "on ChangeEditProfileSectionIntent emits currentSection with the value selected",
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        intent: const ChangeEditProfileSectionIntent(
          section: EditProfileSection.editGoal,
        ),
      ),
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.currentSection,
          "currentSection == the selected Section",
          equals(EditProfileSection.editGoal),
        ),
      ],
    );
  });
}
