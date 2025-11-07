import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_selection_item.dart';
import 'package:fitness_app/presentation/profile/views/widgets/select_language_item.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/dialogs/dialogs.dart';
import 'package:fitness_app/utils/dialogs/logout_dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileItemsList extends StatelessWidget {
  const ProfileItemsList({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    return BlurredContainer(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(20.r),
      halfTheBlurValue: 10,
      blurColor: theme.colorScheme.secondary.withValues(alpha: 0.8),
      child: Column(
        spacing: 16.r,
        children: [
          RPadding(
            padding: const EdgeInsets.only(top: 8),
            child: ProfileSelectionItem(
              prefixIcon: AppIcons.editProfile,
              title: AppText.editProfile,
              onTap: () => Navigator.of(
                context,
              ).pushNamed(RouteNames.editProfile, arguments: profileCubit),
            ),
          ),
          ProfileSelectionItem(
            prefixIcon: AppIcons.changePassword,
            title: AppText.changePassword,
            onTap: () => Navigator.of(
              context,
            ).pushNamed(RouteNames.profileResetPassword),
          ),
          const SelectLanguageItem(),
          ProfileSelectionItem(
            prefixIcon: AppIcons.security,
            title: AppText.security,
            onTap: () => Navigator.of(context).pushNamed(RouteNames.security),
          ),
          ProfileSelectionItem(
            prefixIcon: AppIcons.privacyPolicy,
            title: AppText.privacyPolicy,
            onTap: () =>
                Navigator.of(context).pushNamed(RouteNames.privacyPolicy),
          ),
          ProfileSelectionItem(
            prefixIcon: AppIcons.help,
            title: AppText.help,
            onTap: () => Navigator.of(context).pushNamed(RouteNames.help),
          ),
          ProfileSelectionItem(
            prefixIcon: AppIcons.logout,
            title: AppText.logout,
            titleColor: theme.colorScheme.primary,
            isLastItem: true,
            onTap: () async => await Dialogs.customDialog(
              isBarrierDismissible: false,
              context: context,
              backgroundColor: theme.colorScheme.secondary.withValues(
                alpha: 0.5,
              ),
              insetPadding: REdgeInsets.symmetric(horizontal: 16),
              content: BlocProvider<ProfileCubit>.value(
                value: profileCubit,
                child: const LogoutDialogContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
