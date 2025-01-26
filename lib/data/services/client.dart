import '../../domain/models/companie.dart';
import '../../utils/errors.dart';
import '../../utils/http_client.dart';
import '../../utils/result.dart';

class Client {
  final HttpClient _httpClient;

  const Client(this._httpClient);

  Future<Result<List<Companie>>> getCompanies() async {
    try {
      final response = await _httpClient.get(
          'https://raw.githubusercontent.com/tractian/challenges/refs/heads/main/assets/api-data.json');
      if (response.statusCode == 200) {
        final companies = response.data['companies'];
        return Result.ok(
          List<Map<String, dynamic>>.from(companies)
              .map(Companie.fromJson)
              .toList(),
        );
      } else {
        return Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
