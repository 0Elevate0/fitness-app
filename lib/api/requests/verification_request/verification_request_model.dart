import 'package:json_annotation/json_annotation.dart';

part 'verification_request_model.g.dart';

@JsonSerializable()
class VerificationRequestModel {
  @JsonKey(name: "resetCode")
  final String? resetCode;

  VerificationRequestModel ({
    this.resetCode,
  });

  factory VerificationRequestModel.fromJson(Map<String, dynamic> json) {
    return _$VerificationRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerificationRequestModelToJson(this);
  }
}


