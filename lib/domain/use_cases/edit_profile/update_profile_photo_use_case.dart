import 'dart:io';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/repositories/edit_profile/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfilePhotoUseCase {
  final EditProfileRepository _editProfileRepository;

  const UpdateProfilePhotoUseCase(this._editProfileRepository);

  Future<Result<void>> invoke({required File newPhoto}) async {
    return await _editProfileRepository.updateProfilePhoto(newPhoto: newPhoto);
  }
}
