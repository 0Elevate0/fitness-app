import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.black[0],
    fontFamily: "Baloo Thambi 2",
    colorScheme: ColorScheme.fromSeed(
      primary: AppColors.orange[0],
      onPrimary: AppColors.lightOrange[0],
      secondary: AppColors.black[0],
      secondaryFixed: AppColors.black[10],
      secondaryContainer: AppColors.black[20],
      onSecondary: AppColors.white,
      shadow: AppColors.gray[0],
      onSurface: AppColors.green,
      error: AppColors.orange[80],
      onSurfaceVariant: AppColors.gray[90],
      seedColor: Colors.deepPurple,
      outline: AppColors.gray[10],
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 44.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.orange[0],
      ),
      displayMedium: TextStyle(
        fontSize: 33.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.gray[0],
      ),
      displaySmall: TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.gray[0],
      ),
      headlineLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.gray[0],
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.gray[0],
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.lightOrange[0],
      selectionHandleColor: AppColors.lightOrange[0],
      selectionColor: AppColors.lightOrange[0]?.withValues(alpha: 0.2),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: AppColors.gray[0],
        disabledForegroundColor: AppColors.white,
      ),
    ),
  );
}
