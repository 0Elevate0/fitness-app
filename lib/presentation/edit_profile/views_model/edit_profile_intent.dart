import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';

sealed class EditProfileIntent {
  const EditProfileIntent();
}

final class EditProfileInitializationIntent extends EditProfileIntent {
  const EditProfileInitializationIntent();
}

final class EditWeightIntent extends EditProfileIntent {
  final int newSelectedWeight;
  const EditWeightIntent({required this.newSelectedWeight});
}

final class EditGoalIntent extends EditProfileIntent {
  final String goal;
  const EditGoalIntent({required this.goal});
}

final class EditActivityIntent extends EditProfileIntent {
  final String activity;
  const EditActivityIntent({required this.activity});
}

final class ChangeEditProfileSectionIntent extends EditProfileIntent {
  final EditProfileSection section;
  const ChangeEditProfileSectionIntent({required this.section});
}

final class EditProfilePicIntent extends EditProfileIntent {
  const EditProfilePicIntent();
}

final class EditProfileDetailsIntent extends EditProfileIntent {
  const EditProfileDetailsIntent();
}
