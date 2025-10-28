import 'package:equatable/equatable.dart';

final class IngredientMeasureEntity extends Equatable {
  final String ingredient;
  final String measure;

  const IngredientMeasureEntity({
    required this.ingredient,
    required this.measure,
  });

  @override
  List<Object?> get props => [ingredient, measure];
}
