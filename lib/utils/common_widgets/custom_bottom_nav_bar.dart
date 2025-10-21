import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_intent.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FitnessBottomNavigationBar extends StatelessWidget {
  const FitnessBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FitnessBottomNavigationCubit>();

    final icons = [
      AppIcons.homeIcon,
      AppIcons.chatIcon,
      AppIcons.gymIcon,
      AppIcons.profileIcon,
    ];

    final titles = ["Explore", "Chat Ai", "Workout", "Profile"];
    final theme = Theme.of(context);

    return BlocBuilder<FitnessBottomNavigationCubit, dynamic>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              final isSelected = state.selectedIndex == index;
              return GestureDetector(
                onTap: () => cubit.onIntent(FitnessBottomNavigationIntent(index)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      icons[index],
                      width: isSelected ? 34 : 26,
                      height: isSelected ? 34 : 26,
                      colorFilter: ColorFilter.mode(
                        isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.shadow,
                        BlendMode.srcIn,
                      ),
                    ),
                    if (isSelected)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          titles[index],
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
