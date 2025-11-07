import 'dart:io';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/edit_profile/remote_data_source/edit_profile_remote_data_source.dart';
import 'package:fitness_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:fitness_app/domain/repositories/edit_profile/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepository)
final class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDataSource _editProfileRemoteDataSource;
  const EditProfileRepositoryImpl(this._editProfileRemoteDataSource);

  @override
  Future<Result<void>> updateProfilePhoto({required File newPhoto}) async {
    return await _editProfileRemoteDataSource.updateProfilePhoto(
      newPhoto: newPhoto,
    );
  }

  @override
  Future<Result<void>> editProfile({
    required EditProfileRequestEntity request,
  }) async {
    return await _editProfileRemoteDataSource.editProfile(request: request);
  }
}
