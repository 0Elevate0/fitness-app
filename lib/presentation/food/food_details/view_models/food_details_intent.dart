import 'package:equatable/equatable.dart';

sealed class FoodDetailsIntent extends Equatable {
  const FoodDetailsIntent();
  @override
  List<Object?> get props => [];
}

final class GetFoodDetailsIntent extends FoodDetailsIntent {
  final String mealId;
  const GetFoodDetailsIntent({required this.mealId});

  @override
  List<Object?> get props => [mealId];
}