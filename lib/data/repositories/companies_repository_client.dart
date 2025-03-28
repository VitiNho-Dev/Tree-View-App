import '../../domain/models/asset.dart';
import '../../domain/models/companie.dart';
import '../../domain/models/component.dart';
import '../../domain/models/location.dart';
import '../../utils/errors/custom_errors.dart';
import '../../utils/errors/error_messages.dart';
import '../../utils/result.dart';
import '../services/api_client.dart';

typedef ReturnMap = Map<String, dynamic>;

abstract interface class CompaniesRepository {
  Future<Result<List<Companie>>> getCompanies();
  Future<Result<List<Location>>> getLocations(String id);
  Future<Result<List<Asset>>> getAssets(String id);
  Result<List<Component>> getComponents();
}

class CompaniesRepositoryClient implements CompaniesRepository {
  final ApiClient _client;

  CompaniesRepositoryClient({
    required ApiClient client,
  }) : _client = client;

  late final ReturnMap _response;

  @override
  Future<Result<List<Companie>>> getCompanies() async {
    try {
      final result = await _client.getCompanies();

      if (result is Error) {
        return Result.error((result as Error).error);
      }

      _response = (result as Ok<Map<String, dynamic>>).value;

      final companiesData = _response['companies'];

      if (companiesData is! List || companiesData.isEmpty) {
        return Result.ok([]);
      }

      final companies = List<ReturnMap>.from(companiesData) //
          .map(Companie.fromJson)
          .toList();

      return Result.ok(companies);
    } catch (e) {
      return Result.error(UnexpectedError(message: ErrorMessages.unexpected));
    }
  }

  @override
  Future<Result<List<Location>>> getLocations(String id) async {
    if (id.isEmpty) {
      return Result.error(RepositoryError(message: ErrorMessages.invalidID));
    }

    final result = _response[id]['locations'];
    final locations = List<ReturnMap>.from(result) //
        .map(Location.fromJson)
        .toList();

    if (locations.isEmpty) {
      return Result.ok([]);
    }

    return Result.ok(locations);
  }

  final _componentsMap = <ReturnMap>[];

  @override
  Future<Result<List<Asset>>> getAssets(String id) async {
    if (id.isEmpty) {
      return Result.error(RepositoryError(message: ErrorMessages.invalidID));
    }

    final result = _response[id]['assets'];

    final assetsMap = <ReturnMap>[];
    for (var item in result) {
      if (item.containsKey('sensorType') && item['sensorType'] != null) {
        _componentsMap.add(item);
      } else {
        assetsMap.add(item);
      }
    }

    final assets = List<ReturnMap>.from(assetsMap).map(Asset.fromJson).toList();

    return Result.ok(assets);
  }

  @override
  Result<List<Component>> getComponents() {
    final components = List<ReturnMap>.from(_componentsMap) //
        .map(Component.fromJson)
        .toList();

    _componentsMap.clear();

    return Result.ok(components);
  }
}
