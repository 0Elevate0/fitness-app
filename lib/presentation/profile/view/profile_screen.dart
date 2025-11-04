import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/presentation/profile/view/widgets/etting_sItem.dart';
import 'package:fitness_app/presentation/profile/view/widgets/logout_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery
        .of(context)
        .size
        .height;
    final sw = MediaQuery
        .of(context)
        .size
        .width;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.secondary,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: sw * 0.05, vertical: sh * 0.02),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondaryContainer.withValues(
                  alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                buildSettingsItem(
                  icon: AppIcons.logout,
                  text: 'Logout',
                  textColor: theme.colorScheme.onPrimary,
                  theme: theme,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const LogoutConfirmationDialog(
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }}