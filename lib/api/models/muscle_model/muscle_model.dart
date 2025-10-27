import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscle_model.g.dart';

@JsonSerializable()
class MuscleModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;

  MuscleModel({this.id, this.name, this.image});

  factory MuscleModel.fromJson(Map<String, dynamic> json) {
    return _$MuscleModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleModelToJson(this);
  }

  MuscleEntity toMuscleEntity() {
    return MuscleEntity(id: id, name: name, image: image);
  }
}
