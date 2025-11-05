import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealErrorContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return Container(
    color: AppColors.gray, // A clear indication of failure
    child: Center(
      child: Icon(
        Icons.broken_image,
        color: Colors.white,
        size: 40.sp,
      ),
    ),
  );
  }

}