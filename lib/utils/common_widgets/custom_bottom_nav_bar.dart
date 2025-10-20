import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app/core/constants/app_colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final int selectedIndex;
  final void Function(int index) onItemTapped;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final List<IconData> _icons = [
    Icons.home_rounded,
    Icons.chat_bubble_outline_rounded,
    Icons.fitness_center_rounded,
    Icons.person_rounded,
  ];

  final List<String> _titles = [
    'Explore',
    'Chat Ai',
    'Workout',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    final double navHeight = 80.h;
    final Color activeColor = AppColors.orange;
    final Color? inactiveColor = AppColors.gray[20];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Container(
        height: navHeight,
        decoration: BoxDecoration(
          color: AppColors.gray[100],
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            final bool isSelected = index == widget.selectedIndex;
            return GestureDetector(
              onTap: () => widget.onItemTapped(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _icons[index],
                    size: isSelected ? 30.r : 24.r,
                    color: isSelected ? activeColor : inactiveColor,
                  ),
                  if (isSelected) ...[
                    Text(
                      _titles[index],
                      style: TextStyle(
                        color: activeColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
