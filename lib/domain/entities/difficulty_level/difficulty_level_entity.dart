import 'package:equatable/equatable.dart';

class DifficultyLevelEntity extends Equatable {
  final String? id;
  final String? name;

  const DifficultyLevelEntity({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
