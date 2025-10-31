import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'difficulty_levels_model.g.dart';

@JsonSerializable()
class DifficultyLevelsModel {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  DifficultyLevelsModel({this.id, this.name});

  factory DifficultyLevelsModel.fromJson(Map<String, dynamic> json) {
    return _$DifficultyLevelsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DifficultyLevelsModelToJson(this);
  }

  DifficultyLevelEntity toDifficultyLevelEntity() {
    return DifficultyLevelEntity(id: id, name: name);
  }
}
