import '../../domain/models/companie.dart';
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
}
