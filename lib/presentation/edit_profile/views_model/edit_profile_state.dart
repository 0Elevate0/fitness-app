import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:flutter/material.dart';

enum EditProfileSection { editProfile, editWeight, editGoal, editActivity }

final class EditProfileState extends Equatable {
  final StateStatus<void> updatePhotoStatus;
  final StateStatus<UserDataEntity?> editProfileStatus;
  final UserDataEntity? userData;
  final int? selectedWeight;
  final String? selectedGoal;
  final String? selectedActivityLevel;
  final AutovalidateMode autoValidateMode;
  final EditProfileSection currentSection;
  final bool? isNoChanges;
  final String? newSelectedImg;

  const EditProfileState({
    this.updatePhotoStatus = const StateStatus.initial(),
    this.editProfileStatus = const StateStatus.initial(),
    this.userData,
    this.selectedWeight,
    this.selectedGoal,
    this.selectedActivityLevel,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.currentSection = EditProfileSection.editProfile,
    this.isNoChanges,
    this.newSelectedImg,
  });
  EditProfileState copyWith({
    StateStatus<void>? updatePhotoStatus,
    StateStatus<UserDataEntity?>? editProfileStatus,
    UserDataEntity? userData,
    int? selectedWeight,
    String? selectedGoal,
    String? selectedActivityLevel,
    AutovalidateMode? autoValidateMode,
    EditProfileSection? currentSection,
    bool? isNoChanges,
    String? newSelectedImg,
  }) {
    return EditProfileState(
      updatePhotoStatus: updatePhotoStatus ?? this.updatePhotoStatus,
      editProfileStatus: editProfileStatus ?? this.editProfileStatus,
      userData: userData ?? this.userData,
      selectedWeight: selectedWeight ?? this.selectedWeight,
      selectedGoal: selectedGoal ?? this.selectedGoal,
      selectedActivityLevel:
          selectedActivityLevel ?? this.selectedActivityLevel,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      currentSection: currentSection ?? this.currentSection,
      isNoChanges: isNoChanges ?? this.isNoChanges,
      newSelectedImg: newSelectedImg ?? this.newSelectedImg,
    );
  }

  @override
  List<Object?> get props => [
    updatePhotoStatus,
    editProfileStatus,
    userData,
    selectedWeight,
    selectedGoal,
    selectedActivityLevel,
    autoValidateMode,
    currentSection,
    isNoChanges,
    newSelectedImg,
  ];
}
