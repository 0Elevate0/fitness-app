import 'package:equatable/equatable.dart';

final class MuscleEntity extends Equatable {
  final String? id;
  final String? name;
  final String? image;

  const MuscleEntity({this.id, this.name, this.image});

  @override
  List<Object?> get props => [id, name, image];
}
