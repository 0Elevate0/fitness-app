import 'package:fitness_app/api/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "user")
  final UserModel? user;

  LoginResponse({this.message, this.token, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseToJson(this);
  }
}
