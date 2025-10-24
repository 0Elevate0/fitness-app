import 'package:json_annotation/json_annotation.dart';

part 'verification_response.g.dart';

@JsonSerializable()
class VerificationResponse {
  @JsonKey(name: "status")
  final String? status;

  VerificationResponse ({
    this.status,
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) {
    return _$VerificationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerificationResponseToJson(this);
  }
}


