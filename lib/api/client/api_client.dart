import 'package:dio/dio.dart';
import 'package:fitness_app/api/requests/forget_password_request/forget_password_request_model.dart';
import 'package:fitness_app/api/requests/login_request/login_request_model.dart';
import 'package:fitness_app/api/requests/register_request/register_request_model.dart';
import 'package:fitness_app/api/requests/reset_password_request/reset_password_request_model.dart';
import 'package:fitness_app/api/requests/verification_request/verification_request_model.dart';
import 'package:fitness_app/api/responses/all_muscles_by_muscle_group_response/all_muscles_by_muscle_group_response.dart';
import 'package:fitness_app/api/responses/all_muscles_group_response/all_muscles_group_response.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/api/responses/login_response/login_response.dart';
import 'package:fitness_app/api/responses/meal_details_response/meal_details_response.dart';
import 'package:fitness_app/api/responses/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/api/responses/meals_list_response/meals_list_response.dart';
import 'package:fitness_app/api/responses/muscles_recommendation_response/muscles_recommendation_response.dart';
import 'package:fitness_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:fitness_app/api/responses/splash_response/splash_response.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(Endpoints.forgotPassword)
  Future<ForgetPasswordResponse> forgotPassword({
    @Body() required ForgetPasswordRequestModel request,
  });

  @POST(Endpoints.verifyResetCode)
  Future<VerificationResponse> verificationCode({
    @Body() required VerificationRequestModel request,
  });

  @PUT(Endpoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword({
    @Body() required ResetPasswordRequestModel request,
  });

  @POST(Endpoints.signup)
  Future<void> register({@Body() required RegisterRequestModel request});

  @POST(Endpoints.login)
  Future<LoginResponse> login({@Body() required LoginRequestModel request});

  @GET(Endpoints.getLoggedUserData)
  Future<SplashResponse> getUserData({
    @Header("Authorization") required String token,
  });

  @GET(Endpoints.getRecommendationRandomMuscles)
  Future<MusclesRecommendationResponse> getRecommendationTodayMuscles({
    @Header("accept-language") required String currentLanguage,
  });

  @GET(Endpoints.getAllMusclesGroup)
  Future<AllMusclesGroupResponse> getAllMusclesGroup({
    @Header("accept-language") required String currentLanguage,
  });

  @GET(Endpoints.getAllMusclesByMuscleGroup)
  Future<AllMusclesByMuscleGroupResponse> getAllMusclesByMuscleGroup({
    @Header("accept-language") required String currentLanguage,
    @Path("muscleGroupId") required String muscleGroupId,
  });

  @GET(Endpoints.getAllMealsCategories)
  Future<MealsCategoriesResponse> getAllMealsCategories();

  @GET(Endpoints.getMealsByCategory)
  Future<MealsListResponse> getMealsByCategory(@Query("c") String category);

  @GET(Endpoints.getMealDetails)
  Future<MealDetailsResponse> getMealDetails({
    @Query("i") required String mealId,
  });
}
