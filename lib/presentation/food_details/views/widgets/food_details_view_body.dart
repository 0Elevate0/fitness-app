import 'package:fitness_app/presentation/food_details/views/widgets/food_description_section.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/food_ingredients_section.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/food_recommendation_grid_view.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/loading_food_details.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_cubit.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_intent.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/dialogs/dialogs.dart';
import 'package:fitness_app/utils/dialogs/youtube_dialog_content.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDetailsViewBody extends StatelessWidget {
  const FoodDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final foodDetailsCubit = BlocProvider.of<FoodDetailsCubit>(context);
    return BlocListener<FoodDetailsCubit, FoodDetailsState>(
      listenWhen: (previous, current) =>
          current.mealsDetailsStatus.isFailure ||
          current.isYoutubeVideoOpened ||
          (previous.isYoutubeVideoOpened && !current.isYoutubeVideoOpened),
      listener: (context, state) {
        if (state.mealsDetailsStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.mealsDetailsStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.isYoutubeVideoOpened) {
          Dialogs.customDialog(
            context: context,
            content: YoutubeDialogContent(
              controller: foodDetailsCubit.youtubePlayerController!,
              onBackTapped: () => foodDetailsCubit.doIntent(
                intent: const CloseYoutubeVideoIntent(),
              ),
            ),
            isBarrierDismissible: false,
          );
        } else if (!state.isYoutubeVideoOpened) {
          Navigator.of(context).pop();
        }
      },
      child: BlurredLayerView(
        child: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
          builder: (context, state) {
            if (state.mealsDetailsStatus.isSuccess) {
              final mealData = state.mealsDetailsStatus.data;
              return CustomScrollView(
                slivers: [
                  FoodDescriptionSection(mealData: mealData),
                  FoodIngredientsSection(mealData: mealData),
                  const FoodRecommendationGridView(),
                ],
              );
            } else {
              return const LoadingFoodDetails();
            }
          },
        ),
      ),
    );
  }
}
