import 'package:fitness_app/presentation/food/views/widgets/category_list.dart';
import 'package:fitness_app/presentation/food/views/widgets/meals_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodViewBody extends StatelessWidget {
  const FoodViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CategoryList(),
        RSizedBox(height: 24),
        Expanded(child: MealsList()),
      ],
    );
  }
}
