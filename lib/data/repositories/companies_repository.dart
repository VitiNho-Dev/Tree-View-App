import '../../domain/models/companie.dart';
import '../../utils/result.dart';

abstract class CompaniesRepository {
  Future<Result<List<Companie>>> getCompanies();
}
