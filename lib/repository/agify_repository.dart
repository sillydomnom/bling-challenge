import 'dart:developer';

import 'api/agify_api_client.dart';

class AgifyRepository {
  final AgifyApiClient _apiClient;

  AgifyRepository({
    required AgifyApiClient apiClient,
  }) : _apiClient = apiClient;

  Future<int> getAgeForName({required String name}) async {
    final agifyDto = await _apiClient.retrieveAgeForName(name);

    return agifyDto.age;
  }
}
