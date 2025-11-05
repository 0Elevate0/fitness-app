import 'package:fitness_app/presentation/profile/views_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  // Future<void> doIntent({required ProfileIntent intent}) async {
  //   switch (intent) {
  //
  //   }
  // }
}
