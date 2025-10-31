import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meals_model.g.dart';

@JsonSerializable()
class MealsModel {
  @JsonKey(name: "strMeal")
  final String? strMeal;
  @JsonKey(name: "strMealThumb")
  final String? strMealThumb;
  @JsonKey(name: "idMeal")
  final String? idMeal;

  MealsModel({this.strMeal, this.strMealThumb, this.idMeal});

  factory MealsModel.fromJson(Map<String, dynamic> json) {
    return _$MealsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsModelToJson(this);
  }

  MealEntity toMealEntity() {
    return MealEntity(id: idMeal, name: strMeal, thumbnail: strMealThumb);
  }
}
