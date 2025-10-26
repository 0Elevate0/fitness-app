import 'package:fitness_app/api/models/recommendation_muscle/muscle_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscles_recommendation_response.g.dart';

@JsonSerializable()
class MusclesRecommendationResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalMuscles")
  final int? totalMuscles;
  @JsonKey(name: "muscles")
  final List<MuscleModel>? muscles;

  MusclesRecommendationResponse({
    this.message,
    this.totalMuscles,
    this.muscles,
  });

  factory MusclesRecommendationResponse.fromJson(Map<String, dynamic> json) {
    return _$MusclesRecommendationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesRecommendationResponseToJson(this);
  }
}
