import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tree_view_app/data/services/client.dart';
import 'package:tree_view_app/utils/http_client.dart';
import 'package:tree_view_app/utils/result.dart';

class HttpClientMock extends Mock implements DioHttp {}

void main() {
  late HttpClient httpClient;
  late Client client;

  setUp(() {
    httpClient = HttpClientMock();
    client = Client(httpClient: httpClient);
  });

  group('Client Test', () {
    test('Should return JSON from API if status code is 200', () async {
      final mockResponse = Response(
        data: {'teste': '1'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(
        () => httpClient.get(any()),
      ).thenAnswer(
        (_) async => mockResponse,
      );

      final response = await client.getCompanies();

      expect(response, isA<Ok<Map<String, dynamic>>>());
      verify(() => httpClient.get(any())).called(1);
    });
  });
}
