import 'package:fitness_app/api/models/meal_category/meal_category_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meals_categories_response.g.dart';

@JsonSerializable()
class MealsCategoriesResponse {
  @JsonKey(name: "categories")
  final List<MealCategoryModel>? categories;

  MealsCategoriesResponse({this.categories});

  factory MealsCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$MealsCategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsCategoriesResponseToJson(this);
  }
}
