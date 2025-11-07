import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_profile_view_body.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.profileCubit});
  final ProfileCubit profileCubit;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditProfileCubit>(
          create: (context) =>
              getIt.get<EditProfileCubit>()
                ..doIntent(intent: const EditProfileInitializationIntent()),
        ),
        BlocProvider<ProfileCubit>.value(value: profileCubit),
      ],
      child: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                state.currentSection == EditProfileSection.editProfile
                    ? AppImages.profileBackground
                    : AppImages.authBackground,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: const Scaffold(
            backgroundColor: Colors.transparent,
            body: EditProfileViewBody(),
          ),
        ),
      ),
    );
  }
}
