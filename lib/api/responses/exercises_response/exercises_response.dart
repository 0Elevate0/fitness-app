import 'package:fitness_app/api/models/exercise/exercise_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercises_response.g.dart';

@JsonSerializable()
class ExercisesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalExercises")
  final int? totalExercises;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "exercises")
  final List<ExercisesModel>? exercises;

  ExercisesResponse ({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory ExercisesResponse.fromJson(Map<String, dynamic> json) {
    return _$ExercisesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExercisesResponseToJson(this);
  }
}


