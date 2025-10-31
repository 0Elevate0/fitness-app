import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/presentation/food/views/widgets/food_view_body.dart';
import 'package:fitness_app/presentation/food/views_models/food_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodView extends StatelessWidget {
   final List<MealCategoryEntity>? mealCategories;
  const FoodView({super.key,  required this.mealCategories});

  @override
  Widget build(BuildContext context) {
  final  ThemeData themeData = Theme.of(context);
    return  BlocProvider(
  create: (context) =>
      getIt.get<FoodCubit>(),
  child: Container(height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.foodbackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon:  SvgPicture.asset(
                AppIcons.back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            title:  Text(AppText.foodRecommendation.tr(),style: themeData.textTheme.headlineLarge,),
          ),
          backgroundColor: Colors.transparent,
          body: DefaultTabController(length: mealCategories?.length??0, child:Column(
            children: [
              TabBar(isScrollable: true,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: themeData.colorScheme.primary,
                  ),
                  indicatorColor: themeData.colorScheme.primary,
                  labelStyle: themeData.textTheme.bodyLarge,
                  unselectedLabelStyle:themeData.textTheme.bodyLarge ,
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  tabs: mealCategories?.map((category)=>Tab(
                    text: category.strCategory,
                  )).toList()??[]),
              const SizedBox(height: 15,),
              Expanded(
                child: TabBarView(children:mealCategories?.map((category)=>FoodViewBody(
                  mealCategory: category,
                )).toList()??[]

                ),
              )
            ],

          )
          ),

        ),
      ),
);
  }
}