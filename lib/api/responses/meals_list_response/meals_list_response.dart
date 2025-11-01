import 'package:fitness_app/api/models/meals/meals_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meals_list_response.g.dart';

@JsonSerializable()
class MealsListResponse {
  @JsonKey(name: "meals")
  final List<MealsModel>? meals;

  MealsListResponse({this.meals});

  factory MealsListResponse.fromJson(Map<String, dynamic> json) {
    return _$MealsListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsListResponseToJson(this);
  }
}
