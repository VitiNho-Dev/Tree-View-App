import '../../utils/errors.dart';
import '../../utils/http_client.dart';
import '../../utils/result.dart';

class Client {
  final HttpClient _httpClient;

  const Client({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  Future<Result<Map<String, dynamic>>> getCompanies() async {
    try {
      final response = await _httpClient.get(
        'https://raw.githubusercontent.com/tractian/challenges/refs/heads/main/assets/api-data.json',
      );

      if (response.statusCode == 200) {
        return Result.ok(response.data);
      } else {
        return Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
