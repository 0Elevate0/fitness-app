import 'package:fitness_app/presentation/home/views/widgets/popular_training_item.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularTrainingList extends StatelessWidget {
  const PopularTrainingList({super.key});

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      height: 176,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => PopularTrainingItem(
          popularTrainingData: FitnessMethodHelper.popularTraining[index],
        ),
        separatorBuilder: (_, _) => const RSizedBox(width: 16),
        itemCount: FitnessMethodHelper.popularTraining.length,
      ),
    );
  }
}
