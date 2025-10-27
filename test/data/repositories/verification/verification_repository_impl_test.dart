import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/data/data_source/verification/remote_data_source/remote_data_source.dart';
import 'package:fitness_app/data/repositories/verification/verification_repository_impl.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verification_repository_impl_test.mocks.dart';

@GenerateMocks([VerificationRemoteDataSource])
void main() {
  test(
    'when call Verification it should be called successfully from LoginRemoteDataSource',
    () async {
      final mockVerificationRemoteDataSource =
          MockVerificationRemoteDataSource();
      final repository = VerificationRepositoryImpl(
        mockVerificationRemoteDataSource,
      );
      final VerificationRequestEntity requestEntity =
          const VerificationRequestEntity(resetCode: "123456");
      final VerificationResponse verificationResponse = VerificationResponse(
        status: "success",
      );
      final expectedResponse = verificationResponse;
      final expectedResult = Success<VerificationResponse>(expectedResponse);
      provideDummy<Result<VerificationResponse>>(expectedResult);
      when(
        mockVerificationRemoteDataSource.verificationCode(
          request: requestEntity,
        ),
      ).thenAnswer((_) async => expectedResult);

      final result = await repository.verificationCode(request: requestEntity);
      expect(result, isA<Success<void>>());
      verify(
        mockVerificationRemoteDataSource.verificationCode(
          request: requestEntity,
        ),
      ).called(1);
    },
  );
}
