import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tree_view_app/data/services/api_client.dart';
import 'package:tree_view_app/utils/errors/custom_errors.dart';
import 'package:tree_view_app/utils/errors/error_messages.dart';
import 'package:tree_view_app/utils/http_client.dart';
import 'package:tree_view_app/utils/result.dart';

class HttpClientMock extends Mock implements DioHttp {}

void main() {
  late HttpClient httpClient;
  late ApiClient apiClient;

  setUp(() {
    httpClient = HttpClientMock();
    apiClient = ApiClient(httpClient: httpClient);
  });

  void mockHttpClientResponse({
    required int statusCode,
    required dynamic data,
  }) {
    when(
      () => httpClient.get(any()),
    ).thenAnswer((_) async => HttpResponse(data: data, statusCode: statusCode));
  }

  void mockHttpClientError(Exception exception) {
    when(() => httpClient.get(any())).thenThrow(exception);
  }

  group('ApiClient', () {
    test('should return a error when the status code is different from 200',
        () async {
      mockHttpClientResponse(statusCode: 500, data: '');

      final response = await apiClient.getCompanies();

      expect(response, isA<Error>());
      final error = (response as Error).error as ApiError;
      expect(error.message, ErrorMessages.onServer);

      verify(() => httpClient.get(any())).called(1);
    });

    test('should return a error with data is empty', () async {
      mockHttpClientResponse(statusCode: 200, data: "{}");

      final response = await apiClient.getCompanies();

      expect(response, isA<Error>());
      final error = (response as Error).error as ApiError;
      expect(error.message, ErrorMessages.emptyResponse);

      verify(() => httpClient.get(any())).called(1);
    });

    test('should return a Map when data is ok', () async {
      mockHttpClientResponse(statusCode: 200, data: '{"data": "[]"}');

      final response = await apiClient.getCompanies();

      expect(response, isA<Ok<Map<String, dynamic>>>());
      final data = (response as Ok<Map<String, dynamic>>).value;
      expect(data["data"], isNotEmpty);

      verify(() => httpClient.get(any())).called(1);
    });

    test('should return an error when a ClientHttpError occurs', () async {
      mockHttpClientError(ClientHttpError(message: ErrorMessages.onServer));

      final result = await apiClient.getCompanies();

      expect(result, isA<Error>());
      final error = (result as Error).error as ClientHttpError;
      expect(error.message, ErrorMessages.onServer);

      verify(() => httpClient.get(any())).called(1);
    });

    test('should return an error when an unexpected error occurs', () async {
      mockHttpClientError(UnexpectedError(message: ErrorMessages.unexpected));

      final result = await apiClient.getCompanies();

      expect(result, isA<Error>());
      final error = (result as Error).error as UnexpectedError;
      expect(error.message, ErrorMessages.unexpected);

      verify(() => httpClient.get(any())).called(1);
    });
  });
}
