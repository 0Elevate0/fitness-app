import 'package:equatable/equatable.dart';

class MealEntity extends Equatable {
  final String? id;
  final String? name;
  final String? thumbnail;

  const MealEntity({this.id, this.name, this.thumbnail});

  @override
  List<Object?> get props => [id, name, thumbnail];
}
