import 'package:fitness_app/domain/entities/meal_details/ingredient_measure_entity.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_details_model.g.dart';

@JsonSerializable()
class MealDetailsModel {
  @JsonKey(name: "idMeal")
  final String? idMeal;
  @JsonKey(name: "strMeal")
  final String? strMeal;
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

  final Map<String, dynamic> extraFields;

  MealDetailsModel({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strSource,
    required this.extraFields,
  });

  factory MealDetailsModel.fromJson(Map<String, dynamic> json) {
    return MealDetailsModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      strSource: json['strSource'],
      extraFields: Map.from(json),
    );
  }

  Map<String, dynamic> toJson() => _$MealDetailsModelToJson(this);

  MealDetailsEntity toMealDetailsEntity() {
    final List<IngredientMeasureEntity> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = extraFields["strIngredient$i"];
      final measure = extraFields["strMeasure$i"];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add(
          IngredientMeasureEntity(
            ingredient: ingredient.toString(),
            measure: measure?.toString() ?? '',
          ),
        );
      }
    }

    return MealDetailsEntity(
      idMeal: idMeal,
      strMeal: strMeal,
      strCategory: strCategory,
      strArea: strArea,
      strInstructions: strInstructions,
      strMealThumb: strMealThumb,
      strTags: strTags,
      strYoutube: strYoutube,
      strSource: strSource,
      ingredients: ingredients,
    );
  }
}
