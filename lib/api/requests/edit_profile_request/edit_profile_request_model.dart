import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request_model.g.dart';

@JsonSerializable()
class EditProfileRequestModel {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "weight")
  final int? weight;
  @JsonKey(name: "goal")
  final String? goal;
  @JsonKey(name: "activityLevel")
  final String? activityLevel;

  EditProfileRequestModel({
    this.firstName,
    this.lastName,
    this.weight,
    this.goal,
    this.activityLevel,
  });

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return _$EditProfileRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditProfileRequestModelToJson(this);
  }
}
