import 'dart:convert';
import 'dart:developer';

import '../../utils/errors/custom_errors.dart';
import '../../utils/errors/error_messages.dart';
import '../../utils/http_client.dart';
import '../../utils/result.dart';

const String baseUrl =
    'https://raw.githubusercontent.com/tractian/challenges/refs/heads/main/assets/api-data.json';

class ApiClient {
  final HttpClient _httpClient;

  const ApiClient({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  Future<Result<Map<String, dynamic>>> getCompanies() async {
    try {
      final response = await _httpClient.get(baseUrl);

      if (response.statusCode != 200) {
        return Result.error(ApiError(message: ErrorMessages.onServer));
      }

      final data = jsonDecode(response.data) as Map<String, dynamic>;

      if (data.isEmpty) {
        return Result.error(ApiError(message: ErrorMessages.emptyResponse));
      }

      return Result.ok(data);
    } on ClientHttpError catch (error, stackTrace) {
      log('ClientHttpError: ${error.toString()}', stackTrace: stackTrace);

      return Result.error(ClientHttpError(message: ErrorMessages.onServer));
    } catch (error, stackTrace) {
      log('Unexpected error: ${error.toString()}', stackTrace: stackTrace);

      return Result.error(UnexpectedError(message: ErrorMessages.unexpected));
    }
  }
}
