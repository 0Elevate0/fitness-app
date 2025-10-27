import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscle_group_model.g.dart';

@JsonSerializable()
class MuscleGroupModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  MuscleGroupModel({this.id, this.name});

  factory MuscleGroupModel.fromJson(Map<String, dynamic> json) {
    return _$MuscleGroupModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleGroupModelToJson(this);
  }

  MuscleGroupEntity toMuscleGroupEntity() {
    return MuscleGroupEntity(id: id, name: name);
  }
}
