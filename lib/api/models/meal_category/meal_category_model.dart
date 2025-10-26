import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_category_model.g.dart';

@JsonSerializable()
class MealCategoryModel {
  @JsonKey(name: "idCategory")
  final String? idCategory;
  @JsonKey(name: "strCategory")
  final String? strCategory;
  @JsonKey(name: "strCategoryThumb")
  final String? strCategoryThumb;
  @JsonKey(name: "strCategoryDescription")
  final String? strCategoryDescription;

  MealCategoryModel({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory MealCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$MealCategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealCategoryModelToJson(this);
  }

  MealCategoryEntity toMealCategoryEntity() {
    return MealCategoryEntity(
      idCategory: idCategory,
      strCategory: strCategory,
      strCategoryDescription: strCategoryDescription,
      strCategoryThumb: strCategoryThumb,
    );
  }
}
