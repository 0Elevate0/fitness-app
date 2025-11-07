import 'dart:io';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';

abstract interface class EditProfileRemoteDataSource {
  Future<Result<void>> updateProfilePhoto({required File newPhoto});
  Future<Result<void>> editProfile({required EditProfileRequestEntity request});
}
