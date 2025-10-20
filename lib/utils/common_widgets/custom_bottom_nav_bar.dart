import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<Map<String, dynamic>> _navItems = [
  {'icon': Icons.home_rounded, 'title': 'Explore'},
  {'icon': Icons.location_on_outlined, 'title': 'Location'},
  {'icon': Icons.fitness_center_outlined, 'title': 'Workout'},
  {'icon': Icons.person_outline, 'title': 'Profile'},
];

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print('Tapped index: $index');
  }

  @override
  Widget build(BuildContext context) {
    final double navHeight = 90.h;
    final Color activeColor = Colors.deepOrange;

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
          children: List.generate(_navItems.length, (index) {
            final bool isSelected = index == _selectedIndex;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _navItems[index]['icon'] as IconData,
                      size: 28.r,
                      color: isSelected ? activeColor : Colors.white,
                    ),
                    if (isSelected)
                      SizedBox(height: 4.h),
                    if (isSelected)
                      Text(
                        _navItems[index]['title'] as String,
                        style: TextStyle(
                          color: activeColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

