import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/food/food_details/view/widgets/nutrient_circle.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_cubit.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_state.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FoodDetailsViewBody extends StatelessWidget {
  const FoodDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<FoodDetailsCubit, FoodDetailsState>(
      listenWhen: (previous, current) => current.mealDetailsStatus.isFailure,
      listener: (context, state) {
        if (state.mealDetailsStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.mealDetailsStatus.error?.message ?? AppText.unknownErrorMessage.tr(),
            context: context,
          );
        }
      },
      child: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
        builder: (context, state) {
          if (state.mealDetailsStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.mealDetailsStatus.isSuccess) {
            final meal = state.mealDetailsStatus.data!;

            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.homeBackground),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: theme.colorScheme.surface.withOpacity(0.5),
                    ),
                  ),
                ),

                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.r),
                                bottomRight: Radius.circular(20.r),
                              ),
                              child: Image.network(
                                meal.strMealThumb ?? '',
                                height: 380.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 380.h,
                                  color: theme.colorScheme.onSecondary.withOpacity(0.8),
                                  alignment: Alignment.center,
                                  child: Icon(Icons.error, color: theme.colorScheme.onSecondary),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      theme.colorScheme.secondaryContainer.withOpacity(0.1),
                                      theme.colorScheme.secondaryContainer.withOpacity(0.3),
                                      theme.colorScheme.secondaryContainer.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SafeArea(
                              child: Padding(
                                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        width: 30.r,
                                        height: 30.r,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: theme.colorScheme.primary,
                                          border: Border.all(
                                            color: theme.colorScheme.onSurface.withOpacity(0.3),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppIcons.back,
                                            width: 14,
                                            height: 14,
                                            colorFilter: ColorFilter.mode(theme.colorScheme.onSecondary, BlendMode.srcIn),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 16,
                              right: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal.strMeal ?? AppText.mealNotFound.tr(),
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSecondary,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    meal.strInstructions?.split('.').first ?? AppText.noDescription.tr(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: theme.colorScheme.shadow,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      NutrientCircle(value: "100 K", label: AppText.energy),
                                      NutrientCircle(value: "15 G", label: AppText.protein),
                                      NutrientCircle(value: "58 G", label: AppText.carbs),
                                      NutrientCircle(value: "20 G", label: AppText.fat),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppText.ingredients.tr(),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSecondary,
                                ),
                              ),
                              SizedBox(height: 14.h),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                  child: Container(
                                    width: double.infinity,
                                    padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                    color: theme.colorScheme.outlineVariant.withOpacity(0.8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: meal.ingredients.map(
                                            (item) => Padding(
                                          padding: REdgeInsets.symmetric(vertical: 8),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    item.ingredient,
                                                    style: TextStyle(color: theme.colorScheme.onSecondary, fontSize: 16.sp),
                                                  ),
                                                  Text(
                                                    item.measure,
                                                    style: TextStyle(
                                                      color: theme.colorScheme.primary,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (item != meal.ingredients.last)
                                                Divider(color: theme.colorScheme.shadow.withOpacity(0.08), height: 1.h),
                                            ],
                                          ),
                                        ),
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 30.h),
                              Text(
                                AppText.recommendation.tr(),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSecondary,
                                ),
                              ),
                              SizedBox(height: 14.h),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 16.h,
                                  childAspectRatio: 0.8,
                                ),
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                        "https://www.themealdb.com/images/media/meals/llcbn01574260722.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.r),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                theme.colorScheme.secondary.withOpacity(0.8),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Text(
                                          "Pasta With Chicks",
                                          style: TextStyle(
                                            color: theme.colorScheme.onSecondary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 40.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(
            child: Text(AppText.loadingMealDetails.tr(), style: TextStyle(color: theme.colorScheme.onSurface)),
          );
        },
      ),
    );
  }
}