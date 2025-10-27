import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_details_model.g.dart';

@JsonSerializable()
class MealDetailsModel {
  @JsonKey(name: "idMeal")
  final String? idMeal;
  @JsonKey(name: "strMeal")
  final String? strMeal;
  @JsonKey(name: "strMealAlternate")
  final String? strMealAlternate;
  @JsonKey(name: "strCategory")
  final String? strCategory;
  @JsonKey(name: "strArea")
  final String? strArea;
  @JsonKey(name: "strInstructions")
  final String? strInstructions;
  @JsonKey(name: "strMealThumb")
  final String? strMealThumb;
  @JsonKey(name: "strTags")
  final String? strTags;
  @JsonKey(name: "strYoutube")
  final String? strYoutube;
  @JsonKey(name: "strSource")
  final String? strSource;
  @JsonKey(name: "strIngredient1")
  final String? strIngredient1;
  @JsonKey(name: "strIngredient2")
  final String? strIngredient2;
  @JsonKey(name: "strIngredient20")
  final String? strIngredient20;
  @JsonKey(name: "strMeasure1")
  final String? strMeasure1;
  @JsonKey(name: "strMeasure2")
  final String? strMeasure2;
  @JsonKey(name: "strMeasure20")
  final String? strMeasure20;
  MealDetailsModel({
    this.idMeal,
    this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strSource,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient20,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure20,
  });
  factory MealDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$MealDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealDetailsModelToJson(this);
  }
  MealDetailsEntity toMealDetailsEntity() {
    final List<Map<String, String?>> ingredients = [];

    return MealDetailsEntity(
      idMeal: idMeal,
      strMeal: strMeal,
      strInstructions: strInstructions,
      strMealThumb: strMealThumb,
    );
  }
}

