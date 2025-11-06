import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/build_profile_reset_password_form.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/create_new_password_section.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/profile_reset_password_app_bar.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/loading_dialog.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileResetPasswordBody extends StatelessWidget {
  const ProfileResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ProfileResetPasswordCubit, ProfileResetPasswordState>(
      listener: (context, state) {
        switch (state.profileResetPasswordState.status) {
          case Status.initial:
            break;
          case Status.loading:
            showLoadingDialog(context, color: theme.colorScheme.primary);
            break;
          case Status.success:
            Navigator.pop(context);
            Navigator.pop(context);
            Loaders.showSuccessMessage(
              message: AppText.passwordChanged,
              context: context,
            );
            break;
          case Status.failure:
            Navigator.pop(context);
            Loaders.showErrorMessage(
              message:
                  state.profileResetPasswordState.error?.message ??
                  AppText.error,
              context: context,
            );
            break;
        }
      },
      child: BlurredLayerView(
        child: SafeArea(
          child: SingleChildScrollView(
            child:
                BlocBuilder<
                  ProfileResetPasswordCubit,
                  ProfileResetPasswordState
                >(
                  builder: (context, state) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RSizedBox(height: 45),
                        ProfileResetPasswordAppBar(),
                        RSizedBox(height: 30),
                        RPadding(
                          padding: EdgeInsets.all(16),
                          child: CreateNewPasswordSection(),
                        ),
                        BuildProfileResetPasswordForm(),
                      ],
                    );
                  },
                ),
          ),
        ),
      ),
    );
  }
}
