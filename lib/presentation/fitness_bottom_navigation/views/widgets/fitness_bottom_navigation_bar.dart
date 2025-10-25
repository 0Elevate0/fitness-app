import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_intent.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FitnessBottomNavigationBar extends StatelessWidget {
  const FitnessBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fitnessBottomNavCubit = BlocProvider.of<FitnessBottomNavigationCubit>(
      context,
    );
    return BlocBuilder<
      FitnessBottomNavigationCubit,
      FitnessBottomNavigationState
    >(
      builder: (context, state) => Container(
        height: 71.h,
        margin: REdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: theme.colorScheme.secondary.withValues(alpha: 0.8),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
              blurStyle: BlurStyle.outer,
              blurRadius: 6.r,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: BottomNavigationBar(
            selectedItemColor: theme.colorScheme.primary,
            onTap: (value) => fitnessBottomNavCubit.doIntent(
              intent: ChangeIndexIntent(index: value),
            ),
            currentIndex: state.currentIndex,
            showUnselectedLabels: false,
            backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.8),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.home,
                  width: 24.r,
                  height: 24.r,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.shadow,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.home,
                  width: 24.r,
                  height: 24.r,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppText.explore.tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.chat,
                  width: 24.r,
                  height: 24.r,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.shadow,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.chat,
                  width: 24.r,
                  height: 24.r,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppText.chat.tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.gym,
                  width: 24.r,
                  height: 24.r,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.shadow,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.gym,
                  width: 24.r,
                  height: 24.r,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppText.workouts.tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.profile,
                  width: 24.r,
                  height: 24.r,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.shadow,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.profile,
                  width: 24.r,
                  height: 24.r,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppText.profile.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
