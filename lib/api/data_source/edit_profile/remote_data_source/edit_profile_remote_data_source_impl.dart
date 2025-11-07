import 'dart:io';

import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/data/data_source/edit_profile/remote_data_source/edit_profile_remote_data_source.dart';
import 'package:fitness_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final ApiClient _apiClient;
  const EditProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<void>> updateProfilePhoto({required File newPhoto}) async {
    return executeApi(() async {
      await _apiClient.updatePhoto(
        token: "Bearer ${FitnessMethodHelper.currentUserToken}",
        newPhoto: newPhoto,
      );
    });
  }

  @override
  Future<Result<void>> editProfile({
    required EditProfileRequestEntity request,
  }) async {
    return executeApi(() async {
      await _apiClient.editProfile(
        token: "Bearer ${FitnessMethodHelper.currentUserToken}",
        request: RequestMapper.toEditProfileRequestModel(request: request),
      );
    });
  }
}
