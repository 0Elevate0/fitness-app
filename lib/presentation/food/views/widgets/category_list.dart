import 'package:fitness_app/presentation/food/views/widgets/category_group_item.dart';
import 'package:fitness_app/presentation/food/views_model/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_model/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodState>(
      builder: (context, state) {
        final selected =
            state.selectedCategory ?? state.mealsArgument?.selectedCategory;
        final categories = state.mealsArgument?.categories ?? [];
        return RPadding(
          padding: const EdgeInsets.only(left: 16),
          child: RSizedBox(
            height: 34,
            child: ListView.separated(
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              controller: ScrollController(
                initialScrollOffset: selected != null
                    ? (state.mealsArgument?.categories?.indexWhere(
                                (mg) => mg.idCategory == selected.idCategory,
                              ) ??
                              0) *
                          55.w
                    : 0,
              ),
              itemBuilder: (_, index) {
                return CategoryGroupItem(
                  mealCategoryData: categories[index],
                  isSelected:
                      selected?.idCategory == categories[index].idCategory,
                );
              },
              separatorBuilder: (_, __) => const RSizedBox(width: 8),
            ),
          ),
        );
      },
    );
  }
}
