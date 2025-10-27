import 'package:equatable/equatable.dart';

final class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.categoryTitle,
    required this.categoryImage,
  });
  final String categoryTitle;
  final String categoryImage;
  @override
  List<Object?> get props => [categoryTitle, categoryImage];
}
