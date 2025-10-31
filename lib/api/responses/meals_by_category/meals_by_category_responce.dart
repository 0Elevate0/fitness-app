import 'package:fitness_app/domain/entities/meal_by_category/meal_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'meals_by_category_responce.g.dart';

@JsonSerializable()
class MealsByCategory {
  @JsonKey(name: "meals")
  final List<Meals>? meals;

  MealsByCategory ({
    this.meals,
  });

  factory MealsByCategory.fromJson(Map<String, dynamic> json) {
    return _$MealsByCategoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsByCategoryToJson(this);
  }
}

@JsonSerializable()
class Meals {
  @JsonKey(name: "strMeal")
  final String? strMeal;
  @JsonKey(name: "strMealThumb")
  final String? strMealThumb;
  @JsonKey(name: "idMeal")
  final String? idMeal;

  Meals ({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  MealEntity toMealEntity(){
    return MealEntity(
    strMeal: strMeal,
    strMealThumb: strMealThumb,
    idMeal: idMeal,);
  }

  factory Meals.fromJson(Map<String, dynamic> json) {
    return _$MealsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsToJson(this);
  }
}


