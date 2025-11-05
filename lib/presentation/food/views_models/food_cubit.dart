import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_by_category/meal_entity.dart';
import 'package:fitness_app/domain/use_cases/meal_by_category/meal_by_category_use_case.dart';
import 'package:fitness_app/presentation/food/views_models/food_intent.dart';
import 'package:fitness_app/presentation/food/views_models/food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodCubit extends Cubit<FoodState>{
  final GetMealByCategoryUseCase _getMealByCategoryUseCase;
   FoodCubit(this._getMealByCategoryUseCase):super(const FoodState());
   Future<void>doIntent({required FoodIntent intent})async{
     switch(intent){
       case FoodInitializationIntent():{}
       case ChangeMealByCategory():
       {
         await _fetchMealsByCategory(categoryName:intent.categoryName);}

         
     }
     
   }



   Future<void>_fetchMealsByCategory({required String categoryName})async{
     emit(state.copyWith(mealsByCategoryStatus: const StateStatus.loading()));
     final result=await _getMealByCategoryUseCase.invoke(categoryName);
     if(isClosed)return;
     switch(result){
       case Success<List<MealEntity>>():
         emit(state.copyWith(mealsByCategoryStatus: StateStatus.success(result.data)));
          break;
       case Failure<List<MealEntity>>():
          emit(state.copyWith(mealsByCategoryStatus: StateStatus.failure(result.responseException)));
          emit(state.copyWith(mealsByCategoryStatus: const StateStatus.initial()));
     }

   }
   

}