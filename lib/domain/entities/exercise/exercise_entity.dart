import 'package:equatable/equatable.dart';

class ExerciseEntity extends Equatable {
  final String? id;
  final String? exercise;
  final String? shortYoutubeDemonstration;
  final String? inDepthYoutubeExplanation;
  final String? difficultyLevel;
  final String? targetMuscleGroup;
  final String? primeMoverMuscle;
  final String? secondaryMuscle;
  final String? tertiaryMuscle;
  final String? primaryEquipment;
  final int? primaryItems;
  final String? secondaryEquipment;
  final int? secondaryItems;
  final String? posture;
  final String? singleOrDoubleArm;
  final String? continuousOrAlternatingArms;
  final String? grip;
  final String? loadPositionEnding;
  final String? continuousOrAlternatingLegs;
  final String? footElevation;
  final String? combinationExercises;
  final String? movementPattern1;
  final String? movementPattern2;
  final String? movementPattern3;
  final String? planeOfMotion1;
  final String? planeOfMotion2;
  final String? planeOfMotion3;
  final String? bodyRegion;
  final String? forceType;
  final String? mechanics;
  final String? laterality;
  final String? primaryExerciseClassification;
  final String? shortYoutubeDemonstrationLink;
  final String? inDepthYoutubeExplanationLink;

  const ExerciseEntity({
    this.id,
    this.exercise,
    this.shortYoutubeDemonstration,
    this.inDepthYoutubeExplanation,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.secondaryMuscle,
    this.tertiaryMuscle,
    this.primaryEquipment,
    this.primaryItems,
    this.secondaryEquipment,
    this.secondaryItems,
    this.posture,
    this.singleOrDoubleArm,
    this.continuousOrAlternatingArms,
    this.grip,
    this.loadPositionEnding,
    this.continuousOrAlternatingLegs,
    this.footElevation,
    this.combinationExercises,
    this.movementPattern1,
    this.movementPattern2,
    this.movementPattern3,
    this.planeOfMotion1,
    this.planeOfMotion2,
    this.planeOfMotion3,
    this.bodyRegion,
    this.forceType,
    this.mechanics,
    this.laterality,
    this.primaryExerciseClassification,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });

  @override
  List<Object?> get props => [
    id,
    exercise,
    difficultyLevel,
    primeMoverMuscle,
    primaryEquipment,
    bodyRegion,
    shortYoutubeDemonstrationLink,
  ];
}
