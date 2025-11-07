import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:fitness_app/domain/repositories/edit_profile/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final EditProfileRepository _editProfileRepository;

  const EditProfileUseCase(this._editProfileRepository);

  Future<Result<void>> invoke({
    required EditProfileRequestEntity request,
  }) async {
    return await _editProfileRepository.editProfile(request: request);
  }
}
