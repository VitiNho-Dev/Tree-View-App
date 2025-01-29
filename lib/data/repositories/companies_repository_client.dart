import '../../domain/models/companie.dart';
import '../../domain/models/location.dart';
import '../../utils/result.dart';
import '../services/client.dart';
import 'companies_repository.dart';

typedef ReturnMap = Map<String, dynamic>;

class CompaniesRepositoryClient implements CompaniesRepository {
  final Client _client;

  CompaniesRepositoryClient({
    required Client client,
  }) : _client = client;

  late final ReturnMap _response;

  @override
  Future<Result<List<Companie>>> getCompanies() async {
    final result = await _client.getCompanies();

    switch (result) {
      case Ok<ReturnMap>():
        _response = result.value;
        final companiesData = _response['companies'];
        final companies = List<ReturnMap>.from(companiesData) //
            .map(Companie.fromJson)
            .toList();
        return Result.ok(companies);
      case Error<ReturnMap>():
        return Result.error(result.error);
    }
  }

  @override
  Future<Result<List<Location>>> getLocations(String id) async {
    final result = _response[id]['locations'];
    final locations = List<ReturnMap>.from(result) //
        .map(Location.fromJson)
        .toList();
    if (locations.isNotEmpty) {
      return Result.ok(locations);
    }

    return Result.error(Exception('List is empty'));
  }
}
