import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/food_details_argument/food_details_argument.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/use_cases/meal_details/get_meal_details_use_case.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_intent.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@injectable
class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  final GetMealDetailsUseCase _getMealDetailsUseCase;
  FoodDetailsCubit(this._getMealDetailsUseCase)
    : super(const FoodDetailsState());
  final List<String> _mealIngredients = [];
  final List<String> _mealMeasures = [];
  late YoutubePlayerController? youtubePlayerController;

  Future<void> doIntent({required FoodDetailsIntent intent}) async {
    switch (intent) {
      case FoodDetailsInitializationIntent():
        await _onInit(foodDetailsArgument: intent.foodDetailsArgument);
        break;
      case OpenYoutubeVideoIntent():
        _initializeYoutubeContent(youtubeUrl: intent.youtubeUrl);
        break;
      case CloseYoutubeVideoIntent():
        _closeYoutube();
        break;
    }
  }

  Future<void> _onInit({
    required FoodDetailsArgument foodDetailsArgument,
  }) async {
    _getRecommendedMealsList(foodDetailsArgument: foodDetailsArgument);
    await _fetchMealDetails(mealId: foodDetailsArgument.mealId);
  }

  Future<void> _fetchMealDetails({required String mealId}) async {
    emit(state.copyWith(mealsDetailsStatus: const StateStatus.loading()));
    final result = await _getMealDetailsUseCase.invoke(mealId: mealId);
    if (isClosed) return;
    switch (result) {
      case Success<MealDetailsEntity?>():
        _initializeMealIngredientsAndMeasures(mealDetails: result.data);
        emit(
          state.copyWith(
            mealsDetailsStatus: StateStatus.success(result.data),
            mealMeasures: _mealMeasures,
            mealIngredients: _mealIngredients,
          ),
        );
        break;
      case Failure<MealDetailsEntity?>():
        emit(
          state.copyWith(
            mealsDetailsStatus: StateStatus.failure(result.responseException),
          ),
        );
        emit(state.copyWith(mealsDetailsStatus: const StateStatus.initial()));
    }
  }

  void _initializeYoutubeContent({required String youtubeUrl}) {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(youtubeUrl) ?? "",
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        hideControls: false,
      ),
    );
    emit(state.copyWith(isYoutubeVideoOpened: true));
  }

  void _closeYoutube() {
    youtubePlayerController?.dispose();
    emit(state.copyWith(isYoutubeVideoOpened: false));
  }

  void _getRecommendedMealsList({
    required FoodDetailsArgument foodDetailsArgument,
  }) {
    final recommendedMeals = foodDetailsArgument.mealsData
        .where((meal) => meal.id != foodDetailsArgument.mealId)
        .toList();
    emit(
      state.copyWith(
        allCategoryMeals: foodDetailsArgument.mealsData,
        mealsRecommendation: recommendedMeals,
      ),
    );
  }

  void _initializeMealIngredientsAndMeasures({
    required MealDetailsEntity? mealDetails,
  }) {
    _mealIngredients.clear();
    _mealMeasures.clear();
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient1,
      mealMeasure: mealDetails?.mealMeasure1,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient2,
      mealMeasure: mealDetails?.mealMeasure2,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient3,
      mealMeasure: mealDetails?.mealMeasure3,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient4,
      mealMeasure: mealDetails?.mealMeasure4,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient5,
      mealMeasure: mealDetails?.mealMeasure5,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient6,
      mealMeasure: mealDetails?.mealMeasure6,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient7,
      mealMeasure: mealDetails?.mealMeasure7,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient8,
      mealMeasure: mealDetails?.mealMeasure8,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient9,
      mealMeasure: mealDetails?.mealMeasure9,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient10,
      mealMeasure: mealDetails?.mealMeasure10,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient11,
      mealMeasure: mealDetails?.mealMeasure11,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient12,
      mealMeasure: mealDetails?.mealMeasure12,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient13,
      mealMeasure: mealDetails?.mealMeasure13,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient14,
      mealMeasure: mealDetails?.mealMeasure14,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient15,
      mealMeasure: mealDetails?.mealMeasure15,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient16,
      mealMeasure: mealDetails?.mealMeasure16,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient17,
      mealMeasure: mealDetails?.mealMeasure17,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient18,
      mealMeasure: mealDetails?.mealMeasure18,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient19,
      mealMeasure: mealDetails?.mealMeasure19,
    );
    _addMealIngredientAndeMeasure(
      mealIngredient: mealDetails?.mealIngredient20,
      mealMeasure: mealDetails?.mealMeasure20,
    );
  }

  void _addMealIngredientAndeMeasure({
    String? mealIngredient,
    String? mealMeasure,
  }) {
    if ((mealIngredient?.isNotEmpty ?? false) &&
        (mealMeasure?.isNotEmpty ?? false)) {
      _mealIngredients.add(mealIngredient!);
      _mealMeasures.add(mealMeasure!);
    }
  }
}
