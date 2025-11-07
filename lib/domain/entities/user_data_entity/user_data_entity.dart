import 'package:equatable/equatable.dart';

final class UserDataEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;
  final String? activityLevel;
  final String? goal;
  final String? photo;

  const UserDataEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.photo,
  });

  UserDataEntity copyWith({
    String? firstName,
    String? lastName,
    String? photo,
    int? weight,
    String? activityLevel,
    String? goal,
  }) {
    return UserDataEntity(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email,
      gender: gender,
      age: age,
      weight: weight ?? this.weight,
      height: height,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      photo: photo ?? this.photo,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    gender,
    age,
    weight,
    height,
    activityLevel,
    goal,
    photo,
  ];
}
