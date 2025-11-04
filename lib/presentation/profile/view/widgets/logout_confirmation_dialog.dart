import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/core/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  Future<void> _logout(BuildContext context) async {
    final secureStorage = GetIt.instance<SecureStorage>();
    final sharedPrefs = GetIt.instance<SharedPreferencesHelper>();

    await secureStorage.deleteData(key: ConstKeys.tokenKey);
    await sharedPrefs.saveBool(
      key: ConstKeys.isOnboardingFinished,
      value: true,
    );

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.login,
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: theme.colorScheme.secondaryFixed.withValues(alpha: 0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are You Sure To Logout?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSecondary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    side: BorderSide(color: theme.colorScheme.primary, width: 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: theme.colorScheme.onSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: theme.colorScheme.onSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
