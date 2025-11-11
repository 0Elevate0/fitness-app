import 'package:fitness_app/domain/entities/food_details_argument/food_details_argument.dart';

sealed class FoodDetailsIntent {
  const FoodDetailsIntent();
}

final class FoodDetailsInitializationIntent extends FoodDetailsIntent {
  final FoodDetailsArgument foodDetailsArgument;
  const FoodDetailsInitializationIntent({required this.foodDetailsArgument});
}

final class OpenYoutubeVideoIntent extends FoodDetailsIntent {
  final String youtubeUrl;
  const OpenYoutubeVideoIntent({required this.youtubeUrl});
}

final class CloseYoutubeVideoIntent extends FoodDetailsIntent {
  const CloseYoutubeVideoIntent();
}
