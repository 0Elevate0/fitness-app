import 'package:fitness_app/api/models/meal_details/meal_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_details_response.g.dart';

@JsonSerializable()
class MealDetailsResponse {
  @JsonKey(name: "meals")
  final List<MealDetailsModel>? meals;

  MealDetailsResponse({this.meals});

  factory MealDetailsResponse.fromJson(Map<String, dynamic> json) {
    return _$MealDetailsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealDetailsResponseToJson(this);
  }
}
