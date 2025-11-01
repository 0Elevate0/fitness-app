import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';

final class MealsArgument extends Equatable {
  final List<MealCategoryEntity>? categories;
  final MealCategoryEntity? selectedCategory;

  const MealsArgument({this.selectedCategory, this.categories});

  @override
  List<Object?> get props => [selectedCategory, categories];

  MealsArgument? copyWith({
    MealCategoryEntity? selectedCategory,
    List<MealCategoryEntity>? categories,
  }) {
    return MealsArgument(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
    );
  }
}
