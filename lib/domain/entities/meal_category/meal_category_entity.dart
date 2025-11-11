import 'package:equatable/equatable.dart';

final class MealCategoryEntity extends Equatable {
  final String? idCategory;
  final String? strCategory;
  final String? strCategoryThumb;
  final String? strCategoryDescription;

  const MealCategoryEntity({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  @override
  List<Object?> get props => [
    idCategory,
    strCategory,
    strCategoryThumb,
    strCategoryDescription,
  ];
}
