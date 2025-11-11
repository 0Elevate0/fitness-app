import 'dart:io';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:fitness_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:fitness_app/domain/use_cases/edit_profile/update_profile_photo_use_case.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateProfilePhotoUseCase _updateProfilePhotoUseCase;
  final EditProfileUseCase _editProfileUseCase;

  EditProfileCubit(this._updateProfilePhotoUseCase, this._editProfileUseCase)
    : super(const EditProfileState());
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late GlobalKey<FormState> editProfileKey;
  late ImagePicker picker;

  Future<void> doIntent({required EditProfileIntent intent}) async {
    switch (intent) {
      case EditProfileInitializationIntent():
        _onInit();
        break;
      case EditWeightIntent():
        _editWeight(kg: intent.newSelectedWeight);
        break;
      case EditGoalIntent():
        _editGoal(goal: intent.goal);
        break;
      case EditActivityIntent():
        _editActivity(activity: intent.activity);
        break;
      case ChangeEditProfileSectionIntent():
        _changeSection(section: intent.section);
        break;
      case EditProfilePicIntent():
        await _editProfilePic();
        break;
      case EditProfileDetailsIntent():
        await _editProfileDetails();
        break;
    }
  }

  void _onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    picker = ImagePicker();
    editProfileKey = GlobalKey<FormState>();
    emit(
      state.copyWith(
        userData: FitnessMethodHelper.userData,
        selectedWeight: FitnessMethodHelper.userData?.weight,
        selectedGoal: FitnessMethodHelper.userData?.goal,
        selectedActivityLevel: FitnessMethodHelper.userData?.activityLevel,
      ),
    );
    firstNameController.text = state.userData?.firstName?.trim() ?? "";
    lastNameController.text = state.userData?.lastName?.trim() ?? "";
    emailController.text = state.userData?.email?.trim() ?? "";
  }

  void _editWeight({required int kg}) {
    emit(state.copyWith(selectedWeight: kg));
  }

  void _editGoal({required String goal}) {
    emit(state.copyWith(selectedGoal: goal));
  }

  void _editActivity({required String activity}) {
    emit(
      state.copyWith(
        selectedActivityLevel: FitnessMethodHelper.getCurrentActivityLevel(
          activityLevelTitle: activity,
        ),
      ),
    );
  }

  void _changeSection({required EditProfileSection section}) {
    emit(state.copyWith(currentSection: section));
  }

  Future<void> _editProfilePic() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(updatePhotoStatus: const StateStatus.loading()));
      final result = await _updateProfilePhotoUseCase.invoke(
        newPhoto: File(image.path),
      );
      if (isClosed) return;
      switch (result) {
        case Success<void>():
          emit(
            state.copyWith(
              updatePhotoStatus: const StateStatus.success(null),
              newSelectedImg: image.path,
            ),
          );
          emit(state.copyWith(updatePhotoStatus: const StateStatus.initial()));
          break;
        case Failure<void>():
          emit(
            state.copyWith(
              updatePhotoStatus: StateStatus.failure(result.responseException),
            ),
          );
          emit(state.copyWith(updatePhotoStatus: const StateStatus.initial()));
          break;
      }
    }
  }

  Future<void> _editProfileDetails() async {
    if (state.userData?.firstName == firstNameController.text.trim() &&
        state.userData?.lastName == lastNameController.text.trim() &&
        state.selectedWeight == FitnessMethodHelper.userData?.weight &&
        state.selectedGoal == FitnessMethodHelper.userData?.goal &&
        state.selectedActivityLevel ==
            FitnessMethodHelper.userData?.activityLevel) {
      emit(state.copyWith(isNoChanges: true));
    } else {
      if (editProfileKey.currentState!.validate()) {
        emit(
          state.copyWith(
            editProfileStatus: const StateStatus.loading(),
            autoValidateMode: AutovalidateMode.disabled,
          ),
        );
        final result = await _editProfileUseCase.invoke(
          request: EditProfileRequestEntity(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            weight: state.selectedWeight,
            activityLevel: state.selectedActivityLevel,
            goal: state.selectedGoal,
          ),
        );
        if (isClosed) return;
        switch (result) {
          case Success<void>():
            final newUserData = FitnessMethodHelper.userData?.copyWith(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              weight: state.selectedWeight,
              activityLevel: state.selectedActivityLevel,
              goal: state.selectedGoal,
            );
            emit(
              state.copyWith(
                editProfileStatus: StateStatus.success(newUserData),
                userData: newUserData,
              ),
            );
            break;
          case Failure<void>():
            emit(
              state.copyWith(
                editProfileStatus: StateStatus.failure(
                  result.responseException,
                ),
              ),
            );
            emit(
              state.copyWith(editProfileStatus: const StateStatus.initial()),
            );
            break;
        }
      } else {
        emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
      }
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    return super.close();
  }
}
