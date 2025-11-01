import 'package:fitness_app/core/constants/app_animations.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingFoodDetails extends StatelessWidget {
  const LoadingFoodDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          const RSizedBox(height: 16),
          const CustomAppBar(automaticallyImplyLeading: true),
          Expanded(
            child: RPadding(
              padding: const EdgeInsets.only(bottom: 62),
              child: AnimationLoaderWidget(
                text: AppText.loading,
                animation: AppAnimations.foodLoadingAnimation,
                style: theme.textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
