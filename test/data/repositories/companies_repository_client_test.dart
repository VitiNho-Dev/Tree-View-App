import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tree_view_app/data/repositories/companies_repository.dart';
import 'package:tree_view_app/data/repositories/companies_repository_client.dart';
import 'package:tree_view_app/data/services/client.dart';
import 'package:tree_view_app/domain/models/companie.dart';
import 'package:tree_view_app/domain/models/location.dart';
import 'package:tree_view_app/utils/result.dart';

import '../../response_mock/response.dart';

class MockClient extends Mock implements Client {}

void main() {
  late Client client;
  late CompaniesRepository repository;

  setUp(() {
    client = MockClient();
    repository = CompaniesRepositoryClient(client: client);
  });

  group('Companies repository test', () {
    test('Should return a Map when client response is Ok', () async {
      when(
        () => client.getCompanies(),
      ).thenAnswer(
        (_) async => Result.ok(responseMock),
      );

      final result = await repository.getCompanies();

      expect(result, isA<Ok<List<Companie>>>());
      verify(() => client.getCompanies()).called(1);
    });

    test('Should return a Map with Locations data', () async {
      when(
        () => client.getCompanies(),
      ).thenAnswer(
        (_) async => Result.ok(responseMock),
      );

      await repository.getCompanies();

      final result = await repository.getLocations('662fd0ee639069143a8fc387');

      expect(result, isA<Ok<List<Location>>>());
    });

    test('Should return a Error when client response is Error', () async {
      when(
        () => client.getCompanies(),
      ).thenAnswer(
        (_) async => Result.error(
          Exception('Failed request'),
        ),
      );

      final result = await repository.getCompanies();

      expect(result, isA<Error<List<Companie>>>());
      verify(() => client.getCompanies()).called(1);
    });
  });
}
