import 'package:fitness_app/api/models/muscle/muscle_model.dart';
import 'package:fitness_app/api/models/muscle_group/muscle_group_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_muscles_by_muscle_group_response.g.dart';

@JsonSerializable()
class AllMusclesByMuscleGroupResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "muscleGroup")
  final MuscleGroupModel? muscleGroup;
  @JsonKey(name: "muscles")
  final List<MuscleModel>? muscles;

  AllMusclesByMuscleGroupResponse({
    this.message,
    this.muscleGroup,
    this.muscles,
  });

  factory AllMusclesByMuscleGroupResponse.fromJson(Map<String, dynamic> json) {
    return _$AllMusclesByMuscleGroupResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllMusclesByMuscleGroupResponseToJson(this);
  }
}
