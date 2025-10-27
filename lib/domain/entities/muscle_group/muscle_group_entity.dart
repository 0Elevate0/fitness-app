import 'package:equatable/equatable.dart';

final class MuscleGroupEntity extends Equatable {
  final String? id;
  final String? name;

  const MuscleGroupEntity({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
