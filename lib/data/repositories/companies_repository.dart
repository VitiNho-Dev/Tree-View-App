import '../../domain/models/companie.dart';
import '../../domain/models/location.dart';
import '../../utils/result.dart';

abstract class CompaniesRepository {
  Future<Result<List<Companie>>> getCompanies();
  Future<Result<List<Location>>> getLocations(String id);
}
