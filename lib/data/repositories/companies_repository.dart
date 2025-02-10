import '../../domain/models/asset.dart';
import '../../domain/models/companie.dart';
import '../../domain/models/component.dart';
import '../../domain/models/location.dart';
import '../../utils/result.dart';

abstract class CompaniesRepository {
  Future<Result<List<Companie>>> getCompanies();
  Future<Result<List<Location>>> getLocations(String id);
  Future<Result<List<Asset>>> getAssets(String id);
  Result<List<Component>> getComponents();
}
