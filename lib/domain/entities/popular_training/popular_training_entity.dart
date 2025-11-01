import 'package:equatable/equatable.dart';

final class PopularTrainingEntity extends Equatable {
  final String backgroundImage;
  final String title;
  final int numberOfTasks;
  final String level;
  final String levelId;
  final String muscleId;

  const PopularTrainingEntity({
    required this.backgroundImage,
    required this.title,
    required this.numberOfTasks,
    required this.level,
    required this.levelId,
    required this.muscleId,
  });

  @override
  List<Object?> get props => [
    backgroundImage,
    title,
    numberOfTasks,
    level,
    levelId,
    muscleId,
  ];
}
