import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_cubit.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_intent.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/play_video_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodDescriptionSection extends StatelessWidget {
  const FoodDescriptionSection({super.key, required this.mealData});
  final MealDetailsEntity? mealData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foodDetailsCubit = BlocProvider.of<FoodDetailsCubit>(context);
    return SliverToBoxAdapter(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        child: RSizedBox(
          height: 344,
          width: ScreenUtil().screenWidth,
          child: Stack(
            fit: StackFit.expand,
            children: [
              mealData?.mealMealThumb != null
                  ? CachedNetworkImage(
                      imageUrl: mealData?.mealMealThumb ?? "",
                      fit: BoxFit.cover,
                    )
                  : Image.asset(AppImages.foodNotFound, fit: BoxFit.cover),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  color: theme.colorScheme.secondaryFixed.withValues(alpha: 0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.secondaryFixed.withValues(alpha: 0),
                      theme.colorScheme.secondary,
                    ],
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: RPadding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          automaticallyImplyLeading: true,
                          padding: EdgeInsets.zero,
                          actionWidget: PlayVideoButton(
                            onPressed: () => foodDetailsCubit.doIntent(
                              intent: OpenYoutubeVideoIntent(
                                youtubeUrl: mealData?.mealYoutube ?? "",
                              ),
                            ),
                          ),
                        ),
                        const RSizedBox(height: 16),
                        Text(
                          mealData?.mealTitle ?? AppText.notProvided.tr(),
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const RSizedBox(height: 4),
                        Flexible(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              mealData?.mealInstructions ??
                                  AppText.notProvided.tr(),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
