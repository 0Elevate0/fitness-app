import 'package:fitness_app/api/models/muscle_group/muscle_group_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_muscles_group_response.g.dart';

@JsonSerializable()
class AllMusclesGroupResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "musclesGroup")
  final List<MuscleGroupModel>? musclesGroup;

  AllMusclesGroupResponse({this.message, this.musclesGroup});

  factory AllMusclesGroupResponse.fromJson(Map<String, dynamic> json) {
    return _$AllMusclesGroupResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllMusclesGroupResponseToJson(this);
  }
}
