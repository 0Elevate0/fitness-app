import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/data/data_source/forget_password/remote_data_source/remote_data_source.dart';
import 'package:fitness_app/data/repositories/forget_password/forget_password_repository_impl.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'forget_password_repository_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordRemoteDataSource])
void main() {
  test(
    'when call forgetPassword it should be called successfully from LoginRemoteDataSource',
        () async {
      final mockForgetPasswordRemoteDataSource =
      MockForgetPasswordRemoteDataSource();
      final repository = ForgetPasswordRepositoryImpl(
        mockForgetPasswordRemoteDataSource,
      );
      final ForgetPasswordRequestEntity requestEntity =
      const ForgetPasswordRequestEntity(email: "peterrafek36@gmail.com");
      final ForgetPasswordResponse forgetPasswordResponse = ForgetPasswordResponse(
          message: "success");
      final expectedResponse = forgetPasswordResponse;
      final expectedResult = Success<ForgetPasswordResponse>(expectedResponse);
      provideDummy<Result<ForgetPasswordResponse>>(expectedResult);
      when(
        mockForgetPasswordRemoteDataSource.forgetPassword(
          request: requestEntity,
        ),
      ).thenAnswer((_) async => expectedResult);

      final result = await repository.forgetPassword(request: requestEntity);
      expect(result, isA<Success<void>>());
      verify(
        mockForgetPasswordRemoteDataSource.forgetPassword(
          request: requestEntity,
        ),
      ).called(1);
    },
  );
}
