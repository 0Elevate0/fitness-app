import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/verification/remote_data_source/remote_data_source_impl.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';
 import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../login/remote_data_source/login_remote_data_source_impl_test.mocks.dart';
@GenerateMocks([ApiClient,Connectivity])
void main() {
  test('when call verification it should be called successfully from apiClient', () async{

    final mockApiClient =MockApiClient();
    final mockConnectivity=MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    final dataSource=VerificationRemoteDataSourceImpl(mockApiClient);
    final VerificationRequestEntity requestEntity =
    const VerificationRequestEntity(resetCode:"123456" );
    final  expectedResponse = VerificationResponse(status:"status" );
    final expectedResult = Success(null);
    provideDummy<Result<void>>(expectedResult);

    when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
    when(
      mockApiClient.verificationCode(request: anyNamed("request")),
    ).thenAnswer((_) async => expectedResponse);

     final result =await dataSource.verificationCode(request: requestEntity);
     expect(result, isA<Success<void>>());
    verify(
      mockApiClient.verificationCode(request: anyNamed("request")),
    ).called(1);
  });

  test('when there is no internet, it should return Failure', () async {
    // Arrange
    final mockApiClient = MockApiClient();
    final mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    final dataSource = VerificationRemoteDataSourceImpl(mockApiClient);
    final VerificationRequestEntity requestEntity =
    const VerificationRequestEntity(resetCode: "123456");
    final expectedResult = Failure<void>(responseException:const ResponseException(message: "No Internet Connection"));
    provideDummy<Result<void>>(expectedResult);

    when(
      mockedConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.none]);

    // Act
    final result = await dataSource.verificationCode(request: requestEntity);

    // Assert
    expect(result, isA<Failure<void>>());
    verifyNever(mockApiClient.verificationCode(request: anyNamed("request")));
  },
  );

  test('when api throws exception, it should return Failure', () async {
    // Arrange
    final mockApiClient = MockApiClient();
    final mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    final dataSource = VerificationRemoteDataSourceImpl(mockApiClient);
    final VerificationRequestEntity requestEntity =
    const VerificationRequestEntity(resetCode: "123456");

    final expectedResult = Failure<void>( responseException:
    const ResponseException(message:"Server Error" ));
    provideDummy<Result<void>>(expectedResult);

    when(
      mockedConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(
      mockApiClient.verificationCode(request: anyNamed("request")),
    ).thenThrow(Exception("Internal Server Error"));

    // Act
    final result = await dataSource.verificationCode(request: requestEntity);

    // Assert
    expect(result, isA<Failure<void>>());
    verify(mockApiClient.verificationCode(request: anyNamed("request"))).called(1);
  },
  );
}