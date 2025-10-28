import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:fitness_app/data/data_source/reset_password/remote_data_source/remote_data_source.dart';
import 'package:fitness_app/data/repositories/reset_password/reset_password_repository_impl.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_repository_impl_test.mocks.dart';

@GenerateMocks([ResetPasswordRemoteDataSource])
void main() {
  test(
    'when call resetPassword it should be called successfully from LoginRemoteDataSource',
    () async {
      final mockResetPasswordRemoteDataSource =
          MockResetPasswordRemoteDataSource();
      final repository = ResetPasswordRepositoryImpl(
        mockResetPasswordRemoteDataSource,
      );
      final ResetPasswordRequestEntity requestEntity =
          const ResetPasswordRequestEntity(email: "peterrafek36@gmail.com");
      final ResetPasswordResponse resetPasswordResponse = ResetPasswordResponse(
        message: "success",
      );
      final expectedResponse = resetPasswordResponse;
      final expectedResult = Success<ResetPasswordResponse>(expectedResponse);
      provideDummy<Result<ResetPasswordResponse>>(expectedResult);
      when(
        mockResetPasswordRemoteDataSource.resetPassword(request: requestEntity),
      ).thenAnswer((_) async => expectedResult);

      final result = await repository.resetPassword(request: requestEntity);
      expect(result, isA<Success<void>>());
      verify(
        mockResetPasswordRemoteDataSource.resetPassword(request: requestEntity),
      ).called(1);
    },
  );
}
