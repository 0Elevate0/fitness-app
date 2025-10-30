import 'package:equatable/equatable.dart';

class MealEntity extends Equatable {

  final String? strMeal;

  final String? strMealThumb;

  final String? idMeal;

  const MealEntity ({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    strMeal,
    strMealThumb,
    idMeal,
  ];



}