import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/presentation/food/views/widgets/meal_container.dart';
import 'package:fitness_app/presentation/food/views/widgets/meals_list_shimmer.dart';
import 'package:fitness_app/presentation/food/views_models/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_models/food_intent.dart';
import 'package:fitness_app/presentation/food/views_models/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodViewBody extends StatefulWidget {
   final MealCategoryEntity? mealCategory;
  const FoodViewBody({super.key, required this.mealCategory});

  @override
  State<FoodViewBody> createState() => _FoodViewBodyState();
}

class _FoodViewBodyState extends State<FoodViewBody> {
  @override
  void initState() {
    BlocProvider.of<FoodCubit>(context).doIntent(intent: ChangeMealByCategory(categoryName:widget.mealCategory?.strCategory??""));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit,FoodState>(
  builder: (context, state) {
    if(state.mealsByCategoryStatus.isSuccess)
   { return Padding(
     padding:  REdgeInsets.all(16),
     child: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
      crossAxisSpacing: 17,mainAxisSpacing: 17,
      childAspectRatio: 0.9) , itemCount:state.mealsByCategoryStatus.data?.length??0,
          itemBuilder:(buildContext,index)=> MealContainer(
              mealType:state.mealsByCategoryStatus.data?[index].strMeal??"",
              mealPhotoUrl:state.mealsByCategoryStatus.data?[index].strMealThumb??"")),
   );
  }
    else if(state.mealsByCategoryStatus.isFailure){
      return Center(
        child: Text(state.mealsByCategoryStatus.error?.message??AppText.nodata.tr()));

    }
    return const MealsListShimmer();

  }
);
  }
}